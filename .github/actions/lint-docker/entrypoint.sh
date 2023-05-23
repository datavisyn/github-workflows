#!/bin/bash

# copy matcher json file to home
cp /hadolint-matcher.json "$HOME/"
# remove matcher during cleanup
cleanup() {
    # shellcheck disable=SC2317
    echo "::remove-matcher owner=datavisyn/lint-docker::"
}
trap cleanup EXIT
echo "::add-matcher::$HOME/hadolint-matcher.json"


echo "$HOME"
echo "$HADOLINT_CONFIG"
echo "$HADOLINT_RECURSIVE"
echo "$@"

if [ -n "$HADOLINT_CONFIG" ]; then
  echo "####### Inside first if"
  HADOLINT_CONFIG="-c ${HADOLINT_CONFIG}"
fi

if [ "$HADOLINT_RECURSIVE" = "true" ]; then
  shopt -s globstar
  echo "####### Inside second if"
  filename="${!#}"
  # shellcheck disable=SC2124
  flags="${@:1:$#-1}"
  # shellcheck disable=SC2086
  RESULTS=$(hadolint -V $HADOLINT_CONFIG $flags ./**/$filename)
  echo "####### Inside second if, RESULTS= $RESULTS"
else
  # shellcheck disable=SC2086,SC2068
  RESULTS=$(hadolint -V $HADOLINT_CONFIG $@)
  echo "####### Inside second if/else, RESULTS= $RESULTS"
fi

FAILED=$?

if [ -n "$HADOLINT_OUTPUT" ]; then
  if [ -f "$HADOLINT_OUTPUT" ]; then
    HADOLINT_OUTPUT="$TMP_FOLDER/$HADOLINT_OUTPUT"
  fi
  echo "$RESULTS" > "$HADOLINT_OUTPUT"
fi

RESULTS="${RESULTS//$'\\n'/''}"

echo "results=$RESULTS" >> "$GITHUB_OUTPUT"

{ echo "HADOLINT_RESULTS<<EOF"; echo "$RESULTS"; echo "EOF"; } >> "$GITHUB_ENV"

[ -z "$HADOLINT_OUTPUT" ] || echo "Hadolint output saved to: $HADOLINT_OUTPUT"

exit $FAILED
