#!/bin/bash

PID_FILE="$(dirname "$0")/tunel.pid"
HOST_IMX="192.168.0.107"

is_host_up() {
    ping -c 1 -W 1 "$1" &> /dev/null
    if [ $? -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

enable_tunel() {
  source "/home/pear/.config/waybar/vpn/vpn.conf"
  if ip link show | grep -q "$VPN_NAME"; then
    if is_host_up $HOST_IMX; then
      ssh -N -R 2223:192.168.0.107:22 yocto &
      echo "PID=$!" > "$PID_FILE"
    fi
  fi
}

disable_tunel() {
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
