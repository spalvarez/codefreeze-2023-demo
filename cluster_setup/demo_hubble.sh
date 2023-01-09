#!/usr/bin/env bash

# Test listener
( cilium hubble port-forward > /dev/null 2>&1 & )

echo ""
read -p "Ensure cluster listener can activate, press Enter to continue" </dev/tty

# View initial flows
hubble observe

echo ""
echo "Starting UI.  Wait for a browser window to open then press Enter when ready to close the demo"
echo ""
echo ""

# Open the ui
( cilium hubble ui > /dev/null 2>&1 & )

read -p "" </dev/tty ;

( pkill kubectl > /dev/null 2>&1 & )