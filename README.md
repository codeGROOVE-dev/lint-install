# lint-install

[![GoReport Widget]][GoReport Status]
[![stability-stable](https://img.shields.io/badge/stability-stable-green.svg)](https://github.com/emersion/stability-badges#stable)

[GoReport Status]: https://goreportcard.com/report/github.com/codeGROOVE-dev/lint-install
[GoReport Widget]: https://goreportcard.com/badge/github.com/codeGROOVE-dev/lint-install

Automated linter installation and configuration for consistent code quality across teams and environments.

## Why lint-install?

Maintaining consistent code quality across a team can be challenging. Different developers might use different linters, versions, or configurations, leading to:

- **Inconsistent code reviews** - Style debates instead of logic discussions
- **CI/CD failures** - Code that passes locally but fails in CI due to different linter versions
- **Configuration drift** - Each project reinventing its own linting setup
- **Onboarding friction** - New contributors struggling with tooling setup

lint-install solves these problems by providing:

- **One command setup** - Instantly adds industry-standard linters to any project
- **Version pinning** - Everyone uses the exact same linter versions
- **Consistent configuration** - Opinionated, battle-tested linter rules
- **Easy updates** - Upgrade all linters across your entire team with one command
- **Multi-environment support** - Same linting in local development, CI/CD, and IDEs

## How it works

lint-install adds Makefile rules and linter configurations to your project root. It installs specific versions of well-configured linters that can be used consistently by all contributors, whether they're working locally, in CI, or using an IDE.

Currently supported languages:

- **Go** - golangci-lint with comprehensive checks
- **Shell** - shellcheck for POSIX compliance and best practices  
- **Dockerfile** - hadolint for security and best practices
- **YAML** - yamllint for syntax and style

## Philosophy

- Catch all the bugs!
- Improve readability as much as possible.
- Be idiomatic: only raise issues that the language authors would flag

## Installation

```bash
go install github.com/codeGROOVE-dev/lint-install@latest
```

## Usage

### Basic usage

Add linters to your project:

```bash
lint-install .
```

This creates:
- Makefile rules for installing and running linters
- Configuration files for each detected language
- A `.gitignore` entry for the linter binaries

Run the linters:

```bash
make lint
```

### Examples

**Adding linters to a Go project:**
```bash
cd my-go-project
lint-install .
make lint
```

**Selective language support:**
```bash
# Only add Go and Shell linters, ignore others
lint-install -dockerfile=ignore -yaml=ignore .
```

**Preview changes without applying:**
```bash
lint-install -dry-run .
```

**CI/CD integration:**
```yaml
# GitHub Actions example
- name: Install linters
  run: make lint-install
  
- name: Run linters
  run: make lint
```

**Updating linter versions:**
```bash
# Re-run lint-install to update to latest versions
lint-install .
git add Makefile .*.version
git commit -m "Update linter versions"
```

### Command-line options

```
  -dockerfile string
     Level to lint Dockerfile with: [ignore, warn, error] (default "error")
  -dry-run
     Display changes to make
  -go string
     Level to lint Go with: [ignore, warn, error] (default "error")
  -makefile string
     name of Makefile to update (default "Makefile")
  -shell string
     Level to lint Shell with: [ignore, warn, error] (default "error")
  -yaml string
     Level to lint YAML with: [ignore, warn, error] (default "error")
```

### What gets added to your project

1. **Makefile targets:**
   - `make lint` - Run all configured linters
   - `make lint-<language>` - Run specific language linter
   - `make lint-install` - Install the linter binaries

2. **Configuration files:**
   - `.golangci.yml` - Go linting rules
   - `.hadolint.yaml` - Dockerfile linting rules
   - `.yamllint` - YAML linting rules
   - `.*.version` files - Pinned linter versions

3. **Linter binaries:**
   - Installed to `./out/linters/` (git-ignored)
   - Consistent versions across all environments

## Features

- **Zero configuration** - Sensible defaults that work for most projects
- **Language detection** - Automatically identifies which linters to install
- **Version management** - Pins linter versions for reproducible builds
- **Makefile integration** - Works with existing build systems
- **Incremental adoption** - Control which languages to lint
- **IDE friendly** - Linters work with VSCode, GoLand, and other editors
- **Fast installation** - Downloads pre-built binaries when available
- **Cross-platform** - Works on Linux, macOS, and Windows

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

See [LICENSE](LICENSE) for details.
