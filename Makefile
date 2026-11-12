.PHONY: all test lint precommit doctor
all: test

TEST_CMD = python3 -m pytest -q
LINT_CMD = flake8 .

test:
	$(TEST_CMD)

lint:
	$(LINT_CMD)

# The full gate. The git pre-commit hook and CI run this.
precommit:
	bash scripts/precommit.sh

# Check that this repository's setup is complete and consistent.
doctor:
	bash scripts/check-repo.sh
