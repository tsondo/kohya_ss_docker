# 🐧 Installing Docker on Linux (Ubuntu 22.04+)

Follow these steps to set up Docker with GPU support on Linux. Once complete, you can run kohya_ss_docker containers as described in the main README.

---

## 1. Install Docker Engine

On Ubuntu/Debian:

    sudo apt update && sudo apt upgrade -y
    sudo apt install ca-certificates curl gnupg lsb-release -y

    # Add Docker’s official GPG key
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
      | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    # Add Docker repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
      | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Install Docker Engine and Compose plugin
    sudo apt update
    sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

---

## 2. Add Your User to the Docker Group

By default, Docker requires `sudo`. To run it as your normal user:

    sudo usermod -aG docker $USER
    newgrp docker

Now you can run `docker ps` without `sudo`.

---

## 3. Install NVIDIA Container Toolkit

This enables GPU passthrough into Docker containers.

    distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
    curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey \
      | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit.gpg

    curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list \
      | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

    sudo apt update
    sudo apt install -y nvidia-container-toolkit
    sudo nvidia-ctk runtime configure --runtime=docker
    sudo systemctl restart docker

---

## 4. Verify Installation

    docker run --rm hello-world

GPU test:

    docker run --rm --gpus all nvidia/cuda:12.8.0-runtime-ubuntu22.04 nvidia-smi

You should see your GPU listed.

---

✅ That’s it — Docker is ready. Head back to the main README for instructions on cloning the repo and running the container.

---
