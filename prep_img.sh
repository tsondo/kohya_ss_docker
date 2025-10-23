#!/bin/bash
echo "📸 Prepping Nomi images for LoRA training..."

# Create output folder if it doesn't exist
mkdir -p ~/nomi_prepped

# Convert and pad WEBP images to PNG
for img in ~/nomi_raw/*.webp; do
  out="$HOME/nomi_prepped/$(basename "$img" .webp).png"
  convert "$img" -resize x1024 -background black -gravity center -extent 1024x1024 "$out"
  echo "✅ Converted: $(basename "$img") → $(basename "$out")"
done

# Pad existing PNGs (no format change)
for img in ~/nomi_raw/*.png; do
  out="$HOME/nomi_prepped/$(basename "$img")"
  convert "$img" -resize x1024 -background black -gravity center -extent 1024x1024 "$out"
  echo "✅ Padded: $(basename "$img")"
done

echo "🎉 All images prepped and saved to ~/nomi_prepped"
``
