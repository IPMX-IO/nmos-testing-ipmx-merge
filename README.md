# nmos-testing-ipmx-merge

Workbench for merging the IPMX test suites into AMWA nmos-testing.

## Development

Development happens in the dev container. Open the folder in Visual Studio Code and choose "Reopen in Container". The first start installs the git hooks and initialises the issue tracker.

```sh
make test        # run the tests
make lint        # run the linter
make precommit   # the full gate; the pre-commit hook and CI run the same thing
```

See `AGENTS.md` for how work is done here and `CONTRIBUTING.md` for the definition of done.
