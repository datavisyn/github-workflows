#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

# docker run --rm -v $(pwd):/repo --workdir /repo rhysd/actionlint:latest -color

# https://github.com/github/super-linter
docker pull github/super-linter:slim-v4
docker run -e RUN_LOCAL=true -e USE_FIND_ALGORITHM=true -e VALIDATE_ALL_CODEBASE=true --env-file "./super-linter.env" -v "$PWD":/tmp/lint github/super-linter:slim-v4

