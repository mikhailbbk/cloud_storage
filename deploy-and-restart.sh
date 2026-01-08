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
echo -e "\n2. Setting up backend..."
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
echo -e "\n3. Setting up frontend..."
cd ../frontend

echo "   Building frontend..."
npm run build

# 4. Перезапуск сервисов
echo -e "\n4. Restarting services..."

# Gunicorn
echo "   Restarting Gunicorn..."
cd ../backend
./run_gunicorn.sh restart

# Nginx - пропускаем перезагрузку для GitHub Actions
echo "   Nginx reload: skipped (for GitHub Actions)"
echo "   Note: Nginx automatically serves updated static files"
echo "   To manually reload: sudo systemctl reload nginx"

# 5. Проверка
echo -e "\n5. Verification..."
sleep 2

echo -n "   Django API: "
if curl -s -f http://127.0.0.1:8001/api/ > /dev/null 2>&1; then
    echo "✅ running"
else
    echo "❌ not responding"
fi

echo -n "   Frontend: "
if curl -s -f -k https://194.67.124.178:8443/ > /dev/null 2>&1; then
    echo "✅ served"
else
    echo "❌ not served"
fi

echo ""
echo "========================================"
echo "✅ DEPLOYMENT COMPLETED SUCCESSFULLY!"
echo "Application available at: https://194.67.124.178:8443"
echo "========================================"
