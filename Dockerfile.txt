FROM php:8.1

# Sistem güncelleme ve gerekli kütüphaneler
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip pdo pdo_mysql

# Composer yükleme
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Proje dosyalarını kopyala
COPY . /var/www

WORKDIR /var/www

# Composer ile bağımlılıkları yükle
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Laravel için key oluştur
RUN php artisan key:generate

# Port (Render için gerekli)
EXPOSE 8000

# Laravel server başlat
CMD php artisan serve --host=0.0.0.0 --port=8000
