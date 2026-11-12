#!/usr/bin/env bash
# Checks that this repository's setup is complete and consistent. `make doctor` runs it.
set -uo pipefail
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bad=0
ok()   { echo "  ok    $*"; }
miss() { echo "  FAIL  $*"; bad=1; }
check() { if eval "$2" >/dev/null 2>&1; then ok "$1"; else miss "$1"; fi; }

echo "repository setup:"
check "AGENTS.md exists"                              '[ -f AGENTS.md ]'
check "CLAUDE.md imports AGENTS.md"                   'grep -q "^@AGENTS.md" CLAUDE.md'
check "docs/coding-style.md is filled from a profile" '[ -s docs/coding-style.md ] && ! grep -q "replaced by new-repo.sh" docs/coding-style.md'
check "no FILL: markers remain"                       '! git grep -n "FILL:" -- AGENTS.md README.md Makefile docs/coding-style.md'
check "Claude session hook runs bd prime"             'grep -q "bd prime" .claude/settings.json'
check "CI workflow present"                           '[ -f .github/workflows/ci.yml ]'
check "plain-technical-writing skill is in the repo"  '[ -f .claude/skills/plain-technical-writing/SKILL.md ]'

echo "tracker and hooks (dev container):"
check "bd is installed"                               'command -v bd'
check "beads database answers"                        'bd ready'
check "git hooks path is .beads/hooks (relative)"     '[ "$(git config core.hooksPath)" = ".beads/hooks" ]'
check "pre-commit hook runs scripts/precommit.sh"     'grep -q "scripts/precommit.sh" .beads/hooks/pre-commit'
if git remote get-url origin >/dev/null 2>&1; then ok "a git remote is set"; else echo "  note  no git remote yet (add one when the repository goes to GitHub)"; fi

if [ "$bad" = 0 ]; then echo "all checks passed."; else echo "setup is incomplete: fix the FAIL lines above."; fi
exit "$bad"
