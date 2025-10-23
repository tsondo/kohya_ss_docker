# CUDA 12.8 base image to match ComfyUI
FROM nvidia/cuda:12.2.0-cudnn8-runtime-ubuntu22.04

# System dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv git \
    libgl1 libglib2.0-0 ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip globally
RUN python3 -m pip install --upgrade pip

WORKDIR /workspace

# Clone Kohya_ss LoRA trainer
RUN git clone https://github.com/bmaltais/kohya_ss.git /workspace/kohya_ss
WORKDIR /workspace/kohya_ss

# Create virtual environment and install dependencies
RUN python3 -m venv /workspace/kohya_ss/venv && \
    /workspace/kohya_ss/venv/bin/pip install --upgrade pip && \
    # Match Torch stack with ComfyUI
    /workspace/kohya_ss/venv/bin/pip install --pre torch torchvision \
        --index-url https://download.pytorch.org/whl/nightly/cu128 && \
    /workspace/kohya_ss/venv/bin/pip install \
        accelerate==0.34.2 \
        pytorch-lightning==1.9.4 \
        pytorch-triton==3.5.0+gitbbb06c03 \
        torchdiffeq==0.2.3 \
        torchmetrics==1.8.2 \
        torchsde==0.2.6 && \
    /workspace/kohya_ss/venv/bin/pip install --pre xformers \
        --index-url https://download.pytorch.org/whl/nightly/cu128 && \
    # Strip conflicting torch entries before installing requirements
    sed -i '/^torch$/d' requirements.txt && \
    sed -i '/^torchvision$/d' requirements.txt && \
    sed -i '/^torchaudio$/d' requirements.txt && \
    /workspace/kohya_ss/venv/bin/pip install -r requirements.txt && \
    # Add bitsandbytes for LoRA optimization
    /workspace/kohya_ss/venv/bin/pip install bitsandbytes

# Entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
