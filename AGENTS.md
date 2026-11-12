# nmos-testing-ipmx-merge

Workbench for merging the IPMX test suites into AMWA nmos-testing.

This file is the single set of instructions for any coding agent in this repository. `CLAUDE.md` imports it.

## Read order when picking up work

1. This file.
2. `docs/coding-style.md`: the style rules for this repository.
3. The tracker: `bd ready` lists what can be started, `bd show <id>` is the hand-off for one item.
4. <!-- FILL: name the one or two documents that define what this project does (a specification, a design note), or delete this line. -->

## Build, test, lint

All commands run inside the dev container.

- `make test`: <!-- FILL: one line on what the test suite covers. -->
- `make lint`: <!-- FILL: one line on what the linter checks. -->
- `make precommit`: the full gate (lint, tests, repository checks). The git pre-commit hook and CI both run it.

## Layout

<!-- FILL: three to eight bullets, one per top-level directory, saying what each one owns. -->

## How work happens

The steps are ordered on purpose. Each one informs the next.

1. **Orient.** `bd ready`, then `bd show <id>`, then read the files the item names.
2. **Plan.** Present a concrete plan (which files change, the approach, the trade-offs) and wait for approval. A task description is not approval.
3. **Docs first.** Update or draft the documentation before tests or code. If the document reads wrong, the design is wrong.
4. **Tests before code.** Write the tests that state the contract, then make them pass.
5. **Code.** Tests stay green at every commit boundary.
6. **Review.** Every diff is reviewed before it lands, by a reader who is given the code and the requirement and is not given the author's conclusion.
7. **One task at a time.** Do not start the next item speculatively.

## Git policy

- **Wait to be asked.** Do not commit, push, open a pull request, or run `bd dolt push` unless the user asks in this session. At hand-off, report changed files, what was validated, and the commands you would run next.
- Work happens in the dev container. A commit from the host is refused by the pre-commit hook.
- Non-trivial changes go on a topic branch (`feat/...`, `fix/...`, `docs/...`, `chore/...`) and through a pull request.
- Commit subject under 72 characters, imperative, sentence case. Detail goes in the body. Name the bead id.
- This section governs over any tool-managed block below it.

## Quality rules

- `make lint` is clean before a change lands. Fix the code. Never silence a warning inline; a project-wide exception goes in the linter's config file with its reason.
- A function fits a screen and does one job.
- A helper is written once. A second copy is a defect.
- A dependency is named in the plan before a replacement for it is written.

## Code that belongs to someone else

Anything under `work/`, `vendor/`, or a git submodule is another project's code. Match the surrounding file, treat that project's linter configuration as the authority, and never reformat or rename anything you were not asked to change. Do not add this repository's instruction files, hooks, or tracker to it.

## Prose

All prose in this repository (README, docs, comments, docstrings, commit messages, PR descriptions, help text, error messages) follows the `plain-technical-writing` skill. Load it before writing or editing any of these, and run its checklist before handing the text over.

## Memory

Durable facts live in beads memories: `bd memories <keyword>` searches, `bd remember --key <key> "..."` writes. Do not keep memory files under `~/.claude` for this project.
