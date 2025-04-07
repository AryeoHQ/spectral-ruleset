#!/bin/bash

# ====================================================================================
# HELPERS
# ====================================================================================
# @description Checks if a command is installed. Exits if not found.
#
# @arg $1 name of the command to check for
# @arg $2 name of the brew package that installs the command
check_dependency() {
    if ! command -v $1 &> /dev/null; then
        echo $(red "Command \"$1\" could not be found. Please install with \"brew install $2\".")
        exit
    fi
}

# ====================================================================================
# DEPENDENCY CHECKS
# ====================================================================================
check_dependency fzf fzf

# ====================================================================================
# MAIN
# ====================================================================================
# remove existing temp ruleset, if exists
rm -f ./examples/specs/bundled/.spectral.yml

# select a rule
RULES=$(for f in rules/*.yml; do grep -h "^  [a-zA-Z-]\+:" "$f" | sed 's/://' | sed 's/^  //' | sed "s|^|$f#|"; done)
SELECTED=$(echo "$RULES" | fzf --height 40% --border --prompt="Select a rule to test: " --with-nth=2 -d '#')
if [ -z "$SELECTED" ]; then echo "No rule selected. Exiting."; exit 1; fi

# split file and rule name
RULE_FILE=$(echo "$SELECTED" | cut -d'#' -f1)
SELECTED_RULE=$(echo "$SELECTED" | cut -d'#' -f2)

# create temp ruleset
touch ./examples/specs/bundled/.spectral.yml
echo "rules:" >> ./examples/specs/bundled/.spectral.yml

# inject rule into ruleset
awk -v rule="  ${SELECTED_RULE}:" '
    $0 ~ rule {p=1; print; next}
    p && /^  [a-zA-Z-]+:/ {p=0; next}
    p {print}
' "$RULE_FILE" >> ./examples/specs/bundled/.spectral.yml

# test
npx @quobix/vacuum lint -d -r ./examples/specs/bundled/.spectral.yml ./examples/specs/bundled/Bundled.json

# clean up
rm -f ./examples/specs/bundled/.spectral.yml