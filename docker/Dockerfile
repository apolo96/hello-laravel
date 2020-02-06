FROM php:7.4.0-fpm

LABEL maintainer="apolo96 - andresfpvclap@gmail.com"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    default-mysql-client \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    zlib1g-dev \
    libzip-dev \
    locales \
    jpegoptim optipng pngquant gifsicle \
    nginx \
    supervisor \
    apt-utils \
    unzip \
    zip \
    curl

# Install php extensions
RUN docker-php-ext-configure zip --with-zip
RUN docker-php-ext-install pdo_mysql zip exif pcntl bcmath
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

# Install php redis
RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && echo "daemon off;" >> /etc/nginx/nginx.conf

# Copy config services file
COPY services-worker.conf /etc/supervisor/conf.d
COPY nginx/default /etc/nginx/sites-enabled/default
COPY php/local.ini /usr/local/etc/php/conf.d/local.ini

# Set working directory
WORKDIR /var/www/html/

EXPOSE 80

# Start php-fpm and nginx server
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/services-worker.conf","-n"]