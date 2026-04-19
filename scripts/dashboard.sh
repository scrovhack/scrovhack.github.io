#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

SERVICES=(symfony angular scala-play openresty postgres redis adminer)

require() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing required command: $1"
    exit 1
  }
}

compose() {
  if docker compose version >/dev/null 2>&1; then
    docker compose "$@"
  else
    docker-compose "$@"
  fi
}

start_service()   { compose up -d "$1"; }
stop_service()    { compose stop "$1"; }
restart_service() { compose restart "$1"; }
logs_service()    { compose logs -f --tail=100 "$1"; }
status()         { compose ps; }

menu() {
  while true; do
    clear
    echo "Polyglot Stack Dashboard"
    echo "========================"
    echo
    echo "1) Start all"
    echo "2) Stop all"
    echo "3) Restart all"
    echo "4) Status"
    echo "5) Logs"
    echo "6) Start one"
    echo "7) Stop one"
    echo "8) Restart one"
    echo "9) Quit"
    echo
    read -r -p "Select: " choice

    case "$choice" in
      1) compose up -d ;;
      2) compose down ;;
      3) compose restart ;;
      4) status; read -r -p "Enter to continue..." ;;
      5)
        echo
        select s in "${SERVICES[@]}"; do
          [ -n "${s:-}" ] && logs_service "$s"
          break
        done
        ;;
      6)
        select s in "${SERVICES[@]}"; do
          [ -n "${s:-}" ] && start_service "$s"
          break
        done
        ;;
      7)
        select s in "${SERVICES[@]}"; do
          [ -n "${s:-}" ] && stop_service "$s"
          break
        done
        ;;
      8)
        select s in "${SERVICES[@]}"; do
          [ -n "${s:-}" ] && restart_service "$s"
          break
        done
        ;;
      9) exit 0 ;;
      *) echo "Invalid choice"; sleep 1 ;;
    esac
  done
}

require docker
require bash

chmod +x "$0" || true

if command -v tmux >/dev/null 2>&1 && [ -z "${TMUX:-}" ]; then
  SESSION="polyglot"

  tmux has-session -t "$SESSION" 2>/dev/null && tmux kill-session -t "$SESSION"

  tmux new-session -d -s "$SESSION" -n control "bash '$0' --menu"
  tmux split-window -h -t "$SESSION:0" "bash -lc 'compose ps; exec bash'"
  tmux select-pane -t "$SESSION:0.0"

  for svc in "${SERVICES[@]}"; do
    tmux new-window -t "$SESSION" -n "$svc" "bash -lc 'compose logs -f --tail=100 $svc'"
  done

  tmux select-window -t "$SESSION:0"
  tmux attach -t "$SESSION"
else
  if [ "${1:-}" = "--menu" ]; then
    menu
  else
    menu
  fi
fi
