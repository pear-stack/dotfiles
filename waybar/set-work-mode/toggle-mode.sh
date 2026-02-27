#!/bin/bash

STATUS_FILE="$(dirname "$0")/mode.info"

enable_workmode() {
  echo "MODE='WORK'" > "$STATUS_FILE"
}

disable_workmode() {
  echo "MODE='DAILY'" > "$STATUS_FILE"
}

if [ -f "$STATUS_FILE" ]; then
    source "$STATUS_FILE"
    if [ $MODE == "WORK" ] > /dev/null; then
      disable_workmode
    else
      enable_workmode
    fi
else
  disable_workmode
fi
