---
title: Dependency Checks
description: How to verify your environment with Sui-runner.
---

Sui-runner includes a `check` command that verifies all required tools are installed and accessible in your `PATH`.

## Usage

```bash
sui-runner check
```

## What It Checks

The command runs each tool with its `--version` flag and reports the result:

| Tool | Why it's needed |
|---|---|
| `sui` | Core CLI for Move builds, deploys, and wallet operations |
| `git` | Fetching Move package dependencies |
| `cargo` | Rust toolchain, required if building from source |

## Output

A passing check looks like this:

```
[✓] sui
[✓] git
[✓] cargo
```

If a tool is missing it shows `[missing]` and the command exits with an error:

```
[missing] sui
[✓] git
[✓] cargo

Error: One or more required tools are missing. Install them and re-run.
```

## Verbose Mode

Pass `-v` / `--verbose` to print the version string alongside each tool name:

```bash
sui-runner check --verbose
```

```
[✓] sui      sui 1.38.2
[✓] git      git version 2.43.0
[✓] cargo    cargo 1.78.0
```
