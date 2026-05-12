---
title: Watch Mode
description: Automatically rebuild or re-test when files change.
---

Watch mode is a flag on the `build` command that re-runs your build (or tests) automatically whenever source files change.

## Usage

```bash
# Watch and rebuild on change
sui-runner build --watch

# Watch and re-run tests on change
sui-runner build --watch --test
```

## What Gets Watched

Sui-runner polls the following paths every **500 ms**:

| Path | Notes |
|---|---|
| `sources/` | Watched recursively — any `.move` file change triggers a rebuild |
| `tests/` | Watched if the directory exists |
| `Move.toml` | Triggers a rebuild when the manifest changes |

## Build Options

The `build` command also accepts these flags independently of watch mode:

| Flag | Description |
|---|---|
| `--test` | Run tests instead of building |
| `--filter <name>` | Only run tests whose name contains `<name>` |
| `--skip-fetch` | Skip fetching git dependencies |
| `--doc` | Generate Move documentation |
| `--path <dir>` | Path to the Move package (defaults to current directory) |

## Examples

```bash
# Build the current package
sui-runner build

# Run all tests
sui-runner build --test

# Run only tests matching "transfer"
sui-runner build --test --filter transfer

# Watch and re-run a specific test suite
sui-runner build --watch --test --filter transfer
```
