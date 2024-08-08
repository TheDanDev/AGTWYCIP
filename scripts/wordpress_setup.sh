#!/bin/bash

# Install necessary packages
apt-get update
apt-get install -y nginx php-fpm php-mysql mysql-client redis-tools

# Install WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Download and configure WordPress
wp core download --path=/var/www/html
wp config create --dbname=${db_name} --dbuser=${db_user} --dbpass=${db_password} --dbhost=${db_host} --path=/var/www/html

# Install and activate plugins
wp plugin install redis-cache --activate --path=/var/www/html
wp plugin install two-factor --activate --path=/var/www/html

# Configure object caching
wp config set WP_CACHE_KEY_SALT ${domain} --path=/var/www/html
wp config set WP_REDIS_HOST ${redis_host} --path=/var/www/html
wp redis enable --path=/var/www/html

# Configure security measures
wp config set DISALLOW_FILE_EDIT true --raw --path=/var/www/html
wp config set FORCE_SSL_ADMIN true --raw --path=/var/www/html

# Set up multisite if enabled
if [ "${multisite}" = "true" ]; then
  wp core multisite-convert --path=/var/www/html
fi

# Set up Nginx
cat << EOF > /etc/nginx/sites-available/wordpress
server {
    listen 80;
    server_name ${domain};
    root /var/www/html;
    index index.php;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
    }
}
EOF

ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

# Restart Nginx
systemctl restart nginx
