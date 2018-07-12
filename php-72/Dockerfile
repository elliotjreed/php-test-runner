FROM php:7.2-alpine

LABEL Description="Image containing the latest PHPUnit, PHP Code Sniffer, and Composer on PHP 7.2." Vendor="Elliot Reed" Version="1.0"

WORKDIR /opt/test-runner
VOLUME ["/opt/test-runner"]

COPY ./composer.phar /usr/local/bin/composer
COPY ./phpunit-7.2.phar /usr/local/bin/phpunit
COPY ./phpcs.phar /usr/local/bin/phpcs

RUN chmod +x /usr/local/bin/composer && \
    chmod +x /usr/local/bin/phpunit && \
    chmod +x /usr/local/bin/phpcs && \
    mkdir -p /opt/test-runner && \
    apk --update upgrade && \
    apk add autoconf sqlite-dev dpkg-dev icu-dev libxml2-dev libtool dpkg file g++ gcc libc-dev make pkgconf re2c curl-dev git zlib-dev bzip2-dev openssh-client && \
    pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    docker-php-ext-install bcmath bz2 curl dom iconv intl json mbstring mysqli pdo pdo_mysql pdo_sqlite xml zip && \
    apk del dpkg-dev dpkg g++ gcc libc-dev make pkgconf autoconf && \
    rm -rf /var/cache/apk && \
    mkdir -p /var/cache/apk
