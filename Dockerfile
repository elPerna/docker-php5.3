FROM php:5.6-apache

RUN docker-php-ext-install mysqli

COPY ./php/ /var/www/html
COPY ./apache2.conf /etc/apache2/
COPY ./php.ini /usr/local/etc/php/

RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

RUN /usr/sbin/apachectl restart
