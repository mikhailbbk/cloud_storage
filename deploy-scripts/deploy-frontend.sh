#!/bin/bash

# Скрипт деплоя фронтенда

set -e

echo "🚀 Деплой фронтенда..."

cd /opt/cloud_storage/frontend

# Установка зависимостей и сборка
if [ -f "package.json" ]; then
    yarn install --frozen-lockfile
    yarn build
else
    echo "⚠️  Файл package.json не найден"
fi

echo "✅ Деплой фронтенда завершен!"