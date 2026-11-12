FROM debian:bookworm-slim

ARG DEBIAN_FRONTEND=noninteractive

# Base tools every repository uses.
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      ca-certificates curl git make unzip gh ripgrep less openssh-client; \
    rm -rf /var/lib/apt/lists/*

# Python toolchain: interpreter, virtual environments, test runner and linter.
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      python3 python3-pip python3-venv python3-pytest flake8; \
    rm -rf /var/lib/apt/lists/*

# Beads (bd) issue tracker: pinned release, self-contained (embeds Dolt).
ARG BD_VERSION=1.3.1
RUN set -eux; \
    case "$(uname -m)" in \
      aarch64|arm64) bdarch="arm64" ;; \
      x86_64|amd64)  bdarch="amd64" ;; \
      *) echo "unsupported arch for bd: $(uname -m)" >&2; exit 1 ;; \
    esac; \
    curl -fsSL "https://github.com/gastownhall/beads/releases/download/v${BD_VERSION}/beads_${BD_VERSION}_linux_${bdarch}.tar.gz" \
      | tar xz -C /tmp bd; \
    install -m 0755 /tmp/bd /usr/local/bin/bd; \
    rm -f /tmp/bd; \
    bd version

# Both directories are mount targets (see .devcontainer/devcontainer.json). They must
# exist and be owned by the user here: Docker seeds a fresh named volume from the image
# path, and a missing path gives a root-owned volume the user cannot write to.
RUN useradd -m -u 10001 dev && \
    install -d -o dev -g dev /home/dev/.claude /home/dev/.vscode-server
USER dev
