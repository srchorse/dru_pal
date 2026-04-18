# Word Module

## purpose

`word` is a scoped dru mod for:

- lexical storage
- listing stored words
- scoring words for memorability
- generating invented words from stored word rows
- generating fresh naming candidates
- scoring words for brandability

owned table:

```text
dru_word
```

## canonical command surface

```text
word add <word>
word list
word score <word>
word invent <n>
word delete <word>
word domains <n>
word brand <word>
word data
```

## command semantics

### `word add <word>`

semantic shape:

> add {{ argument }} into data table as word

effect:

- inserts the provided word into `dru_word` as a stored word row

### `word list`

semantic shape:

> output all stored words

effect:

- queries `dru_word`
- returns all stored words in list form

expected output shape:

```text
1. recursion
2. velocity
3. drulyn
```

### `word score <word>`

semantic shape:

> score {{ argument }} for memorability

effect:

- evaluates the input word on factors such as brevity, pronounceability, distinctiveness, rhythm, and visual simplicity
- returns score plus short notes

expected output shape:

```text
name: drulyn
score: 8.4
notes: short, distinct, easy to say
```

### `word invent <n>`

semantic shape:

> generate {{ argument }} invented words using words from the data table as inspiration

effect:

1. reads stored rows from `dru_word`
2. uses those words as inspiration material
3. generates `n` invented words
4. returns the generated list

example flow:

```text
word add recursion
word add velocity
word add dru

word invent 3
```

possible output:

```text
1. recurix
2. veldru
3. drucity
```

### `word delete <word>`

semantic shape:

> delete stored words matching {{ argument }}

effect:

- deletes rows from `dru_word` using a case-insensitive containment match against the provided word

### `word domains <n>`

semantic shape:

> generate {{ argument }} fresh domain-name ideas each time using words from the word table as inspiration, and daisy-chain each result into the domain mod across the active TLD set

effect:

1. reads stored rows from `dru_word`
2. derives fresh domain-style naming ideas from stored lexical material
3. generates `n` names
4. daisy-chains each result into the `domain` mod
5. returns each generated name with its downstream check output

### `word brand <word>`

semantic shape:

> score {{ argument }} for brandability as a domain-style word

effect:

- evaluates the input word on memorability, pronounceability, brevity, distinctiveness, visual cleanliness, and naming friendliness
- returns score plus short notes

expected output shape:

```text
name: drulyn
score: 8.8
notes: short, clean, easy to say, commercially strong
```

### `word data`

effect:

- displays all rows currently stored in `dru_word`
- lower-level than `word list`

## canonical data model

implied scaffold:

```text
dru_word
- id
- word
- timestamp
```

seeded rows:

- none

argument normalization:

- treat `<value>`, `<term>`, and `<word>` as the same input role
- use `<word>` as the canonical surfaced name

## canonical execution pattern

module routing follows standard dru form:

```text
word <command> <argument_optional>
```

examples:

```text
word add recursion
word list
word score drulyn
word invent 5
word delete rec
word domains 5
word brand drulyn
word data
```

## canonical strengths of the module

`word` supports four main roles:

- wordbank
- invention engine
- naming generator
- brand evaluator

this makes it the primary naming mod.

## canonical design qualities

- stateful: uses `dru_word`
- table-driven: invention depends on stored rows
- layered: storage, invention, naming, and evaluation stay inside one mod
- lightweight: clear surface, compact semantics

## canonical summary

`word` is a working dru module with:

- registered module name: `word`
- owned state table: `dru_word`
- 7 active commands
- persistent word storage
- memorability scoring
- table-based invented-word generation
- fresh naming generation
- brandability scoring
