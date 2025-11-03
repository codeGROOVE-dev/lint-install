# lint-install

[![GoReport Widget]][GoReport Status]
[![stability-stable](https://img.shields.io/badge/stability-stable-green.svg)](https://github.com/emersion/stability-badges#stable)

[GoReport Status]: https://goreportcard.com/report/github.com/codeGROOVE-dev/lint-install
[GoReport Widget]: https://goreportcard.com/badge/github.com/codeGROOVE-dev/lint-install

Automated linter installation and configuration for consistent code quality across teams and environments.

## Quick Start

```bash
# Install
go install github.com/codeGROOVE-dev/lint-install@latest

# Add linters to your project
lint-install .

# Run linters
make lint
```

## Why Use It?

- **One command setup** - Adds industry-standard linters instantly
- **Version pinning** - Same linter versions for everyone
- **Battle-tested configs** - Opinionated rules that catch real bugs
- **Multi-environment** - Works locally, in CI/CD, and IDEs

## Supported Languages

- **Go** - golangci-lint
- **Shell** - shellcheck
- **Dockerfile** - hadolint
- **YAML** - yamllint
- **Web** (JS/TS/HTML/CSS/JSON) - biome

## Usage Examples

```bash
# Basic usage
lint-install .
make lint

# Only Go and Shell linters
lint-install -dockerfile=ignore -yaml=ignore -web=ignore .

# Preview changes
lint-install -dry-run .

# CI/CD (GitHub Actions)
- run: make lint-install
- run: make lint
```

## Command Options

```
-dockerfile string   Dockerfile linting: [ignore, warn, error] (default "error")
-go string          Go linting: [ignore, warn, error] (default "error")
-shell string       Shell linting: [ignore, warn, error] (default "error")
-yaml string        YAML linting: [ignore, warn, error] (default "error")
-web string         Web linting (JS/TS/HTML/CSS/JSON): [ignore, warn, error] (default "error")
-dry-run            Preview changes without applying
-makefile string    Makefile name (default "Makefile")
```

## What Gets Added

- **Makefile targets**: `lint`, `lint-<language>`, `lint-install`
- **Config files**: Only for languages detected in your project
  - `.golangci.yml` (Go files)
  - `.yamllint` (YAML files)
  - `biome.json` (JS/TS/HTML/CSS/JSON files)
- **Linter binaries**: `./out/linters/` (git-ignored)

## Contributing

Contributions welcome! Submit issues or pull requests.

## License

See [LICENSE](LICENSE) for details.