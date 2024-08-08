#!/bin/bash

# Update and install dependencies
apt-get update
apt-get install -y nginx php-fpm php-mysql mysql-client

# Download and set up YOURLS
wget https://github.com/YOURLS/YOURLS/archive/master.zip
unzip master.zip
mv YOURLS-master /var/www/yourls
chown -R www-data:www-data /var/www/yourls

# Configure YOURLS
cp /var/www/yourls/user/config-sample.php /var/www/yourls/user/config.php
sed -i "s/your db user name/yourls_user/" /var/www/yourls/user/config.php
sed -i "s/your db password/yourls_password/" /var/www/yourls/user/config.php
sed -i "s/your db name/yourls_db/" /var/www/yourls/user/config.php

# Set up custom domain
sed -i "s/http:\/\/localhost/https:\/\/${YOURLS_DOMAIN}/" /var/www/yourls/user/config.php

# Install and configure plugins
git clone https://github.com/YOURLS/YOURLS-API.git /var/www/yourls/user/plugins/api
git clone https://github.com/YOURLS/YOURLS-Abuse-Desk.git /var/www/yourls/user/plugins/abuse-desk

# Configure rate limiting
echo "define( 'YOURLS_FLOOD_DELAY_SECONDS', 60 );" >> /var/www/yourls/user/config.php
echo "define( 'YOURLS_FLOOD_IP_WHITELIST', array( '127.0.0.1', 'your-trusted-ip' ) );" >> /var/www/yourls/user/config.php

# Set up Nginx
cat << EOF > /etc/nginx/sites-available/yourls
server {
    listen 80;
    server_name ${YOURLS_DOMAIN};
    root /var/www/yourls;
    index index.php;

    location / {
        try_files \$uri \$uri/ /yourls-loader.php\$is_args\$args;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
    }
}
EOF

ln -s /etc/nginx/sites-available/yourls /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

# Restart Nginx
systemctl restart nginx
