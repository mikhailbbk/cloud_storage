#!/bin/bash
set -e

echo "🚀 Starting backend deployment..."

cd /opt/cloud_storage/backend

# Stop gunicorn if running
sudo systemctl stop gunicorn 2>/dev/null || true

# Setup virtual environment
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

source venv/bin/activate

# Install/upgrade dependencies
echo "Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Apply database migrations
echo "Applying database migrations..."
python manage.py migrate --noinput

# Collect static files
echo "Collecting static files..."
python manage.py collectstatic --noinput --clear

# Create superuser if doesn't exist (optional)
echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.filter(username='admin').exists() or User.objects.create_superuser('admin', 'admin@example.com', 'admin123')" | python manage.py shell || echo "Superuser creation skipped or failed"

# Set proper permissions
echo "Setting permissions..."
sudo chown -R $USER:www-data /opt/cloud_storage
sudo chmod -R 755 /opt/cloud_storage
sudo chown www-data:www-data /opt/cloud_storage/backend/cloud_storage.sock 2>/dev/null || true

# Start gunicorn
echo "Starting Gunicorn..."
sudo systemctl start gunicorn

echo "✅ Backend deployment completed!"