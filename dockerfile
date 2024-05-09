FROM php:8.1-fpm

 
RUN apt update -y \
    && apt install -y nginx

RUN apt-get update \
    && apt-get install -y libzip-dev zip \
    && docker-php-ext-install zip mysqli
    
RUN chmod -R 755 /var/www/html/ 
RUN chown -R www-data:www-data /var/www/html/ 

COPY . /var/www/html/

COPY ./nginx/default /etc/nginx/sites-enabled/default
COPY ./entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh

ENV MYSQL_HOST=localhost
ENV MYSQL_USER=root 
ENV MYSQL_PASSWORD=admin
ENV MYSQL_DB=osms_db

ENTRYPOINT ["/etc/entrypoint.sh"]
