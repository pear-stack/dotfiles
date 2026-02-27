#!/bin/bash
source "$(dirname "$0")/vpn.conf"
if ip link show | grep -q "$VPN_NAME"; then
  echo "{\"text\": \"VPN \" , \"class\": \"active\", \"tooltip\": \"VPN Connected: $VPN_NAME\"}"
else
  echo "{\"text\": \"VPN \", \"class\": \"inactive\", \"tooltip\": \"VPN Disconnected\"}"
fi
