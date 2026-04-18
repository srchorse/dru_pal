# Quote Module

## purpose

`quote` is a scoped dru mod for:

- retrieving quotes by source
- retrieving quotes by topic
- retrieving quotes by source and topic together
- storing returned quotes in module state
- searching and randomly recalling stored quotes

owned table:

```text
dru_quote
```

## canonical command surface

```text
quote add <quote>
quote from <source>
quote about <topic>
quote lookup <author> <topic>
quote random
quote search <term>
quote data
```

## command semantics

### `quote add <quote>`

semantic shape:

> store provided quote as a quote row

effect:

- inserts a user-provided quote into `dru_quote`

### `quote from <source>`

semantic shape:

> output a relevant quote from {{ argument }} and save it as a row

effect:

- retrieves a quote associated with the provided source
- displays it
- stores it in `dru_quote`

### `quote about <topic>`

semantic shape:

> output a quote about {{ argument }} and save it as a row

effect:

- retrieves a quote associated with the provided topic
- displays it
- stores it in `dru_quote`

### `quote lookup <author> <topic>`

semantic shape:

> insert and display a quote from {{ argument_1 }} about {{ argument_2 }}

effect:

- retrieves a quote from the provided author related to the provided topic
- displays it
- stores it in `dru_quote`

### `quote random`

semantic shape:

> output a random stored quote from dru_quote

effect:

- selects a random existing row from `dru_quote`
- returns the stored quote
- does not require a new insert

### `quote search <term>`

semantic shape:

> return stored quotes containing {{ argument }}

effect:

- searches persisted rows in `dru_quote`
- returns matching quotes

### `quote data`

effect:

- displays all rows currently stored in `dru_quote`

## canonical data model

implied scaffold:

```text
dru_quote
- id
- quote
- source_optional
- topic_optional
- timestamp
```

seeded rows:

- none

## canonical execution pattern

module routing follows standard dru form:

```text
quote <command> <argument_optional>
```

examples:

```text
quote from <source>
quote about <topic>
quote lookup <author> <topic>
quote random
quote search <term>
quote data
```

## canonical strengths of the module

`quote` supports three retrieval modes:

- by source
- by topic
- by source and topic together

and two recall modes:

- random
- search

this makes it both a retrieval mod and a quote memory mod.

## canonical next scaffolds worth adding

```text
quote subcommand delete "delete stored quotes matching {{ argument }}"
quote subcommand latest "output the most recently stored quote"
quote subcommand sources "list distinct stored quote sources"
quote subcommand topics "list distinct stored quote topics"
quote subcommand clear "delete all rows from dru_quote"
```
