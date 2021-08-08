FROM php:8.0.3-fpm-buster

WORKDIR /var/www

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=UTC

RUN docker-php-ext-install bcmath pdo_mysql

RUN apt-get update

RUN apt-get install -y git zip unzip nano supervisor sqlite3

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY ./docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY ./docker/start_app /usr/bin/local/start_app

RUN chmod +x /usr/bin/local/start_app

EXPOSE 9000

ENTRYPOINT ["/usr/bin/local/start_app"]


