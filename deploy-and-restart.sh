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
git pull origin server-version

# 2. Настройка бэкенда
echo -e "\n2. Setting up backend..."
cd backend

# Проверяем виртуальное окружение
if [ ! -d "venv" ]; then
    echo "   Creating virtual environment..."
    python3 -m venv venv
fi

source venv/bin/activate

# Устанавливаем зависимости
echo "   Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Применяем миграции
echo "   Applying migrations..."
python manage.py migrate --noinput

# Собираем статику
echo "   Collecting static files..."
python manage.py collectstatic --noinput --clear

deactivate

# 3. Настройка фронтенда
echo -e "\n3. Setting up frontend..."
cd ../frontend

# Проверяем зависимости
if [ ! -d "node_modules" ]; then
    echo "   Installing npm dependencies..."
    npm install
fi

# Собираем фронтенд
echo "   Building frontend..."
npm run build

# 4. Перезапуск сервисов
echo -e "\n4. Restarting services..."

# Gunicorn
echo "   Restarting Gunicorn..."
cd ../backend
./run_gunicorn.sh restart

# Nginx - используем sudo без пароля через настройки sudoers
echo "   Reloading Nginx..."
if sudo systemctl is-active --quiet nginx; then
    sudo nginx -t && sudo systemctl reload nginx
    echo "   ✅ Nginx reloaded successfully"
else
    echo "   ⚠️  Starting Nginx..."
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo "   ✅ Nginx started and enabled"
fi

# 5. Проверка
echo -e "\n5. Verification..."
sleep 3

echo -n "   Django API: "
if curl -s http://127.0.0.1:8001/api/ > /dev/null; then
    echo "✅ running"
else
    echo "❌ not responding"
fi

echo -n "   Nginx (8443): "
if curl -k -s https://194.67.124.178:8443/api/ > /dev/null; then
    echo "✅ working"
else
    echo "❌ not responding"
fi

echo -n "   Frontend: "
if curl -k -s https://194.67.124.178:8443/ | grep -qi "doctype html"; then
    echo "✅ served correctly"
else
    echo "❌ not served correctly"
fi

echo ""
echo "========================================"
echo "✅ DEPLOYMENT COMPLETED SUCCESSFULLY!"
echo "Application available at: https://194.67.124.178:8443"
echo "========================================"
