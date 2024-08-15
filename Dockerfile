FROM php:8.0-apache

# Instalar extensiones y dependencias de PHP 5.3
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    nano \
    systemd \
    dbus \
    libpng-dev \
    libcurl4-openssl-dev \
    && docker-php-ext-install zip

COPY ./apache-conf/000-default.conf /etc/apache2/sites-available/

# Cambia los permisos del directorio de tu aplicación
RUN chown -R www-data:www-data /var/www/html

# Habilitar mod_rewrite para Apache
RUN a2enmod rewrite

# Darle Permisos a la carpeta html para que copie los archivos del la aplicacion
RUN chmod -R 755 /var/www/html

# Copiar el código de la aplicación al contenedor
COPY . /var/www/html

# Exponer el puerto 80
EXPOSE 8080

# Comando para iniciar Apache
CMD ["apache2-foreground"]

# Reinicia Apache
# RUN service apache2 restart
