#!/usr/bin/env bash
# Runs inside the dev container after it is created (devcontainer.json postCreateCommand).
# Installs the git hooks and initialises the tracker. Safe to run again.
set -euo pipefail
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

info() { echo "setup: $*"; }

if [ ! -f /.dockerenv ] && [ -z "${REMOTE_CONTAINERS:-}" ] && [ -z "${CODESPACES:-}" ]; then
  echo "setup: this script is for the dev container. Open the folder in VS Code and choose 'Reopen in Container'." >&2
  exit 1
fi

git config --global --add safe.directory "$(pwd)" || true

# 1. Tracker. `bd init` only when this clone has no database yet.
if ! bd ready >/dev/null 2>&1; then
  info "initialising beads..."
  bd init || info "bd init did not complete; run it by hand and then 'make doctor'."
fi

# 2. Hooks. bd installs its hooks under .beads/hooks and points git at them.
info "installing git hooks..."
bd hooks install || info "bd hooks install did not complete; run it by hand and then 'make doctor'."

# 3. The pre-commit hook runs this repository's gate before bd's own section, and
#    refuses a commit made outside the container.
HOOK=.beads/hooks/pre-commit
MARK="# --- repo-setup gate ---"
if [ -f "$HOOK" ] && ! grep -qF "$MARK" "$HOOK"; then
  tmp="$(mktemp)"
  {
    echo '#!/usr/bin/env bash'
    echo "$MARK"
    echo 'if [ ! -f /.dockerenv ] && [ -z "${REMOTE_CONTAINERS:-}" ] && [ -z "${CODESPACES:-}" ] && [ -z "${ALLOW_HOST_COMMIT:-}" ]; then'
    echo '  echo "pre-commit: commit from inside the dev container (the gate needs its tools). Set ALLOW_HOST_COMMIT=1 to override." >&2'
    echo '  exit 1'
    echo 'fi'
    echo '( cd "$(git rev-parse --show-toplevel)" && bash scripts/precommit.sh ) || exit 1'
    echo "# --- end repo-setup gate ---"
    grep -v '^#!' "$HOOK"
  } > "$tmp"
  cat "$tmp" > "$HOOK"; rm -f "$tmp"; chmod +x "$HOOK"
fi

# 4. A relative hooks path works from the container and from the host alike.
if [ -d .beads/hooks ]; then
  git config core.hooksPath .beads/hooks
fi

info "done. Run 'make doctor' to check the result."
