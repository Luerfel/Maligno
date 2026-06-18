#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLISP_ROOT="$ROOT_DIR/.local-clisp/root"
CLISP_LIB="$CLISP_ROOT/usr/lib/clisp-2.49.93+"
CLISP_RUN="$CLISP_LIB/base/lisp.run"
CLISP_MEM="$CLISP_LIB/base/lispinit.mem"

if [[ ! -x "$CLISP_RUN" ]]; then
  echo "CLISP local nao encontrado."
  echo "Instale com: sudo apt-get update && sudo apt-get install -y clisp"
  echo "Depois rode: clisp -i agenda.lsp"
  exit 1
fi

export LD_LIBRARY_PATH="$CLISP_ROOT/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH:-}"

(printf "(menu)\n"; cat) | "$CLISP_RUN" -q -q \
  -B "$CLISP_LIB" \
  -M "$CLISP_MEM" \
  -i "$ROOT_DIR/agenda.lsp"
