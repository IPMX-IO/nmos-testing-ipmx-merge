#!/usr/bin/env bash
# The full gate: the git pre-commit hook and CI both run this through `make precommit`.
set -euo pipefail
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() { echo "precommit: ERROR: $*" >&2; exit 1; }
info() { echo "precommit: $*"; }

if git grep -nE '^(<<<<<<< |>>>>>>> )' -- . ':!work' >/dev/null 2>&1; then
  fail "unresolved merge markers found (git grep '^<<<<<<< ')."
fi

if git grep -n 'FILL:' -- AGENTS.md README.md Makefile docs/coding-style.md >/dev/null 2>&1; then
  fail "setup is unfinished: 'FILL:' markers remain. Run 'git grep -n FILL:' and complete them."
fi

info "lint..."
make --no-print-directory lint
info "tests..."
make --no-print-directory test

# Repository-specific checks go below this line.

info "all checks passed."
