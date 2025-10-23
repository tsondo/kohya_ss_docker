#!/bin/bash
# entrypoint.sh — LoRA Trainer bootstrap

# Activate virtual environment
source /workspace/kohya_ss/venv/bin/activate

# Move to trainer directory
cd /workspace/kohya_ss

# Execute any passed command (e.g., bash, train script)
exec "$@"
