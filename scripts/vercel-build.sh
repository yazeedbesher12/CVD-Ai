#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_DIR="${FLUTTER_DIR:-$PWD/.vercel/flutter}"

if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  bash "$SCRIPT_DIR/vercel-install-flutter.sh"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

flutter build web --release --base-href /
