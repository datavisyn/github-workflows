#!/bin/bash

ls -lah /github/workspace
ls -lah /github/workspace/.github/linters
cat /github/workspace/hadolint.yaml

echo "$HOME"
echo "$HADOLINT_CONFIG"
echo "$HADOLINT_RECURSIVE"
echo "$@"

if [ -n "$HADOLINT_CONFIG" ]; then
  HADOLINT_CONFIG="-c ${HADOLINT_CONFIG}"
fi

if [ "$HADOLINT_RECURSIVE" = "true" ]; then
  shopt -s globstar

  filename="${!#}"
  # shellcheck disable=SC2124
  flags="${@:1:$#-1}"
  echo $flags
  echo $filename
  RESULTS=$(hadolint $HADOLINT_CONFIG $flags ./**/$filename)
else
  # shellcheck disable=SC2086
  RESULTS=$(hadolint $HADOLINT_CONFIG $@)
fi
FAILED=$?

if [ -n "$HADOLINT_OUTPUT" ]; then
  if [ -f "$HADOLINT_OUTPUT" ]; then
    HADOLINT_OUTPUT="$TMP_FOLDER/$HADOLINT_OUTPUT"
  fi
  echo "$RESULTS" > "$HADOLINT_OUTPUT"
fi

RESULTS="${RESULTS//$'\\n'/''}"

echo "results=$RESULTS" >> $GITHUB_OUTPUT

{ echo "HADOLINT_RESULTS<<EOF"; echo "$RESULTS"; echo "EOF"; } >> "$GITHUB_ENV"

[ -z "$HADOLINT_OUTPUT" ] || echo "Hadolint output saved to: $HADOLINT_OUTPUT"

exit $FAILED