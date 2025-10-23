# Getting Started with kohya_ss_docker

This guide is for anyone new to Docker or kohya_ss. It explains the basics in plain language and points you back to the main [README.md](README.md) for deeper technical details.

---

## 🐳 What is Docker?

Docker packages software into **containers**.  
Think of a container as a lightweight, portable box that includes everything the program needs (libraries, dependencies, configs).  
The benefit: the software runs the same way on any machine, without you having to manually install all the pieces.

---

## 🎨 What is kohya_ss?

[kohya_ss](https://github.com/bmaltais/kohya_ss) is a popular trainer for **LoRA fine‑tuning** of Stable Diffusion models.  
It lets you adapt large diffusion models (like SDXL) to your own dataset with efficient training.

---

## 📦 Why this build?

This Docker setup separates what’s **ephemeral** (rebuilt each time) from what’s **persistent** (your data and results):

- **Ephemeral (inside the container):**
  - Python environment
  - Installed packages
  - The container filesystem itself

- **Persistent (mounted from your host):**
  - `models/` → base models (e.g. SDXL checkpoints)
  - `dataset/` → your training images and captions
  - `configs/` → TOML configs and sample prompts
  - `output/` → trained LoRAs, logs, and samples
  - `venv-cache/` → cached Python environment

This means you can rebuild or update the container at any time without losing your models, configs, or outputs.

---

## 🚀 How to run

See the [README.md](README.md) for full setup instructions.  
In short: run the provided `setup.sh` script, then start training with:

    docker compose run --rm lora-trainer \
      accelerate launch ./sd-scripts/sdxl_train_network.py \
      --config_file /workspace/configs/config_lora-sample.toml

---

## 🧩 Adding models and datasets

1. Place a base model checkpoint (`.safetensors` or `.ckpt`) in `models/`.
2. Place your training images and captions under `dataset/`.
3. Adjust the TOML config in `configs/` to point to your dataset and model.
4. Run training as shown above.

---

## ✅ Summary

- Docker runs kohya_ss in a clean, reproducible environment.
- Your models, datasets, configs, and outputs are **persistent** on your host.
- Add base models under `models/` and datasets under `dataset/` to get started.
- Launch training with `docker compose run …`.
- For full details, see the main [README.md](README.md).
