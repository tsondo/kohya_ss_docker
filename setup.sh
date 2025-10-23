#!/bin/bash

echo "🔧 Setting up LoRA Trainer workspace..."

# Create folder structure
mkdir -p dataset
mkdir -p models
mkdir -p config
mkdir -p output

echo "📁 Created folders: dataset/, models/, config/, output/"

# Build and launch the container
echo "🐳 Building Docker image and starting container..."
docker compose -f docker-compose.yml up --build

echo "✅ LoRA Trainer is now running."
echo "📸 Drop your Nomi selfies into dataset/, base model into models/, and config JSON into config/"
