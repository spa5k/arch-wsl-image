#!/bin/bash

FIRST_RUN_FLAG="/etc/wsl_first_run_complete"

if [ ! -f "$FIRST_RUN_FLAG" ]; then
    echo "Running first-time setup script..."
    sudo /scripts/initial_run.sh
    sudo touch "$FIRST_RUN_FLAG"
else
    echo "WSL instance already set up."
fi