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

# 3. Перезапускаем Gunicorn через наш скрипт (БЕЗ SUDO!)
/opt/cloud_storage/backend/run_gunicorn.sh restart

# 4. Для nginx оставляем инструкцию
echo ""
echo "✅ Code deployed and Gunicorn restarted!"
echo "For Nginx reload, run manually:"
echo "sudo systemctl reload nginx"
