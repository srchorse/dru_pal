# Domain Module

## purpose

`domain` is a scoped dru mod for:

- checking a base name across a configured tld set
- mutating the tld set used by checks
- holding TLD policy state

owned table:

```text
dru_domain
```

## canonical command surface

```text
domain check <name>
domain tld_add <suffix>
domain tld_list
domain tld_delete <suffix>
domain data
```

## command semantics

### `domain check <name>`

semantic shape:

> check whether, for each configured TLD, {{ argument }}.{{ tld }} is available for registration

effect:

1. takes base name `{{ argument }}`
2. expands it across the active tld set
3. checks availability for each expanded domain
4. returns per-tld status

example expansion:

```text
domain check dru
```

becomes:

```text
dru.com
dru.org
dru.io
dru.ai
dru.me
dru.media
dru.music
dru.video
dru.email
```

given the current effective tld state.

### `domain tld_add <suffix>`

semantic shape:

> add {{ argument }} to the list of TLD's that are checked when the check subcommand is executed

effect:

- normalizes input to canonical dotted form
- adds the suffix to the active `domain check` tld set
- avoids duplicate entries

normalization rule:

```text
xyz -> .xyz
.email -> .email
```

### `domain tld_list`

semantic shape:

> output all TLD's checked by domain check

effect:

- returns the full active tld set used by `domain check`
- includes defaults plus user-added entries

### `domain tld_delete <suffix>`

semantic shape:

> remove {{ argument }} from the list of checked TLD's

effect:

- normalizes input to canonical dotted form
- removes the suffix from the active `domain check` set

### `domain data`

effect:

- displays stored rows from `dru_domain`
- functions as raw inspection of TLD policy state

## canonical data model

typed scaffold:

```text
dru_domain
- id
- value
- row_type
- timestamp
```

row defaults:

```text
tld
```

`row_type` defaults to `tld`.

## current effective tld set

the default effective tld set is:

```text
.com
.org
.io
.ai
.me
.media
.music
.video
.email
```

## canonical execution pattern

module routing follows standard dru form:

```text
domain <command> <argument_optional>
```

examples:

```text
domain check grapeture

domain tld_add email
domain tld_list
domain tld_delete .music

domain data
```

## canonical strengths of the module

`domain` combines two roles:

- tld policy layer
- availability checking layer

this makes it a lean infrastructure mod.

## canonical architecture

```text
word   = lexical source layer + invention + naming generation + brand scoring
domain = TLD policy layer + availability checking
```

`domain` no longer owns seed words, naming ideas, or brandability logic.

those responsibilities now belong to `word`.

## canonical responsibility split

`domain` owns:

- configured tld set
- tld mutation commands
- domain availability expansion and checking

`domain` does not own:

- lexical seed storage
- idea generation
- brand scoring
- seed deletion

## canonical summary

`domain` is the downstream check system in the naming pipeline.

it owns:

- tld configuration
- availability checking
- domain expansion behavior
