FROM php:7.4-fpm

# Define arguments
ARG user
ARG uid

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    wget \
    sudo \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxpm-dev \
    libfreetype6-dev \
    libzip-dev \
    libc-client-dev \
    libkrb5-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure PHP
RUN docker-php-ext-configure gd \
    --with-webp=/usr/include/ \
    --with-jpeg=/usr/include/ \
    --with-xpm=/usr/include/ \
    --with-freetype=/usr/include/

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip \
    intl \
    zip

# Fetch composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set up user
RUN adduser --disabled-password --gecos '' app
RUN adduser app sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Change default workdir
WORKDIR /var/www

# Change to non-root user
USER $user