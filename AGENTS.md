# AGENTS.md

## Repo Context

This repository packages the `Dru` GPT.

Within this GPT, a `mod` is not a generic plugin term. It is the core unit of scoped functionality inside the Dru command system.

`Merlin`, `Educator`, `Quote`, `Word`, and `Domain` are preloaded mods in this package.

## What a Mod Is

A `mod` (alias: `module`) is a scoped feature package inside Dru.

A mod has:

- A unique `name_machine`.
- Command semantics registered in the shared `dru` registry.
- Its own scoped table named `dru_<name_machine>`.
- Lifecycle commands for create, inspect, export, and delete flows.

In practice, a mod is how this GPT isolates behavior into composable units without changing the core Dru identity.

## How a Mod Behaves

- Canonical execution shape: `{{ mod }} {{ command }} {{ argument_optional }}`.
- `mod` is a permanent alias for `module`.
- Core Dru behavior remains primary unless a specific mod is explicitly targeted.
- A mod may define its own subcommands and execution semantics.
- A mod may own module-local state through its scoped table.

## Core Mod Lifecycle

- `mod new {{ name_machine }}` creates a new mod and its scoped table.
- `{{ mod }} subcommand {{ command_machine }} "{{ command_semantic }}"` registers mod behavior in `dru`.
- `mod list` lists registered mods.
- `{{ mod }} data` inspects rows from `dru_{{ mod }}`.
- `{{ mod }} delete` removes the mod and its table.
- `mod export {{ name_machine }}` exports the mod scaffold.

## Preloaded Mods In This GPT

- `merlin` is a specialized mod with its own command semantics.
- `educator` is a specialized mod with its own command semantics.
- `quote` is a specialized mod with its own command semantics.
- `word` is a specialized mod with its own command semantics.
- `domain` is a specialized mod with its own command semantics.

These remain mods, not the primary assistant identity. They activate only when explicitly targeted.

## Why Mods Exist

Mods let this GPT:

- Separate capabilities cleanly.
- Route behavior by command namespace.
- Keep feature contracts composable.
- Add or preload domain-specific behavior without replacing Dru core.

## Authoring Guidance

When defining or exporting a mod in this repository:

- Keep the output structural and functional.
- Define command names, interfaces, and behavior contracts.
- Use empty scaffolds or placeholders for module-local data.
- Do not seed historical, runtime, or personal data into a mod export.

## Maintenance Rule

Any time this repository changes in a way that affects GPT behavior, command surface, startup behavior, package structure, or mod inventory:

- update `gpt/instructions.md`
- keep `gpt/instructions.md` current with all preloaded mods
- every generated `gpt/instructions.md` must be under 8,000 characters
- reflect new mods, removed mods, and changed commands in `gpt/instructions.md`
- if the startup message changes in `gpt/manifest.json`, mirror that change in `gpt/instructions.md`
- rebuild `gpt.zip` from `./gpt`

## Packaging Rule

Any time any repository file changes, always rebuild `gpt.zip` from `./gpt`.

- the zip root must be the contents of `./gpt`, not a top-level `gpt/` folder
- rebuild the zip fresh rather than appending to an existing archive

## Examples

- `mod new tracker`
- `tracker subcommand log "store {{ argument }} as a tracker row"`
- `tracker data`
- `mod export tracker`
- `merlin {{ command }} {{ argument_optional }}`
- `educator {{ command }} {{ argument_optional }}`
- `quote {{ command }} {{ argument_optional }}`
- `word {{ command }} {{ argument_optional }}`
- `domain {{ command }} {{ argument_optional }}`
