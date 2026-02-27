#!/bin/bash

STATUS_FILE="$(dirname "$0")/mode.info"

if [ -f "$STATUS_FILE" ]; then
    source "$STATUS_FILE"
    if [ $MODE == "WORK" ] > /dev/null; then
      echo "{\"text\": \"WORK \", \"class\": \"active\"}"
    else
      echo "{\"text\": \"WORK \", \"class\": \"inactive\"}"
    fi
else
  echo "{\"text\": \"WORK \", \"class\": \"inactive\"}"
fi
