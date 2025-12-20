#!/bin/bash

set -e

echo "🚀 Начинаем настройку сервера..."

# Обновление системы
sudo apt update && sudo apt upgrade -y

# Установка необходимых пакетов
sudo apt install -y python3 python3-pip python3-venv nginx postgresql postgresql-contrib git curl

# Установка Node.js 18+
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Установка Yarn
sudo npm install -g yarn

# Создание структуры каталогов
sudo mkdir -p /opt/cloud_storage
sudo mkdir -p /opt/cloud_storage/backend
sudo mkdir -p /opt/cloud_storage/frontend
sudo mkdir -p /opt/cloud_storage/logs
sudo mkdir -p /opt/cloud_storage/media
sudo mkdir -p /opt/cloud_storage/static

# Настройка прав доступа
sudo chown -R $USER:$USER /opt/cloud_storage
sudo chmod -R 755 /opt/cloud_storage

# Настройка PostgreSQL
sudo -u postgres psql << EOF
CREATE DATABASE cloud_storage;
CREATE USER cloud_user WITH PASSWORD '$DB_PASSWORD';
ALTER ROLE cloud_user SET client_encoding TO 'utf8';
ALTER ROLE cloud_user SET default_transaction_isolation TO 'read committed';
ALTER ROLE cloud_user SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE cloud_storage TO cloud_user;
\q
EOF

# Копирование конфигурационных файлов
cp /opt/cloud_storage/server-configs/nginx.conf /etc/nginx/sites-available/cloud_storage
cp /opt/cloud_storage/server-configs/gunicorn.service /etc/systemd/system/

# Активация Nginx конфигурации
sudo ln -sf /etc/nginx/sites-available/cloud_storage /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx

# Настройка брандмауэра
sudo ufw allow 'Nginx Full'
sudo ufw allow OpenSSH
sudo ufw --force enable

echo "✅ Настройка сервера завершена!"