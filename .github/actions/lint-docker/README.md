# docker lint action

This action lint dockerfiles via hadolint.

## Inputs

## `dockerfile`

The dockerfile that should be checked. Default `"Dockerfile"`.

## `config`

The hadolint config file.

## `recursive`

true, if the root directory should be searched for Dockerfiles. Default `false`.

## `output-file`

The path where to save the linting results to.

## `no-fail`

Never exit with a failure status code. Default `false`.

## `failure-threshold`

Fail the pipeline only if rules with severity above this threshold are violated. One of [error | warning | info (default) | style | ignore]. Default `info`.

## `ignore`

A comma separated string of rules to ignore.

## Outputs

## `results`

Results of hadolint.

## Example usage

  uses: ./tmp/github-workflows/.github/actions/lint-docker
  with:
    config: .github/linters/.hadolint.yaml
    recursive: true
