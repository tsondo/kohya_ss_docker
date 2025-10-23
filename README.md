![Build](https://img.shields.io/badge/build-passing-brightgreen)
![CUDA](https://img.shields.io/badge/CUDA-12.8-blue)
![Torch](https://img.shields.io/badge/Torch-2.2.2-informational)
![xFormers](https://img.shields.io/badge/xFormers-enabled-success)
![License](https://img.shields.io/github/license/tsondo/lora-trainer)

# 🧩 lora-trainer

A reproducible, persistent Docker setup for running [Kohya_ss LoRA Trainer](https://github.com/bmaltais/kohya_ss) with GPU acceleration, clean config management, and out‑of‑the‑box defaults that mirror the design of [a1111-docker](https://github.com/tsondo/a1111-docker).

---

📖 New to WSL/Docker on Windows?  
See the HOWTO guide (HOWTO.md) for step‑by‑step instructions on installing Docker inside WSL (Ubuntu 22.04) before using this project.

📘 New to Docker or LoRA training in general?  
Check out GETTING_STARTED.md for a plain‑language introduction: what Docker is, what Kohya does, what’s persistent vs. ephemeral in this build, and how to prepare your first dataset.

---

## 🐧 Setup for Linux (Ubuntu, Debian, Arch, etc.)

### 1. Clone the repo

\`\`\`bash
git clone https://github.com/tsondo/lora-trainer.git ~/lora-trainer
cd ~/lora-trainer
\`\`\`

### 2. Install Docker and Docker Compose

Follow official instructions:  
https://docs.docker.com/engine/install/

Then install Docker Compose plugin:

\`\`\`bash
sudo apt install docker-compose-plugin
\`\`\`

(Optional) Add your user to the Docker group:

\`\`\`bash
sudo usermod -aG docker $USER
newgrp docker
\`\`\`

### 3. Run setup and launch

\`\`\`bash
bash setup.sh
docker compose run --rm lora-trainer
\`\`\`

This drops you into an interactive shell inside the container with the venv already activated.

---

## 🪟 Setup for Windows (Docker Desktop + WSL2)

1. Install Docker Desktop:  
   https://www.docker.com/products/docker-desktop/  
   Enable WSL2 integration during setup.

2. Open your WSL terminal (Ubuntu recommended).

3. Clone the repo inside WSL:

\`\`\`bash
git clone https://github.com/tsondo/lora-trainer.git ~/lora-trainer
cd ~/lora-trainer
\`\`\`

4. Run setup:

\`\`\`bash
bash setup.sh
\`\`\`

Then launch training with:

\`\`\`bash
docker compose run --rm lora-trainer
\`\`\`

**Important:** Run all commands inside WSL — not PowerShell or CMD.  
Your persistent folders live inside your WSL home directory.

---

## 🚀 What setup.sh does

- Creates persistent folders for configs, dataset, models, and outputs  
- Prepopulates sample config files if missing  
- Ensures correct ownership and permissions  
- Prepares everything for docker compose run  

---

## 🧱 Persistent Folders

| Host Folder | Container Path       | Purpose                           |
|-------------|----------------------|-----------------------------------|
| configs/    | /workspace/configs   | Training configs & sample prompts |
| dataset/    | /workspace/dataset   | Training images & captions        |
| models/     | /workspace/models    | Base models (e.g. SDXL)           |
| output/     | /workspace/output    | Trained LoRAs, logs, samples      |

Additionally, the Python venv is persisted in a Docker volume (venv-cache) so you don’t reinstall dependencies on every rebuild.

---

## 📦 Sample Configs

The repo ships with ready‑to‑use configs in configs/:

- config_lora-sample.toml → baseline LoRA training config  
- dataset_lora.toml → dataset definition  
- sample_prompts.txt → prompts for validation images  

To train immediately, drop your images into dataset/images/ and your base model into models/, then run:

\`\`\`bash
docker compose run --rm lora-trainer \
  accelerate launch ./sd-scripts/sdxl_train_network.py \
  --config_file /workspace/configs/config_lora-sample.toml
\`\`\`

---

## 🔁 Daily Usage

- Start interactive shell:

\`\`\`bash
docker compose run --rm lora-trainer
\`\`\`

- Run training directly:

\`\`\`bash
docker compose run --rm lora-trainer \
  accelerate launch ./sd-scripts/sdxl_train_network.py \
  --config_file /workspace/configs/config_lora-sample.toml
\`\`\`

- Stop containers:

\`\`\`bash
docker compose down
\`\`\`

---

## 🧪 Optional: Force rebuild with --no-cache

\`\`\`bash
bash setup.sh --no-cache
\`\`\`

---

## 🛠 Troubleshooting

- CUDA kernel errors → Ensure you’re on CUDA 12.8 drivers and using the provided Dockerfile (pinned Torch/xFormers stack).  
- No dataset found → Check that your images are inside dataset/images/ and that dataset_lora.toml points to the right path.  
- Reset venv → Remove the Docker volume:  

\`\`\`bash
docker volume rm lora-trainer_venv-cache
\`\`\`

---

## 📜 License

MIT — see LICENSE.
