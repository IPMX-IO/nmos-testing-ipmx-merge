# Coding style

The code this repository works on belongs to another project. That project's conventions govern.

1. **Match the surrounding file.** Naming, indentation, quoting, import order, comment style and error handling follow what the file already does.
2. **The project's own tooling is the authority.** Its linter and formatter configuration (for example `.flake8`, `setup.cfg`, `.editorconfig`, its CI workflow) decide what is correct. Run them as that project's CI runs them.
3. **Never reformat or rename anything you were not asked to change.** A diff contains the requested change and nothing else. No whitespace clean-up, no import sorting, no modernised syntax.

Documentation written for that project follows that project's documentation format and voice.

Scripts and notes that are ours, kept outside the other project's tree, follow the "All code" rules:

- A function fits a screen and does one job.
- A helper is written once.
- Comments are sparse. Clear names carry the load.
