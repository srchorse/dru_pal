-- bootstrap schema for drupal gpt package (dru + merlin + educator + quote + word + domain)

CREATE TABLE IF NOT EXISTS dru (
  id SERIAL PRIMARY KEY,
  name_machine VARCHAR(25) NOT NULL,
  command_machine VARCHAR(25) NOT NULL,
  command_semantic TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS dru_merlin (
  id SERIAL PRIMARY KEY,
  datum TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS dru_educator (
  id SERIAL PRIMARY KEY,
  datum TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS dru_quote (
  id SERIAL PRIMARY KEY,
  quote TEXT NOT NULL,
  source_optional TEXT,
  topic_optional TEXT,
  timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dru_word (
  id SERIAL PRIMARY KEY,
  word TEXT NOT NULL,
  timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dru_domain (
  id SERIAL PRIMARY KEY,
  value TEXT NOT NULL,
  row_type TEXT DEFAULT 'tld',
  timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- core dru commands
INSERT INTO dru (name_machine, command_machine, command_semantic) VALUES
('core', 'mod_new', 'Create a new module and scoped table dru_<name_machine>.')
,('core', 'subcommand', 'Register a subcommand semantic in the dru registry.')
,('core', 'data', 'Read data from dru_<module>.')
,('core', 'delete', 'Delete module and drop scoped table.')
,('core', 'mod_list', 'List unique modules registered in dru.')
,('core', 'dru', 'Inspect full command registry grouped by module.')
,('core', 'mod_export', 'Export a module table as SQL file schema + inserts.');

-- preloaded merlin module commands
INSERT INTO dru (name_machine, command_machine, command_semantic) VALUES
('merlin', 'system', 'Activate merlin deterministic command interpreter rules and strict formatting.')
,('merlin', 'bump', 'Increase score/prominence for literal or emoji handle; stacked emoji amplify effect.')
,('merlin', 'discard', 'Remove/deactivate target by literal or emoji handle.')
,('merlin', 'move', 'Reassign target scope/state only when explicitly commanded.')
,('merlin', 'snooze', 'Temporarily suppress target.')
,('merlin', 'took', 'Record medication ingestion event.')
,('merlin', 'had', 'Record substance ingestion event.')
,('merlin', 'note', 'Attach metadata to target.')
,('merlin', 'top', 'Output scored entities only; never expose internal tables.')
,('merlin', 'recon', 'Audit last response for broken links, file errors, or missing logic.')
,('merlin', 'explain', 'Explicit explanation only when invoked.')
,('merlin', 'why', 'Causal explanation only when invoked.')
,('merlin', 'thoughts', 'Introspective output only when invoked.');

-- preloaded educator module commands
INSERT INTO dru (name_machine, command_machine, command_semantic) VALUES
('educator', 'system', 'activate educator deterministic queue/teach/remind workflow rules and module-local alias handling.')
,('educator', 'queue', 'store a concept that I want to learn more about')
,('educator', 'remind', 'list out all processed queue concepts with a bulletpoint and a one paragraph summary of the concept')
,('educator', 'teach', 'take the oldest item from the queued concepts and explain it to me like I am 13 in several paragraphs, and then remove it from the queue')
,('educator', 'remove', 'removes both queued and processed rows of {{ concept }} with a confirmation dialog, to make sure it''s a correct match')
,('educator', 'alias', 'merge two subcommand names into one alias-group; order-independent; resolves aliases transitively and merges behaviors')
,('educator', 'aliases', 'show alias groups for the module')
,('educator', 'aliases_remove', 'remove an alias name from its group (command shape: {{ mod }} aliases remove {{ alias }})')
,('educator', 'confirm_remove', 'confirmation step for remove (command shape: {{ mod }} confirm remove {{ concept }})');

-- preloaded quote module commands
INSERT INTO dru (name_machine, command_machine, command_semantic) VALUES
('quote', 'system', 'activate quote retrieval, storage, random recall, and search rules within dru.')
,('quote', 'add', 'store provided quote as a quote row')
,('quote', 'from', 'output a relevant quote from {{ argument }} and save it as a row')
,('quote', 'about', 'output a quote about {{ argument }} and save it as a row')
,('quote', 'lookup', 'insert and display a quote from {{ argument_1 }} about {{ argument_2 }}')
,('quote', 'random', 'output a random stored quote from dru_quote')
,('quote', 'search', 'return stored quotes containing {{ argument }}');

-- preloaded word module commands
INSERT INTO dru (name_machine, command_machine, command_semantic) VALUES
('word', 'system', 'activate word lexical storage, memorability scoring, invented-word generation, naming generation, and brand scoring within dru.')
,('word', 'add', 'add {{ argument }} into data table as word')
,('word', 'list', 'output all stored words')
,('word', 'score', 'score {{ argument }} for memorability')
,('word', 'invent', 'generate {{ argument }} invented words using words from the data table as inspiration')
,('word', 'delete', 'delete stored words matching {{ argument }}')
,('word', 'domains', 'generate {{ argument }} fresh domain-name ideas each time using words from the word table as inspiration, and daisy-chain each result into the domain mod across the active TLD set')
,('word', 'brand', 'score {{ argument }} for brandability as a domain-style word');

-- preloaded domain module commands
INSERT INTO dru (name_machine, command_machine, command_semantic) VALUES
('domain', 'system', 'activate domain tld policy control and availability checking within dru.')
,('domain', 'check', 'check whether, for each configured TLD, {{ argument }}.{{ tld }} is available for registration')
,('domain', 'tld_add', 'add {{ argument }} to the list of TLD''s that are checked when the check subcommand is executed')
,('domain', 'tld_list', 'output all TLD''s checked by domain check')
,('domain', 'tld_delete', 'remove {{ argument }} from the list of checked TLD''s');
