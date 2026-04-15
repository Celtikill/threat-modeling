#!/usr/bin/env bash
set -euo pipefail

# Security: Escape LaTeX special characters in strings
escape_latex() {
    local str="$1"
    # Escape LaTeX special characters
    str="${str//\\/\\textbackslash{}}"
    str="${str//\{/\\{}"
    str="${str//\}/\\}}"
    str="${str//\$/\\$}"
    str="${str//&/\\&}"
    str="${str//%/\\%}"
    str="${str//_/\\_}"
    str="${str//#/\\#}"
    str="${str//^/\\textasciicircum{}}"
    str="${str//~/\\textasciitilde{}}"
    printf '%s' "$str"
}

# Security: Validate paths to prevent directory traversal
validate_path() {
    local path="$1"
    local name="$2"
    local base_dir
    base_dir="$(cd "$(dirname "$0")/.." && pwd)"
    local resolved_path

    # Resolve to absolute path
    if [[ "$path" = /* ]]; then
        resolved_path="$(cd "$(dirname "$path")" 2>/dev/null && pwd)/$(basename "$path")"
    else
        resolved_path="$base_dir/$path"
    fi

    # Check for path traversal attempts
    if [[ ! "$resolved_path" =~ ^$base_dir ]]; then
        echo "Error: $name must be within repository: $path" >&2
        exit 1
    fi

    printf '%s' "$resolved_path"
}

# Validate and resolve input path
INPUT=$(validate_path "${1:?Usage: build-pdf.sh <input.md> [output.pdf]}" "input file")
OUTPUT="${2:-${INPUT%.md}.pdf}"
# Validate output path if explicitly provided
if [[ -n "${2:-}" ]]; then
    OUTPUT=$(validate_path "$2" "output file")
fi
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE="$SCRIPT_DIR/template.latex"
WORK_DIR=$(mktemp -d)

# Comprehensive cleanup function
cleanup() {
    if [[ -n "${WORK_DIR:-}" && -d "$WORK_DIR" ]]; then
        rm -rf "$WORK_DIR"
    fi
}

# Set up signal handlers for comprehensive cleanup
trap cleanup EXIT
trap cleanup INT TERM HUP

find_chrome() {
  # Honor existing override
  if [[ -n "${PUPPETEER_EXECUTABLE_PATH:-}" ]]; then
    if [[ -f "$PUPPETEER_EXECUTABLE_PATH" && -x "$PUPPETEER_EXECUTABLE_PATH" ]]; then
      return 0
    fi
    echo "Warning: PUPPETEER_EXECUTABLE_PATH set but not executable: $PUPPETEER_EXECUTABLE_PATH" >&2
  fi

  local -a candidates
  case "$(uname -s)" in
    Darwin)
      candidates=(
        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
        "/opt/homebrew/bin/chromium"
        "/usr/local/bin/chromium"
      )
      ;;
    Linux)
      candidates=(
        "/usr/bin/chromium"
        "/usr/bin/chromium-browser"
        "/usr/bin/google-chrome-stable"
        "/usr/bin/google-chrome"
        "/snap/bin/chromium"
      )
      ;;
    *)
      echo "Warning: unsupported OS for Chrome detection; mmdc may fail." >&2
      return 1
      ;;
  esac

  local candidate
  for candidate in "${candidates[@]}"; do
    if [[ -x "$candidate" ]]; then
      export PUPPETEER_EXECUTABLE_PATH="$candidate"
      return 0
    fi
  done

  echo "Warning: no Chrome/Chromium found; mmdc may fail. Set PUPPETEER_EXECUTABLE_PATH manually." >&2
  return 1
}

find_pdf_engine() {
  # Honor explicit override
  if [[ -n "${PDF_ENGINE:-}" ]]; then
    if command -v "$PDF_ENGINE" &>/dev/null; then
      return 0
    fi
    echo "Error: PDF_ENGINE set but not found: $PDF_ENGINE" >&2
    return 1
  fi

  local -a engines=("xelatex" "tectonic")
  local engine
  for engine in "${engines[@]}"; do
    if command -v "$engine" &>/dev/null; then
      PDF_ENGINE="$engine"
      return 0
    fi
  done

  echo "Error: no XeTeX-compatible PDF engine found (tried: xelatex, tectonic)." >&2
  echo "Install one of:" >&2
  echo "  macOS:  brew install --cask basictex  OR  brew install tectonic" >&2
  echo "  Debian: sudo apt install texlive-xetex" >&2
  return 1
}

# Sets global MAINFONT, MONOFONT, EMOJIFONT as side effects.
# Security: Escape LaTeX special characters in strings
find_fonts() {
  local -a main_candidates mono_candidates emoji_candidates
  case "$(uname -s)" in
    Darwin)
      main_candidates=("Helvetica Neue" "Helvetica" "DejaVu Sans")
      mono_candidates=("Menlo" "Monaco" "DejaVu Sans Mono")
      emoji_candidates=("Symbola")
      ;;
    *)
      main_candidates=("DejaVu Sans" "Liberation Sans" "Noto Sans")
      mono_candidates=("DejaVu Sans Mono" "Liberation Mono" "Noto Sans Mono")
      emoji_candidates=("Symbola")
      ;;
  esac

  # Cache fc-list output once (if fontconfig is available)
  local fc_cache=""
  if command -v fc-list &>/dev/null; then
    fc_cache=$(fc-list : family 2>/dev/null)
  fi

  local font

  # Main font
  if [[ -z "${MAINFONT:-}" ]]; then
    if [[ -n "$fc_cache" ]]; then
      for font in "${main_candidates[@]}"; do
        if printf '%s' "$fc_cache" | grep -qiF "$font"; then
          MAINFONT="$font"
          break
        fi
      done
    fi
    MAINFONT="${MAINFONT:-${main_candidates[0]}}"
  fi

  # Mono font
  if [[ -z "${MONOFONT:-}" ]]; then
    if [[ -n "$fc_cache" ]]; then
      for font in "${mono_candidates[@]}"; do
        if printf '%s' "$fc_cache" | grep -qiF "$font"; then
          MONOFONT="$font"
          break
        fi
      done
    fi
    MONOFONT="${MONOFONT:-${mono_candidates[0]}}"
  fi

  # Emoji font (optional — empty string if unavailable)
  EMOJIFONT="${EMOJIFONT:-}"
  if [[ -z "$EMOJIFONT" ]]; then
    if [[ -n "$fc_cache" ]]; then
      for font in "${emoji_candidates[@]}"; do
        if printf '%s' "$fc_cache" | grep -qiF "$font"; then
          EMOJIFONT="$font"
          break
        fi
      done
    fi
    if [[ -z "$EMOJIFONT" ]]; then
      echo "Warning: no emoji font found; emoji characters may not render." >&2
    fi
  fi
}

for cmd in mmdc pandoc; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "Error: required command '$cmd' not found. Install it and re-run." >&2
        exit 1
    fi
done

find_chrome || true    # Chrome is optional; mmdc will warn if absent
find_pdf_engine        # Required; exits non-zero if no engine found
find_fonts             # Sets MAINFONT, MONOFONT, EMOJIFONT

if [[ ! -f "$INPUT" ]]; then
    echo "Error: Input file not found: $INPUT" >&2
    exit 1
fi

if [[ ! -f "$TEMPLATE" ]]; then
    echo "Error: LaTeX template not found: $TEMPLATE" >&2
    exit 1
fi

# --- Extract and render mermaid blocks ---

TOTAL_BLOCKS=0
RENDERED_BLOCKS=0
IN_MERMAID=false
MERMAID_BUF=""

while IFS= read -r line; do
    if [[ "$IN_MERMAID" == false && "$line" =~ ^\`\`\`mermaid[[:space:]]*$ ]]; then
        IN_MERMAID=true
        MERMAID_BUF=""
        continue
    fi

    if [[ "$IN_MERMAID" == true ]]; then
        if [[ "$line" =~ ^\`\`\`[[:space:]]*$ ]]; then
            IN_MERMAID=false
            MMD_FILE="$WORK_DIR/diagram-${TOTAL_BLOCKS}.mmd"
            PNG_FILE="$WORK_DIR/diagram-${TOTAL_BLOCKS}.png"
            printf '%s\n' "$MERMAID_BUF" > "$MMD_FILE"

            echo "Rendering mermaid diagram ${TOTAL_BLOCKS}..." >&2
            if mmdc -i "$MMD_FILE" -o "$PNG_FILE" -b white -w 1200 -q; then
                RENDERED_BLOCKS=$((RENDERED_BLOCKS + 1))
            else
                echo "Warning: mmdc failed for diagram ${TOTAL_BLOCKS}, will use placeholder" >&2
            fi
            TOTAL_BLOCKS=$((TOTAL_BLOCKS + 1))
        else
            if [[ -n "$MERMAID_BUF" ]]; then
                MERMAID_BUF="${MERMAID_BUF}
${line}"
            else
                MERMAID_BUF="$line"
            fi
        fi
    fi
done < "$INPUT"

if [[ "$IN_MERMAID" == true ]]; then
    echo "Warning: unclosed mermaid block detected in '$INPUT'. The block will be dropped." >&2
fi

if [[ "$TOTAL_BLOCKS" -eq 0 ]]; then
    echo "No mermaid diagrams found; proceeding with pandoc directly." >&2
    PROCESSED="$INPUT"
else
    # Replace mermaid code blocks with image references in the markdown
    PROCESSED="$WORK_DIR/processed.md"
    IDX=0
    IN_MERMAID=false

    while IFS= read -r line; do
        if [[ "$IN_MERMAID" == false && "$line" =~ ^\`\`\`mermaid[[:space:]]*$ ]]; then
            IN_MERMAID=true
            continue
        fi

        if [[ "$IN_MERMAID" == true ]]; then
            if [[ "$line" =~ ^\`\`\`[[:space:]]*$ ]]; then
                IN_MERMAID=false
                PNG_FILE="$WORK_DIR/diagram-${IDX}.png"
                if [[ -f "$PNG_FILE" ]]; then
                    printf '%s\n' "![Diagram ${IDX}](${PNG_FILE})\\ " >> "$PROCESSED"
                else
                    printf '%s\n' "*[Diagram ${IDX} — rendering failed]*" >> "$PROCESSED"
                fi
                IDX=$((IDX + 1))
            fi
            # Skip mermaid source lines
        else
            printf '%s\n' "$line" >> "$PROCESSED"
        fi
    done < "$INPUT"

    echo "Replaced ${TOTAL_BLOCKS} mermaid block(s) (${RENDERED_BLOCKS} rendered) with images." >&2
fi

# --- Extract title from first H1 heading ---

TITLE=$(grep -m1 '^# ' "$INPUT" | sed 's/^# //')
if [[ -z "$TITLE" ]]; then
    TITLE="Threat Model"
fi
# Escape LaTeX special characters to prevent xelatex errors
TITLE=$(escape_latex "$TITLE")

# --- Build PDF ---

echo "Building PDF: $OUTPUT" >&2
pandoc_args=()
[[ -n "$EMOJIFONT" ]] && pandoc_args+=(-V "emojifont=$EMOJIFONT")

pandoc "$PROCESSED" \
    -o "$OUTPUT" \
    --template="$TEMPLATE" \
    --pdf-engine="$PDF_ENGINE" \
    -V "title=$TITLE" \
    -V "mainfont=$MAINFONT" \
    -V "monofont=$MONOFONT" \
    ${pandoc_args[@]+"${pandoc_args[@]}"}

echo "Done: $OUTPUT" >&2
