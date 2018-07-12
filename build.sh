#!/bin/sh

EXPECTED_SIGNATURE=$(curl -s https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
	>&2 echo 'ERROR: Invalid Composer installer signature'
	rm composer-setup.php
	exit 1
fi

php composer-setup.php --quiet
rm composer-setup.php

curl -o ./phpcs.phar -L https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
curl -o ./phpunit.phar -L https://phar.phpunit.de/phpunit-7.2.phar

chmod 777 ./composer.phar
chmod 777 ./phpcs.phar
chmod 777 ./phpunit.phar

docker build -t elliotjreed/php-test-runner:latest
docker push elliotjreed/php-test-runner

