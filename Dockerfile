FROM php:7.2-alpine

LABEL Description="" Vendor="Elliot J. Reed" Version="1.0"

WORKDIR /app
VOLUME ["/app"]

ENV PATH="/root/.composer/vendor/bin:${PATH}"

RUN apk add --update icu yaml git openssh-client freetype libpng libjpeg-turbo && \
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        zlib-dev \
        bzip2-dev \
        libzip-dev \
        sqlite-dev \
        icu-dev \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        yaml-dev && \
    docker-php-ext-install bcmath pdo_mysql opcache pdo_sqlite zip gd && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl && \
    docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install sockets && \
    pecl install yaml && \
    docker-php-ext-enable yaml && \
    pecl install apcu && \
    docker-php-ext-enable apcu && \
    pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    apk del .build-deps && \
    { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } && \
    rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/* && \
    mkdir -p /app && \
    chmod -R 777 /app && \
    composer global require --no-suggest --no-progress --classmap-authoritative --optimize-autoloader \
        phpunit/phpunit \
        codeception/codeception \
        behat/behat \
        phpmd/phpmd \
        phpstan/phpstan \
        squizlabs/php_codesniffer && \
    cd /root/.composer/vendor && \
    find . -type f \( -iname "*readme*" ! -iname "*.php" \) -exec rm -vf {} + && \
    find . -type f \( -iname "*changelog*" ! -iname "*.php" \) -exec rm -vf {} + && \
    find . -type f \( -iname "*license*" ! -iname "*.php" \) -exec rm -vf {} +

CMD ["php"]

