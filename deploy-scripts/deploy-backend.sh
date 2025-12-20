#!/bin/bash

# Скрипт деплоя бэкенда

set -e

echo "🚀 Деплой бэкенда..."

cd /opt/cloud_storage/backend

# Активация виртуального окружения
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi
source venv/bin/activate

# Установка зависимостей
pip install --upgrade pip
pip install -r requirements.txt

# Применение миграций
python manage.py migrate --noinput

# Сбор статических файлов
python manage.py collectstatic --noinput --clear

# Создание суперпользователя (если не существует)
echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.filter(username='admin').exists() or User.objects.create_superuser('admin', 'admin@example.com', 'admin123')" | python manage.py shell

# Настройка прав доступа
sudo chown -R www-data:www-data /opt/cloud_storage
sudo chmod -R 755 /opt/cloud_storage

echo "✅ Деплой бэкенда завершен!"