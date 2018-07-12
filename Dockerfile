FROM php:alpine

COPY ./composer.phar /usr/local/bin/composer
COPY ./phpunit.phar /usr/local/bin/phpunit
COPY ./phpcs.phar /usr/local/bin/phpcs

RUN apk --update upgrade && \
    apk add autoconf sqlite-dev dpkg-dev icu-dev libxml2-dev libtool dpkg file g++ gcc libc-dev make pkgconf re2c curl-dev git zlib-dev bzip2-dev openssh-client && \
    pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    docker-php-ext-install bcmath bz2 curl dom iconv intl json mbstring mysqli pdo pdo_mysql pdo_sqlite xml zip && \
    apk del sqlite-dev dpkg-devfile libc-dev re2c curl-dev zlib-dev && \
   chmod +x /usr/local/bin/composer && \
    chmod +x /usr/local/bin/phpunit && \
    chmod +x /usr/local/bin/phpcs && \
    rm -rf /var/cache/apk && \
    mkdir -p /var/cache/apk

