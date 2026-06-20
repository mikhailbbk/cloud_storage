#!/bin/bash
set -e

echo "=== Deploying Cloud Storage ==="
echo "Timestamp: $(date)"
echo ""

# 1. Обновляем код
echo "1. Updating code from Git..."
cd /opt/cloud_storage
git fetch origin
git checkout server-version
git reset --hard origin/server-version

# 2. Настройка бэкенда
echo ""
echo "2. Setting up backend..."
cd backend
source venv/bin/activate

echo "   Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

echo "   Applying migrations..."
python manage.py migrate --noinput

echo "   Collecting static files..."
python manage.py collectstatic --noinput --clear
deactivate

# 3. Настройка фронтенда
echo ""
echo "3. Setting up frontend..."
cd ../frontend
echo "   Installing dependencies..."
yarn install

echo "   Building frontend..."
yarn run build

# 4. Перезапуск сервисов
echo ""
echo "4. Restarting services..."
echo "   Restarting Gunicorn..."
systemctl restart cloud_storage

echo "   Reloading Nginx..."
systemctl reload nginx

# 5. Проверка
echo ""
echo "5. Verification..."
sleep 3

echo -n "   Django API (socket): "
if curl -s --unix-socket /opt/cloud_storage/backend/cloud_storage.sock http://localhost/api/ > /dev/null 2>&1; then
    echo "✅ running"
else
    echo "❌ not responding"
fi

echo -n "   Frontend (https): "
if curl -s -f -k https://cloud.mikhailbbk.dev/ > /dev/null 2>&1; then
    echo "✅ served"
else
    echo "❌ not served"
fi

echo ""
echo "========================================"
echo "✅ DEPLOYMENT COMPLETED SUCCESSFULLY!"
echo "Application available at: https://cloud.mikhailbbk.dev"
echo "========================================"
