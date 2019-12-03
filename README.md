# Docker PHP Test Runner

A Docker image with PHPUnit, PHPCS, Composer, and various PHP extensions, including XDebug for use with code coverage.

This could be used for a CI platform such as Travis or Bitbucket Pipelines.

## PHPUnit

```bash
docker run -v $PWD/:/opt/test-runner elliotjreed/php-test-runner phpunit
```

## PHP Code Sniffer (PHPCS)

```bash
docker run -v $PWD/:/opt/test-runner elliotjreed/php-test-runner phpcs
```

## Composer

```bash
docker run -v $PWD/:/opt/test-runner elliotjreed/php-test-runner composer
```
