# Dru

Dru is a modular, command-first custom GPT package built around a SQL-like command registry.

It behaves like a lightweight scaffolding system for GPT features: Dru is the primary identity, and scoped functionality is added through `mods` (modules) such as `merlin`, `educator`, `quote`, `word`, and `domain`.

The live GPT in ChatGPT is here:

https://chatgpt.com/g/g-68370be35e2c81919744a05c8629fbb5-dru-pal

## What This GPT Is

Dru is designed to feel like a small command environment rather than a general conversational assistant.

Its core model is:

- `dru` shows the main command registry
- `mod` is the permanent alias for `module`
- each mod has its own scoped behavior
- each mod owns its own conceptual table, named `dru_<name_machine>`
- module behavior only activates when that module is explicitly targeted

This package ships Dru core plus five preloaded mods:

- `merlin`
- `educator`
- `quote`
- `word`
- `domain`

## How It Works

The canonical command shape is:

```text
{{ mod }} {{ command }} {{ argument_optional }}
```

Examples:

```text
dru
mod list
mod new tracker
tracker subcommand log "store {{ argument }} as a tracker row"
tracker data
mod export tracker
quote about courage
educator queue planets
merlin bump stress
word add recursion
domain data
```

## Core Commands

Use these to discover or manage Dru modules:

- `dru`
  Shows the command registry grouped by module.
- `mod list`
  Lists all registered mods.
- `mod new {{ name_machine }}`
  Creates a new mod and its scoped table.
- `{{ mod }} subcommand {{ command_machine }} "{{ command_semantic }}"`
  Registers a subcommand for an existing mod.
- `{{ mod }} data`
  Inspects rows from the mod's scoped table.
- `{{ mod }} delete`
  Removes the mod and drops its scoped table.
- `mod export {{ name_machine }}`
  Exports the mod scaffold.

## Preloaded Mods

These are included in the package, but they remain subordinate to Dru core and only activate when named directly.

- `merlin`
  Specialized module semantics for mental health, medication, substance, habit, and scoring flows.
- `educator`
  Specialized module semantics for queued teaching and learning workflows.
- `quote`
  Specialized module semantics for quote retrieval, storage, random recall, and search.
- `word`
  Specialized module semantics for lexical storage, memorability scoring, name generation, and brand scoring.
- `domain`
  Specialized module semantics for TLD state, mutation, and availability checking.

## First Things To Try

If you are opening Dru for the first time, start here:

```text
dru
mod list
word data
quote about courage
```

That sequence lets you:

1. inspect the full command surface
2. see the built-in mods
3. inspect saved rows for a specific mod
4. call a preloaded mod directly

## Repo Notes

This repository contains the packaged GPT skeleton under `./gpt`, including:

- `gpt/manifest.json`
- `gpt/instructions.md`
- `gpt/bootstrap.sql`
- preloaded module assets under `gpt/modules/*`

The distributable archive is rebuilt as `gpt.zip`.
