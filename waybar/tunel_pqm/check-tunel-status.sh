#!/bin/bash
PID_FILE="$(dirname "$0")/tunel.pid"

if [ -f "$PID_FILE" ]; then
  source "$PID_FILE"
  if ps -p $PID > /dev/null; then
    echo "{\"text\": \"PQM \", \"class\": \"active\"}"
  else
    echo "{\"text\": \"PQM \", \"class\": \"inactive\"}"
  fi
else
  echo "{\"text\": \"PQM \", \"class\": \"inactive\"}"
fi
