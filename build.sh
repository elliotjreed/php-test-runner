#!/bin/sh

EXPECTED_SIGNATURE=$(curl -s https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
	>&2 echo 'ERROR: Invalid Composer installer signature'
	rm ./composer-setup.php
	exit 1
fi

php ./composer-setup.php --quiet
rm ./composer-setup.php

curl -o ./phpcs.phar -L https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
curl -o ./phpunit-7.2.phar -L https://phar.phpunit.de/phpunit-7.2.phar
curl -o ./phpunit-6.5.phar -L https://phar.phpunit.de/phpunit-6.5.phar

chmod 777 ./composer.phar
chmod 777 ./phpcs.phar
chmod 777 ./phpunit-7.2.phar
chmod 777 ./phpunit-6.5.phar

docker build -f ./php-72/Dockerfile -t elliotjreed/php-test-runner:php-7.2 -t elliotjreed/php-test-runner:latest .
docker build -f ./php-71/Dockerfile -t elliotjreed/php-test-runner:php-7.1 .
docker build -f ./php-70/Dockerfile -t elliotjreed/php-test-runner:php-7.0 .

docker push elliotjreed/php-test-runner:latest
docker push elliotjreed/php-test-runner:php-7.2
docker push elliotjreed/php-test-runner:php-7.1
docker push elliotjreed/php-test-runner:php-7.0

rm ./composer.phar ./phpcs.phar ./phpunit-7.2.phar ./phpunit-6.5.phar
