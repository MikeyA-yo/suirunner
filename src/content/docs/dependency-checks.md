---
title: Dependency Checks
description: How to verify your environment with Sui-runner.
---

The `check` command verifies that all required tools are installed and accessible in your `PATH` before you start building.

## Usage

```bash
sui-runner check
```

## Output

```
Checking required tools...

  [ok]  sui
  [ok]  git
  [ok]  cargo

All tools found.
```

If a tool is missing it shows `[missing]` and exits with an error:

```
Checking required tools...

  [ok]  sui
  [missing]  git
  [ok]  cargo

Error: One or more required tools are missing. Install them and re-run.
```

## What It Checks

| Tool | Why it's needed |
|---|---|
| `sui` | Core CLI for Move builds, deploys, and wallet operations |
| `git` | Fetching Move package dependencies |
| `cargo` | Rust toolchain, required if building from source |

## Verbose Mode

Pass `-v` / `--verbose` to print each tool's version string alongside its name:

```bash
sui-runner check -v
```
