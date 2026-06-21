# Cloud Storage - Django & React File Storage System

[![Django](https://img.shields.io/badge/Django-5.2.1-green.svg)](https://www.djangoproject.com/)
[![React](https://img.shields.io/badge/React-19.1.0-blue.svg)](https://reactjs.org/)
[![Python](https://img.shields.io/badge/Python-3.12+-yellow.svg)](https://www.python.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-12+-blue.svg)](https://www.postgresql.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Deployment](https://img.shields.io/badge/Deployment-Active-brightgreen.svg)](https://cloud.mikhailbbk.dev)
Полнофункциональное облачное хранилище файлов с веб-интерфейсом, построенное на стеке Django REST Framework + React. Поддерживает загрузку, хранение, категоризацию и безопасный доступ к файлам.

**Демо**: https://cloud.mikhailbbk.dev  
**GitHub Repository**: https://github.com/mikhailbbk/cloud_storage

## Содержание
- [Особенности](#особенности)
- [Архитектура](#архитектура)
- [Быстрый старт](#быстрый-старт)
- [Развертывание на VPS](#развертывание-на-vps)
- [Разработка](#разработка)
- [API Документация](#api-документация)
- [Структура проекта](#структура-проекта)

## Обзор проекта
**Cloud Storage** — это полнофункциональная облачная платформа для хранения и управления файлами, разработанная с использованием современных веб-технологий. Проект реализует концепцию персонального "Google Drive" или "Яндекс.Диска", предоставляя пользователям интуитивно понятный интерфейс для загрузки, организации, поиска и безопасного доступа к файлам через веб-браузер.

**Основная цель**: Создать масштабируемое, безопасное и отзывчивое веб-приложение, демонстрирующее полный цикл разработки full-stack приложения — от проектирования бэкенда на Django REST Framework до создания динамического фронтенда на React и развертывания на production-сервере (VPS).

**Статус проекта**: Production-ready | Автоматизированный деплой | SSL/TLS защита

## Ключевые особенности

### Backend (Django REST Framework)
- **Аутентификация**: JWT токены, сессии, OAuth2
- **Управление файлами**: Загрузка, скачивание, поиск, категории
- **Права доступа**: Ролевая модель (админ, пользователь, гость)
- **База данных**: PostgreSQL с оптимизацией для файловых метаданных
- **API**: Полный REST API с Swagger документацией
- **Производительность**: Кэширование, пагинация, оптимизация запросов

### Frontend (React)
- **Интерфейс**: Современный дизайн с Material-UI
- **Адаптивность**: Полная поддержка мобильных устройств
- **Real-time**: WebSocket для уведомлений о загрузке
- **Drag & Drop**: Интуитивная загрузка файлов
- **Поиск**: Быстрый поиск по файлам и метаданным
- **PWA**: Установка как нативное приложение

### DevOps & Infrastructure
- **Nginx + Gunicorn** — Оптимальная конфигурация для отдачи статики и обработки запросов.
- **Systemd Service Management** — Надежный запуск и мониторинг бэкенд-процессов.
- **SSL/TLS Encryption** — Защищенное соединение для всех данных.
- **Automated Backup Scripts** — Скрипты для резервного копирования базы данных и медиафайлов.

## Архитектура
```
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│ React SPA │────▶│ Nginx (8443) │────▶│ Gunicorn │
│ (Frontend) │ │ (Reverse │ │ (Django WSGI) │
│ Port: 3000 │◀────│ Proxy & SSL) │◀────│ Port: 8000 │
└─────────────────┘ └─────────────────┘ └─────────────────┘
│ │ │
│ │ │ PostgreSQL │
│ │ │ Database │
▼ ▼ └─────────────────┘
┌─────────────────┐ ┌─────────────────┐
│ Static Files │ │ Media Files │
│ (React Build) │ │ (Uploads) │
└─────────────────┘ └─────────────────┘
```

## Технологический стек
### Frontend Layer:
- **React 19** — Библиотека для построения пользовательских интерфейсов.
- **Material-UI (MUI)** — Компонентная библиотека для современного дизайна.
- **Axios** — HTTP-клиент для взаимодействия с API.
- **React Router** — Навигация между страницами приложения.
- **Context API / Hooks** — Управление состоянием приложения.
### Backend Layer:
- **Django 5 & Django REST Framework** — Фреймворк для быстрой разработки безопасного бэкенда и API.
- **PostgreSQL** — Промышленная реляционная СУБД для хранения данных.
- **Simple JWT** — Реализация JSON Web Tokens для аутентификации.
- **Gunicorn** — WSGI-сервер для запуска Django в production.
- **Python 3.12** — Основной язык программирования бэкенда.
### Infrastructure & DevOps:
- **Ubuntu / Nginx** — Операционная система и веб-сервер (обратный прокси).
- **Git / GitHub** — Контроль версий и хостинг кода.
- **Systemd** — Система инициализации и менеджер сервисов.
- **Bash Scripting** — Автоматизация развертывания и обслуживания.

## Функциональные модули
### 1. Модуль аутентификации и пользователей
- **Регистрация, вход, выход** — Полный цикл работы с учетными записями
- **Восстановление пароля** — Готовый механизм восстановления доступа
- **Профиль пользователя** — Квоты на дисковое пространство, статистика использования
### 2. Модуль управления файлами (ядро системы)
- **Многопоточная загрузка** — Загрузка файлов с прогресс-баром и паузой/возобновлением
- **Виртуальные папки и категории** — Гибкая организация файлов
- **Предпросмотр** — Изображения, текстовые файлы, PDF документы
- **Скачивание** — Одиночные файлы и архивы для множественного скачивания
- **Поиск и фильтрация** — По имени, типу, дате изменения, размеру
### 3. Модуль администрирования (Django Admin)
- **Полный контроль** — Управление пользователями, файлами, сессиями
- **Статистика** — Мониторинг использования системы, активность пользователей
- **Модерация контента** — Контроль загружаемого контента
### 4. Модуль безопасности
- **Валидация файлов** — Проверка типа, размера, MIME-типа
- **Защита от угроз** — XSS, CSRF, SQL-инъекции (стандартные механизмы Django)
- **Хэширование паролей** — Безопасное хранение учетных данных

### Структура проекта
```text
cloud_storage/
├── backend/                 # Django приложение
│   ├── accounts/           # Аутентификация и пользователи
│   ├── cloud_storage/      # Настройки проекта
│   ├── core/              # Основное приложение
│   ├── venv/              # Виртуальное окружение
│   ├── manage.py
│   └── requirements.txt
├── frontend/               # React приложение
│   ├── src/               # Исходный код
│   ├── public/            # Статические файлы
│   ├── package.json
│   └── yarn.lock
├── deploy-and-restart.sh   # Скрипт автоматического деплоя
└── README.md
```

## Быстрый старт

### Предварительные требования
- Python 3.8+
- Node.js 18+ (рекомендуется 22.14.0)
- PostgreSQL 12+
- Git

### Локальная установка

```bash
# Клонируем репозиторий
git clone https://github.com/mikhailbbk/cloud_storage.git
cd cloud_storage
git checkout server-version

# Backend
cd backend
python -m venv venv
source venv/bin/activate  # Linux/Mac: source venv/bin/activate
                          # Windows: venv\Scripts\activate
pip install -r requirements.txt
cp .env.example .env
# Отредактируйте .env файл с вашими настройками
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver

# Frontend (в другом терминале)
cd ../frontend
yarn install
yarn start
```

## Развертывание на VPS

### Системные требования
*   **ОС**: Ubuntu 20.04 LTS или выше
*   **Python:** 3.8+
*   **Django:** 5.2.1
*   **PostgreSQL:** 12+
*   **Node.js:** 18+ (22.14.0)
*   **React:** 18+ (19.1.0)
*   **Yarn:** 1.22+
*   **Nginx:** 1.18+
*   **Gunicorn:** 20.0+

## Пошаговая инструкция

### 1. Подготовка сервера
```bash
# Обновление системы
sudo apt update && sudo apt upgrade -y

# Установка необходимых пакетов
sudo apt install python3 python3-pip python3-venv nginx gunicorn postgresql postgresql-contrib git -y

# Установка Node.js
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs

# Настройка firewall
sudo ufw allow OpenSSH
sudo ufw allow 8443/tcp
sudo ufw --force enable

# Создание SSL директорий и генерация самоподписанного сертификата
sudo mkdir -p /etc/ssl/private /etc/ssl/certs
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/cloud_storage.key \
    -out /etc/ssl/certs/cloud_storage.crt \
    -subj "/C=RU/ST=Moscow/L=Moscow/O=CloudStorage/CN=194.67.124.178"

# Установка правил доступа к SSL файлам
sudo chmod 600 /etc/ssl/private/cloud_storage.key
sudo chmod 644 /etc/ssl/certs/cloud_storage.crt
```
### 2. Клонирование репозитория
```bash
# Клонируем проект в /opt
cd /opt
sudo git clone https://github.com/mikhailbbk/cloud_storage.git
sudo chown -R $USER:$USER cloud_storage
cd cloud_storage
git checkout server-version
```
### 3. Настройка базы данных PostgreSQL
```bash
# Входим в консоль PostgreSQL
sudo -u postgres psql

# Выполняем SQL команды:
CREATE DATABASE cloud_storage;
CREATE USER cloud_user WITH PASSWORD 'ваш_надежный_пароль';
GRANT ALL PRIVILEGES ON DATABASE cloud_storage TO cloud_user;
ALTER ROLE cloud_user SET client_encoding TO 'utf8';
ALTER ROLE cloud_user SET default_transaction_isolation TO 'read committed';
ALTER ROLE cloud_user SET timezone TO 'UTC';
\q
```
### 4. Настройка Backend (Django)
```bash
cd /opt/cloud_storage/backend

# Создание виртуального окружения
python3 -m venv venv
source venv/bin/activate

# Установка зависимостей
pip install --upgrade pip
pip install -r requirements.txt

# Генерация Django секретного ключа
DJANGO_SECRET=$(python3 -c "import secrets; print(secrets.token_urlsafe(50))")
echo "Сгенерированный SECRET_KEY: $DJANGO_SECRET"

# Настройка переменных окружения
cp .env.example .env
cat > .env << EOF
# Основные настройки Django
DJANGO_SECRET_KEY=$DJANGO_SECRET
DJANGO_DEBUG=False
DJANGO_ALLOWED_HOSTS=194.67.124.178,localhost,127.0.0.1

# Настройки базы данных PostgreSQL
DB_ENGINE=django.db.backends.postgresql
DB_NAME=cloud_storage
DB_USER=cloud_user
DB_PASSWORD=ваш_надежный_пароль
DB_HOST=localhost
DB_PORT=5432

# Безопасность (HTTPS на порту 8443)
CORS_ALLOWED_ORIGINS=https://194.67.124.178:8443
CSRF_TRUSTED_ORIGINS=https://194.67.124.178:8443

# Настройки файлов
MEDIA_URL=/media/
MEDIA_ROOT=/opt/cloud_storage/backend/media
STATIC_ROOT=/opt/cloud_storage/backend/staticfiles

# SSL настройки
SECURE_SSL_REDIRECT=True
SESSION_COOKIE_SECURE=True
CSRF_COOKIE_SECURE=True
EOF

# Применяем миграции
python manage.py migrate

# Создаем суперпользователя
python manage.py createsuperuser

# Собираем статические файлы
python manage.py collectstatic --noinput

# Создаем директорию для медиа файлов
mkdir -p media
```

### 5. Настройка Frontend (React)
```bash
cd /opt/cloud_storage/frontend

# Установка зависимостей
yarn install

# Создание production конфигурации
cat > .env.production << EOF
REACT_APP_API_URL=https://cloud.mikhailbbk.dev/api
REACT_APP_BASE_URL=https://cloud.mikhailbbk.dev
REACT_APP_WS_URL=wss://cloud.mikhailbbk.dev
EOF

# Сборка проекта
yarn run build
```
### 6. Создание пользователя для systemd службы
```bash
# Создаем пользователя для запуска приложения
sudo useradd -m -s /bin/bash cloudapp
sudo passwd cloudapp  # Установите надежный пароль
sudo usermod -aG www-data cloudapp

# Настраиваем права доступа
sudo chown -R cloudapp:www-data /opt/cloud_storage
sudo chmod -R 755 /opt/cloud_storage
```

### 7. Настройка Gunicorn как systemd сервиса
```bash
sudo nano /etc/systemd/system/cloud-storage.service
```
```ini
[Unit]
Description=Cloud Storage Django Application
After=network.target postgresql.service

[Service]
User=cloudapp
Group=www-data
WorkingDirectory=/opt/cloud_storage/backend
Environment="PATH=/opt/cloud_storage/backend/venv/bin"
Environment="DJANGO_SETTINGS_MODULE=core.settings"
ExecStart=/opt/cloud_storage/backend/venv/bin/gunicorn \
    --workers 3 \
    --bind unix:/opt/cloud_storage/backend/cloud_storage.sock \
    core.wsgi:application
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
```
```bash
# Активация службы
sudo systemctl daemon-reload
sudo systemctl start cloud-storage
sudo systemctl enable cloud-storage
sudo systemctl status cloud-storage --no-pager
```
### 8. Настройка Nginx с SSL (HTTPS на порту 8443)
```bash
sudo nano /etc/nginx/sites-available/cloud_storage
```
```nginx
server {
    listen 8443 ssl http2;
    server_name cloud.mikhailbbk.dev;
    
    # SSL конфигурация
    ssl_certificate /etc/ssl/certs/cloud_storage.crt;
    ssl_certificate_key /etc/ssl/private/cloud_storage.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    
    # Логи
    access_log /var/log/nginx/cloud_storage_access.log;
    error_log /var/log/nginx/cloud_storage_error.log;
    
    # Максимальный размер загружаемых файлов
    client_max_body_size 100M;
    
    # Статические файлы Django
    location /static/ {
        alias /opt/cloud_storage/backend/staticfiles/;
        expires 1y;
        add_header Cache-Control "public, immutable";
        access_log off;
    }
    
    # Медиа файлы (загруженные пользователями)
    location /media/ {
        alias /opt/cloud_storage/backend/media/;
        expires 30d;
        add_header Cache-Control "public";
        access_log off;
    }
    
    # API запросы
    location /api/ {
        proxy_pass http://unix:/opt/cloud_storage/backend/cloud_storage.sock;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # Таймауты для загрузки файлов
        proxy_connect_timeout 300s;
        proxy_send_timeout 300s;
        proxy_read_timeout 300s;
    }
    
    # WebSocket для real-time уведомлений
    location /ws/ {
        proxy_pass http://unix:/opt/cloud_storage/backend/cloud_storage.sock;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
    
    # React SPA
    location / {
        root /opt/cloud_storage/frontend/build;
        try_files $uri $uri/ /index.html;
        expires 1h;
        add_header Cache-Control "public, max-age=3600";
    }
    
    # Защитные заголовки для HTTPS
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    
    # Блокируем доступ к скрытым файлам
    location ~ /\. {
        deny all;
        access_log off;
        log_not_found off;
    }
}
```
```bash
# Активация конфигурации Nginx
sudo ln -sf /etc/nginx/sites-available/cloud_storage /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

# Проверка конфигурации
sudo nginx -t

# Перезапуск Nginx
sudo systemctl restart nginx
sudo systemctl status nginx --no-pager
```
### 9. Автоматизация деплоя
#### Используйте встроенный скрипт для быстрого обновления:

```bash
# Создаем скрипт для автоматического обновления
cat > /opt/cloud_storage/deploy-and-restart.sh << 'EOF'
#!/bin/bash
echo "=== Начало деплоя Cloud Storage ==="
cd /opt/cloud_storage

echo "1. Получение обновлений из Git..."
git pull origin server-version

echo "2. Обновление Backend..."
cd backend
source venv/bin/activate
pip install -r requirements.txt --upgrade
python manage.py migrate
python manage.py collectstatic --noinput
deactivate

echo "3. Обновление Frontend..."
cd ../frontend
yarn install
yarn run build

echo "4. Перезапуск сервисов..."
sudo systemctl restart cloud-storage
sudo systemctl reload nginx

echo "5. Проверка статуса..."
sudo systemctl status cloud-storage --no-pager | head -20
sudo systemctl status nginx --no-pager | head -10

echo "=== Деплой завершен ==="
EOF

chmod +x /opt/cloud_storage/deploy-and-restart.sh
```

## Проверка установки
После завершения установки выполните проверку:
```bash
# Создаем скрипт проверки
cat > /opt/cloud_storage/check-installation.sh << 'EOF'
#!/bin/bash
echo "=== Проверка установки Cloud Storage ==="
echo

echo "1. Проверка сервисов:"
echo "   - Gunicorn:"
sudo systemctl is-active cloud-storage > /dev/null && echo "   ✅ Запущен" || echo "   ❌ Не запущен"
echo "   - Nginx:"
sudo systemctl is-active nginx > /dev/null && echo "   ✅ Запущен" || echo "   ❌ Не запущен"

echo
echo "2. Проверка портов:"
echo "   - Порт 8443:"
sudo netstat -tlnp | grep :8443 && echo "   ✅ Слушается" || echo "   ❌ Не слушается"

echo
echo "3. Проверка доступности:"
echo "   - Веб-интерфейс:"
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" https://cloud.mikhailbbk.dev)
[ "$HTTP_CODE" = "200" ] && echo "   ✅ Доступен (код: $HTTP_CODE)" || echo "   ❌ Недоступен (код: $HTTP_CODE)"

echo
echo "4. Проверка API:"
API_CHECK=$(curl -s https://cloud.mikhailbbk.dev/api/ | head -c 20)
[ -n "$API_CHECK" ] && echo "   ✅ API отвечает" || echo "   ❌ API не отвечает"

echo
echo "5. Проверка статических файлов:"
STATIC_CHECK=$(curl -s -I https://cloud.mikhailbbk.dev/static/ 2>/dev/null | head -n 1)
[[ "$STATIC_CHECK" == *"200"* || "$STATIC_CHECK" == *"404"* ]] && \
echo "   ✅ Статика настроена" || echo "   ❌ Проблема со статикой"

echo
echo "=== Проверка завершена ==="
EOF

chmod +x /opt/cloud_storage/check-installation.sh
/opt/cloud_storage/check-installation.sh
```

## Разработка

### Скрипты разработки
```bash
# Запуск в режиме разработки
cd backend && source venv/bin/activate && python manage.py runserver
cd frontend && yarn start

# Тестирование
cd backend && python manage.py test
cd frontend && yarn test

# Проверка кода
cd backend && flake8 .
cd frontend && yarn run lint
```
## API Документация
* После успешной установки API доступно по адресам:

- **Основное API**: https://cloud.mikhailbbk.dev/api/
- **Swagger UI**: https://cloud.mikhailbbk.dev/swagger/
- **ReDoc**: https://cloud.mikhailbbk.dev/redoc/
- **Админ-панель**: https://cloud.mikhailbbk.dev/admin/

### Основные endpoints:
- POST /api/auth/login/ - Вход в систему
- POST /api/auth/register/ - Регистрация нового пользователя
- POST /api/auth/logout/ - Выход из системы
- GET /api/auth/user/ - Информация о текущем пользователе
### Управление файлами
- GET /api/files/ - Список файлов (с пагинацией)
- POST /api/files/upload/ - Загрузка файла
- GET /api/files/{id}/ - Детальная информация о файле
- GET /api/files/{id}/download/ - Скачивание файла
- DELETE /api/files/{id}/ - Удаление файла
- PUT /api/files/{id}/ - Обновление метаданных файла

### Категории
- GET /api/categories/ - Список категорий
- POST /api/categories/ - Создание категории
- GET /api/categories/{id}/files/ - Файлы в категории

## 🔧 Управление проектом
### Обновление production
```bash
cd /opt/cloud_storage
./deploy-and-restart.sh
```

### Мониторинг
```bash
# Логи Django приложения
sudo journalctl -u cloud-storage -f

# Логи Nginx
sudo tail -f /var/log/nginx/cloud_storage_error.log
sudo tail -f /var/log/nginx/cloud_storage_access.log

# Проверка статуса
sudo systemctl status cloud-storage --no-pager
sudo systemctl status nginx --no-pager
```
### Резервное копирование
```bash
#!/bin/bash
# backup.sh
BACKUP_DIR="/backup/cloud_storage"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

# Создаем директорию для бекапов
mkdir -p $BACKUP_DIR

# Бекап базы данных
sudo -u postgres pg_dump -Fc cloud_storage > $BACKUP_DIR/db_$DATE.dump

# Бекап медиа файлов
tar -czf $BACKUP_DIR/media_$DATE.tar.gz /opt/cloud_storage/backend/media

# Бекап проекта
tar -czf $BACKUP_DIR/project_$DATE.tar.gz \
    --exclude=venv \
    --exclude=node_modules \
    /opt/cloud_storage

# Удаляем старые бекапы (старше 30 дней)
find $BACKUP_DIR -name "*.dump" -mtime +30 -delete
find $BACKUP_DIR -name "*.tar.gz" -mtime +30 -delete

echo "Резервное копирование завершено: $BACKUP_DIR"
```

## Устранение неполадок
### Распространенные проблемы
#### 1. Ошибка 502 Bad Gateway

```bash
# Проверяем Gunicorn
sudo systemctl status cloud-storage
sudo journalctl -u cloud-storage -n 50 --no-pager

# Проверяем сокет
ls -la /opt/cloud_storage/backend/cloud_storage.sock
sudo chown cloudapp:www-data /opt/cloud_storage/backend/cloud_storage.sock

# Перезапускаем
sudo systemctl restart cloud-storage
```
#### 2. Статические файлы не загружаются

```bash
# Проверяем права
sudo chown -R cloudapp:www-data /opt/cloud_storage/frontend/build
sudo chmod -R 755 /opt/cloud_storage/frontend/build
sudo chown -R cloudapp:www-data /opt/cloud_storage/backend/staticfiles
sudo chmod -R 755 /opt/cloud_storage/backend/staticfiles

# Пересобираем статику
cd /opt/cloud_storage/backend
source venv/bin/activate
python manage.py collectstatic --noinput
```
#### 3. Ошибки базы данных

```bash
# Проверяем подключение к БД
sudo -u postgres psql -c "\l"
sudo -u postgres psql -d cloud_storage -c "\dt"

# Проверяем пользователя БД
sudo -u postgres psql -c "\du"

# Восстанавливаем права
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE cloud_storage TO cloud_user;"
```
#### 4. React приложение не обновляется
```bash
# Пересобираем React
cd /opt/cloud_storage/frontend
rm -rf build node_modules/.cache
yarn run build

# Перезапускаем Nginx
sudo systemctl restart nginx
```

### Диагностика
```bash
# Проверка процессов
ps aux | grep -E '(gunicorn|nginx|node)'

# Проверка сетевых подключений
sudo netstat -tlnp | grep :8443

# Проверка использования ресурсов
free -h
df -h
top -bn1 | head -20
```

## Автор
Михаил

**GitHub:** @mikhailbbk  
**Telegram**: @mikhailbbk  
**Email**: mikhailbbk.dev@gmail.com  
**Сайт**: https://cloud.mikhailbbk.dev
