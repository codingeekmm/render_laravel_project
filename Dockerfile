# Use an official PHP image as a base
FROM php:8.1-fpm

# Set the working directory in the container
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Install Composer (PHP dependency manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the Laravel application into the container
COPY . .

# Install Laravel dependencies
RUN composer install --optimize-autoloader --no-dev

# Set the correct permissions for storage and bootstrap/cache
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Expose the port the app will run on
EXPOSE 80

# Start the PHP-FPM server
CMD ["php-fpm"]
