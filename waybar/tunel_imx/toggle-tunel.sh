#!/bin/bash

PID_FILE="$(dirname "$0")/tunel.pid"
HOST_IMX="192.168.0.106"

is_host_up() {
    ping -c 1 -W 1 "$1" &> /dev/null
    if [ $? -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

enable_tunel() {
  echo "enabling tunel"
  source "/home/pear/.config/waybar/vpn/vpn.conf"
  if ip link show | grep -q "$VPN_NAME"; then
    echo "link up"
    if is_host_up $HOST_IMX; then
      echo "host up"
      ssh -N -R 2222:192.168.0.106:22 yocto &
      echo "PID=$!" > "$PID_FILE"
    fi
  fi
}

disable_tunel() {
  echo "disabling tunel"
  kill $1
  rm "$PID_FILE"
}

if [ -f "$PID_FILE" ]; then
    source "$PID_FILE"
    if ps -p $PID > /dev/null; then
      disable_tunel $PID
    else
      enable_tunel
    fi
else
  enable_tunel
fi
