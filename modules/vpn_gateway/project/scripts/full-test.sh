#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

# Запускаем тесты и компиляцию через виртуальное окружение проекта.
if [[ ! -x ".venv/bin/python" ]]; then
  echo "[error] Не найден .venv/bin/python" >&2
  exit 1
fi

.venv/bin/python -m pytest -q
.venv/bin/python -m compileall app
curl -fsS http://127.0.0.1:8088/health >/dev/null || true
