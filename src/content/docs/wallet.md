---
title: Wallet Management
description: Managing Sui wallets with Sui-runner.
---

The `wallet` command provides quick access to your Sui keystore directly from the CLI. It wraps the underlying `sui client` commands into a simpler interface.

## Subcommands

### Show the active address

```bash
sui-runner wallet address
```

Prints the address currently active in the Sui client (equivalent to `sui client active-address`).

### List all addresses

```bash
sui-runner wallet list
```

Lists every address stored in your keystore (equivalent to `sui client addresses`).

### Create a new address

```bash
sui-runner wallet new
```

Generates a new **Ed25519** keypair and adds it to your keystore (equivalent to `sui client new-address ed25519`).

## Quick Reference

| Subcommand | What it does |
|---|---|
| `wallet address` | Show active address |
| `wallet list` | List all addresses |
| `wallet new` | Create a new Ed25519 address |
