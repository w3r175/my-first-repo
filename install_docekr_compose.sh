#!/bin/bash

# Обновляем систему
sudo apt update && sudo apt upgrade -y

# Устанавливаем зависимости
sudo apt install ca-certificates curl gnupg lsb-release -y

# Добавляем официальный ключ Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Добавляем репозиторий Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Устанавливаем Docker + Docker Compose v2
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Добавляем пользователя в группу docker (чтобы не писать sudo)
sudo usermod -aG docker $USER

echo "✅ Docker и Docker Compose установлены!"
echo "➡️ Перезайди в SSH (или выполни 'newgrp docker'), чтобы применить изменения"
echo "Проверка версий:"
docker --version
docker compose version
