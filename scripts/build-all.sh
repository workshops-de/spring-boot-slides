#!/usr/bin/env bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
RESET='\033[0m'

# Parse arguments
BASE_PREFIX=""
while [[ $# -gt 0 ]]; do
  case $1 in
    --base)
      BASE_PREFIX="$2"
      # Remove trailing slash if present
      BASE_PREFIX="${BASE_PREFIX%/}"
      shift 2
      ;;
    *)
      shift
      ;;
  esac
done

# Navigate to project root
cd "$(dirname "$0")/.." || exit 1

echo -e "${CYAN}Building all slide decks...${RESET}"
if [[ -n "$BASE_PREFIX" ]]; then
  echo -e "Base prefix: ${CYAN}$BASE_PREFIX${RESET}"
fi
echo ""

build_slide() {
  local FILE=$1

  # Extract frontmatter YAML (between first two ---)
  YAML=$(awk '/^---/{f=!f; next} f' "$FILE" | head -50)

  BASE=$(echo "$YAML" | awk -F': ' '/^base:/ {gsub(/^ +| +$/, "", $2); print $2}')
  OUT=$(echo "$YAML" | awk -F': ' '/^out:/ {gsub(/^ +| +$/, "", $2); print $2}')

  if [[ -n "$BASE" && -n "$OUT" ]]; then
    # Prepend base prefix if provided (for GitHub Pages subdirectory hosting)
    FULL_BASE="${BASE_PREFIX}${BASE}"

    echo -e "${GREEN}Building${RESET} $FILE"
    echo "   ➤ base: $FULL_BASE"
    echo "   ➤ out : $OUT"

    # Build from project root with full path
    npm exec -- slidev build "$FILE" --base "$FULL_BASE" --out "$OUT"

    echo ""
  else
    echo -e "${YELLOW}Skipping${RESET} $FILE (missing base or out in frontmatter)"
  fi
}

export_pdf() {
  local FILE=$1

  # Only export PDFs for lesson slides, not the index
  if [[ "$FILE" == *"/lessons/"* ]]; then
    # Get the lesson name from the directory
    local LESSON_DIR=$(dirname "$FILE")
    local LESSON_NAME=$(basename "$LESSON_DIR")
    local PDF_OUTPUT="dist/${LESSON_NAME}/slides.pdf"

    echo -e "${GREEN}Exporting PDF${RESET} $FILE"
    echo "   ➤ output: $PDF_OUTPUT"

    # Export to PDF using Slidev (into dist folder alongside HTML)
    npm exec -- slidev export "$FILE" --output "$PDF_OUTPUT" --timeout 60000 2>/dev/null

    if [[ -f "$PDF_OUTPUT" ]]; then
      echo -e "   ${GREEN}✓${RESET} PDF exported successfully"
    else
      echo -e "   ${YELLOW}⚠${RESET} PDF export failed (Playwright may not be installed)"
    fi

    echo ""
  fi
}

# Build root slides
for FILE in ./00-index.md; do
  if [[ -f "$FILE" ]]; then
    build_slide "$FILE"
  fi
done

# Build lesson slides and export PDFs
for FILE in ./lessons/*/*.md; do
  if [[ -f "$FILE" ]]; then
    build_slide "$FILE"
    export_pdf "$FILE"
  fi
done

# Create redirect index.html with correct base prefix
mkdir -p dist
REDIRECT_URL="${BASE_PREFIX}/00-index/"
cat > dist/index.html << EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="refresh" content="0; url=${REDIRECT_URL}">
  <title>Redirecting...</title>
</head>
<body>
  <p>Redirecting to <a href="${REDIRECT_URL}">slide decks</a>...</p>
</body>
</html>
EOF
echo -e "${GREEN}Created${RESET} dist/index.html (redirects to ${REDIRECT_URL})"

# Create root 404.html so deep links like /<deck>/presenter/1 work on GitHub Pages.
# Pages only serves the 404.html at the site root, but each deck is a separate SPA in
# its own subfolder (Slidev's own 404.html lands in dist/<deck>/ and is never used).
# This page loads the matching deck's index.html in place, so the URL stays intact and
# the deck's router opens the requested route.
cat > dist/404.html << EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Loading…</title>
  <script>
    (function () {
      var base = '${BASE_PREFIX}/';
      var path = location.pathname;
      var deck = path.indexOf(base) === 0 ? path.slice(base.length).split('/')[0] : '';
      function notFound() {
        document.title = 'Not found';
        document.body.innerHTML = '<h1>404</h1><p><a href="' + base + '">Back to the overview</a></p>';
      }
      if (!deck) { document.addEventListener('DOMContentLoaded', notFound); return; }
      fetch(base + deck + '/index.html')
        .then(function (r) { if (!r.ok) throw new Error(r.status); return r.text(); })
        .then(function (html) { document.open(); document.write(html); document.close(); })
        .catch(notFound);
    })();
  </script>
</head>
<body></body>
</html>
EOF
echo -e "${GREEN}Created${RESET} dist/404.html (loads the matching deck for deep links)"

echo ""
echo -e "${CYAN}Build complete!${RESET}"
