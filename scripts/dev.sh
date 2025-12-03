#!/usr/bin/env bash

# Dynamic lesson development server
# Usage: ./scripts/dev.sh [lesson-number|all]
# Example: ./scripts/dev.sh        # Interactive menu
#          ./scripts/dev.sh 01     # Start lesson 01
#          ./scripts/dev.sh all    # Start slides.md (all lessons)

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
BOLD='\033[1m'
RESET='\033[0m'

# Navigate to project root
cd "$(dirname "$0")/.." || exit 1

LESSON_NUM="$1"

# Collect available lessons
declare -a LESSONS=()
declare -a LESSON_NAMES=()

for DIR in ./lessons/*/; do
  if [[ -d "$DIR" ]]; then
    BASENAME=$(basename "$DIR")
    NUM="${BASENAME%%-*}"
    NAME="${BASENAME#*-}"
    MD_FILE=$(find "$DIR" -maxdepth 1 -name "*.md" -type f | head -1)
    if [[ -n "$MD_FILE" ]]; then
      LESSONS+=("$NUM")
      LESSON_NAMES+=("$NAME")
    fi
  fi
done

# Check if slides.md exists for "all" option
HAS_SLIDES_MD=false
if [[ -f "./slides.md" ]]; then
  HAS_SLIDES_MD=true
fi

# Function to start a lesson
start_lesson() {
  local num="$1"

  # Pad single digit with leading zero
  if [[ ${#num} -eq 1 ]]; then
    num="0$num"
  fi

  local lesson_dir=$(find ./lessons -maxdepth 1 -type d -name "${num}-*" | head -1)

  if [[ -z "$lesson_dir" ]]; then
    echo -e "${RED}Error:${RESET} No lesson found starting with '${num}'"
    exit 1
  fi

  local slide_file=$(find "$lesson_dir" -maxdepth 1 -name "*.md" -type f | head -1)

  if [[ -z "$slide_file" ]]; then
    echo -e "${RED}Error:${RESET} No .md file found in $lesson_dir"
    exit 1
  fi

  local lesson_name=$(basename "$lesson_dir")
  echo -e "${CYAN}Starting development server for:${RESET} $lesson_name"
  echo -e "${CYAN}File:${RESET} $slide_file"
  echo ""

  npm exec -- slidev "$slide_file" --open
}

# Function to start all (slides.md)
start_all() {
  if [[ "$HAS_SLIDES_MD" == "true" ]]; then
    echo -e "${CYAN}Starting development server for:${RESET} All lessons (slides.md)"
    echo ""
    npm exec -- slidev slides.md --open
  else
    echo -e "${RED}Error:${RESET} slides.md not found in project root"
    echo -e "Create a slides.md file that imports all lessons to use this option."
    exit 1
  fi
}

# If argument provided, use it directly
if [[ -n "$LESSON_NUM" ]]; then
  if [[ "$LESSON_NUM" == "all" ]]; then
    start_all
  else
    start_lesson "$LESSON_NUM"
  fi
  exit 0
fi

# Interactive menu
echo ""
echo -e "${BOLD}${CYAN}📚 Workshop Slides - Development Server${RESET}"
echo ""
echo -e "Select a lesson to start:"
echo ""

# Show "All" option if slides.md exists
if [[ "$HAS_SLIDES_MD" == "true" ]]; then
  echo -e "  ${GREEN}0${RESET}) ${BOLD}All lessons${RESET} (slides.md) ${CYAN}[default]${RESET}"
fi

# Show individual lessons
for i in "${!LESSONS[@]}"; do
  echo -e "  ${GREEN}${LESSONS[$i]}${RESET}) ${LESSON_NAMES[$i]}"
done

echo ""
echo -e "  ${YELLOW}q${RESET}) Quit"
echo ""

# Read user input
read -p "Enter your choice [0]: " choice

# Default to "all" if empty and slides.md exists
if [[ -z "$choice" && "$HAS_SLIDES_MD" == "true" ]]; then
  choice="0"
fi

# Handle quit
if [[ "$choice" == "q" || "$choice" == "Q" ]]; then
  echo "Goodbye!"
  exit 0
fi

# Handle "0" or "all" for slides.md
if [[ "$choice" == "0" || "$choice" == "all" ]]; then
  start_all
  exit 0
fi

# Handle lesson number
if [[ "$choice" =~ ^[0-9]+$ ]]; then
  start_lesson "$choice"
else
  echo -e "${RED}Invalid choice:${RESET} $choice"
  exit 1
fi
