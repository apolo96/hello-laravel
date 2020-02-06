# Install dependencies
FROM composer:1.8 AS composer

WORKDIR /app
COPY . .
RUN composer install --optimize-autoloader --no-dev

# Package App
FROM apolo96/php-7.4-nginx:alpine

WORKDIR /var/www/html

COPY --from=composer /app .

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

COPY --chown=www-data:www-data . /var/www/html

RUN cp .env.prod .env

RUN php artisan key:generate

RUN php artisan optimize





