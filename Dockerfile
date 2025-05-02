
FROM php:8.2-fpm

RUN apt-get update && apt-get install -y     build-essential     libpng-dev     libjpeg-dev     libfreetype6-dev     locales     zip     jpegoptim optipng pngquant gifsicle     vim     unzip     git     curl     libonig-dev     libxml2-dev     libzip-dev     && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

WORKDIR /var/www

COPY . .

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install --no-interaction --prefer-dist --optimize-autoloader

RUN php artisan key:generate || true

CMD ["php-fpm"]
