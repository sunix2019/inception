#!/bin/sh

if [ ! -e "/var/www/html/wp-config.php" ]; then
    wp core config --dbhost=${DB_HOST} --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASSWORD} --allow-root
    wp core install --url=${DOMAIN_NAME} --title=${TITLE} --admin_user=${ADMIN_USER} --admin_password=${DB_ROOT_PASSWORD} --admin_email=${ADMIN_EMAIL} --skip-email --allow-root
    wp user create ${DB_USER} ${USER_EMAIL} --allow-root --role=editor --user_pass=${DB_PASSWORD}
fi

exec /usr/sbin/php-fpm7.3 --nodaemonize
