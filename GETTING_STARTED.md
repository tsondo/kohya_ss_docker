# GETTING_STARTED: LoRA Training with Docker

This guide introduces the basics of LoRA training using the **lora-trainer** container.

---

## What is Docker?

Docker lets you run applications in isolated containers. Think of it as a lightweight virtual machine that always starts clean, but with persistent folders mounted from your host.

---

## What is Kohya_ss?

[Kohya_ss](https://github.com/bmaltais/kohya_ss) is a popular trainer for LoRA (Low‑Rank Adaptation) models. It fine‑tunes large diffusion models (like SDXL) on your own dataset.

---

## Persistent vs. Ephemeral

- **Persistent**:
  - `configs/` → training configs and prompts
  - `dataset/` → your images and captions
  - `models/` → base models (e.g. SDXL)
  - `output/` → trained LoRAs, logs, samples
  - `venv-cache` → Python environment (Docker volume)

- **Ephemeral**:
  - The container filesystem itself. Rebuilt on `docker compose build`.

---

## First Training Run

1. Place your base model in `models/` (e.g. `models/base_model.safetensors`).
2. Place your training images in `dataset/images/`.
3. Adjust `configs/config_lora-sample.toml` if needed.
4. Launch training:

\`\`\`bash
docker compose run --rm lora-trainer \
  accelerate launch ./sd-scripts/sdxl_train_network.py \
  --config_file /workspace/configs/config_lora-sample.toml
\`\`\`

---

## Daily Workflow

- **Start interactive shell**:
  \`\`\`bash
  docker compose run --rm lora-trainer
  \`\`\`

- **Run training directly**:
  \`\`\`bash
  docker compose run --rm lora-trainer accelerate launch ...
  \`\`\`

- **Stop containers**:
  \`\`\`bash
  docker compose down
  \`\`\`

---

## Resetting the Environment

If dependencies break or you want a clean slate:

\`\`\`bash
docker volume rm lora-trainer_venv-cache
bash setup.sh --no-cache
\`\`\`

This wipes the venv volume and rebuilds from scratch.
