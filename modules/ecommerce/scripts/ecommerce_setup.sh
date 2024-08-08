#!/bin/bash

# Update and install dependencies
apt-get update
apt-get install -y nginx php-fpm php-mysql mysql-client unzip

# Install WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Install and configure WooCommerce
cd /var/www/wordpress
wp plugin install woocommerce --activate
wp plugin install woocommerce-admin --activate
wp plugin install woocommerce-gateway-stripe --activate
wp plugin install woocommerce-gateway-paypal-express-checkout --activate

# Configure WooCommerce settings
wp option update woocommerce_currency USD
wp option update woocommerce_currency_pos left
wp option update woocommerce_price_thousand_sep ,
wp option update woocommerce_price_decimal_sep .
wp option update woocommerce_price_num_decimals 2

# Enable multiple currencies (using a plugin like WPML)
wp plugin install woocommerce-multilingual --activate

# Set up payment gateways
wp option set woocommerce_stripe_settings --format=json '{"enabled":"yes","title":"Credit Card (Stripe)","description":"Pay with your credit card via Stripe.","testmode":"yes","test_publishable_key":"pk_test_your_key_here","test_secret_key":"sk_test_your_key_here"}'

wp option set woocommerce_paypal_settings --format=json '{"enabled":"yes","title":"PayPal","description":"Pay via PayPal; you can pay with your credit card if you don't have a PayPal account.","email":"your_paypal_email@example.com","testmode":"yes"}'

# Install and configure inventory management plugin
wp plugin install stock-manager --activate

# Configure tax rules
wp wc tax create --country=US --state=CA --rate=7.25 --name="California Tax" --shipping=true
wp wc tax create --country=US --state=NY --rate=8.875 --name="New York Tax" --shipping=true
wp wc tax create --country=GB --rate=20 --name="UK VAT" --shipping=true

# Set up cron job for inventory sync
echo "*/15 * * * * root wp wc product_variations update_stock --all" >> /etc/crontab

# Optimize WooCommerce performance
wp plugin install woocommerce-apcu-object-cache --activate
wp plugin install autoptimize --activate
