# github-workflows
contains github workflows for the datavisyn organisation

## Auto-Fix Linting Functionality

The `build-node-python` action now supports automatic fixing of linting errors. When enabled, the action will:

1. Run the normal linting process first
2. If linting fails and auto-fix is enabled, attempt to fix errors using:
   - `yarn lint:fix` for frontend/Node.js projects
   - `make format` for backend/Python projects
3. Re-run the linting process to verify fixes worked
4. Commit and push changes if fixes were successful

### Usage

#### Via workflow_call
```yaml
jobs:
  build:
    uses: datavisyn/github-workflows/.github/workflows/build-node-python.yml@main
    with:
      auto_fix_lint: true  # Enable auto-fix (default: false)
```

#### Via workflow_dispatch
The `build-node-python.yml` workflow can now be manually triggered with:
- `auto_fix_lint`: Enable automatic fixing of linting errors
- Other standard parameters like `run_parallel`, `cypress_enable`, etc.

#### Direct action usage
```yaml
- uses: datavisyn/github-workflows/.github/actions/build-node-python@main
  with:
    auto_fix_lint: true
    # ... other parameters
```

### Requirements

For auto-fix to work, your project should have:
- `yarn lint:fix` command available (for Node.js projects)
- `make format` target available (for Python projects)
- Proper git permissions for the workflow to commit and push changes

### Notes

- Auto-fix is disabled by default to maintain backward compatibility
- Fixed files are committed with message: "Auto-fix: Apply linting and formatting fixes [skip ci]"
- If fixes don't resolve all linting issues, the workflow will still fail
- The workflow requires `contents: write` permission to commit changes

## Linting
We use super-linter from github (see <https://github.com/github/super-linter>)

[![GitHub Super-Linter](https://github.com/datavisyn/github-workflows/workflows/lint/badge.svg)](https://github.com/marketplace/actions/super-linter)
