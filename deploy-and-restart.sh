#!/bin/bash
set -e

echo "=== Deploying Cloud Storage ==="

# 1. Обновляем код
cd /opt/cloud_storage
git pull origin server-version

# 2. Устанавливаем зависимости
cd backend
source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate --noinput
python manage.py collectstatic --noinput
deactivate

# 3. Перезапускаем Gunicorn (БЕЗ SUDO!)
/opt/cloud_storage/backend/run_gunicorn.sh restart

# 4. Перезагружаем Nginx (если запущен)
if sudo systemctl is-active --quiet nginx; then
    sudo systemctl reload nginx
    echo "✅ Nginx reloaded"
else
    echo "⚠️  Nginx is not running"
fi

echo ""
echo "✅ FULLY AUTOMATED DEPLOYMENT COMPLETED!"
