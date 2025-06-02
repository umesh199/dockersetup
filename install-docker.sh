#!/bin/bash

set -e

echo "==> Checking if Docker is already installed..."
if command -v docker &> /dev/null; then
  echo "✅ Docker is already installed. Skipping installation."
  exit 0
fi

echo "==> Installing prerequisites..."
sudo dnf install -y yum-utils device-mapper-persistent-data lvm2

echo "==> Adding Docker CE repository..."
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "==> Installing Docker CE..."
sudo dnf install -y docker-ce docker-ce-cli containerd.io

echo "==> Enabling and starting Docker service..."
sudo systemctl enable --now docker

echo "==> Adding current user ($USER) to docker group..."
sudo usermod -aG docker $USER

echo "==> Docker installation complete. You may need to log out and back in for group changes to apply."
docker version || echo "🔁 Please log out and back in, then run 'docker version' again."
