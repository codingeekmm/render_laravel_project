
#!/usr/bin/env bash
echo "Running composer"

# Installing dependencies (no need for hirak/prestissimo if using Composer v2)
composer install --no-dev --working-dir=/var/www/html

echo "Generating application key..."
# This command will set the key in .env
php artisan key:generate

echo "Caching config..."
php artisan config:cache

echo "Caching routes..."
php artisan route:cache

echo "Running migrations..."
# Force flag to run migrations in production
php artisan migrate --force
