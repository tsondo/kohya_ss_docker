# HOWTO: Installing Docker with GPU Support (WSL + Linux)

This guide walks you through installing Docker and enabling GPU acceleration so you can use **lora-trainer** on Windows (via WSL2) or Linux.

---

## 🐧 Linux (Ubuntu/Debian/Arch)

1. **Install Docker Engine**

Follow the official instructions:  
https://docs.docker.com/engine/install/

2. **Install Docker Compose plugin**

\`\`\`bash
sudo apt install docker-compose-plugin
\`\`\`

3. **Add your user to the Docker group (optional)**

\`\`\`bash
sudo usermod -aG docker $USER
newgrp docker
\`\`\`

4. **Verify installation**

\`\`\`bash
docker run --rm hello-world
\`\`\`

If you see the hello‑world message, Docker is working.

5. **Verify GPU support**

\`\`\`bash
docker run --rm --gpus all nvidia/cuda:12.8.0-runtime-ubuntu22.04 nvidia-smi
\`\`\`

You should see your GPU listed.

---

## 🪟 Windows (Docker Desktop + WSL2)

1. **Install Docker Desktop**  
   Download from: https://www.docker.com/products/docker-desktop/

2. **Enable WSL2 integration** during setup.

3. **Install a Linux distro** (Ubuntu recommended) from the Microsoft Store.

4. **Open your WSL terminal** (Ubuntu).

5. **Verify Docker inside WSL**

\`\`\`bash
docker run --rm hello-world
\`\`\`

6. **Verify GPU support**

\`\`\`bash
docker run --rm --gpus all nvidia/cuda:12.8.0-runtime-ubuntu22.04 nvidia-smi
\`\`\`

---

