#!/bin/sh

sudo apt update
sudo apt install apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip

sudo mkdir -p /srv/www
sudo chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www

sudo cat <<EOF /etc/apache2/sites-available/wordpress.conf
DocumentRoot /srv/www/wordpress
<Directory /srv/www/wordpress>
    Options FollowSymLinks
    AllowOverride Limit Options FileInfo
    DirectoryIndex index.php
    Require all granted
</Directory>
<Directory /srv/www/wordpress/wp-content>
    Options FollowSymLinks
    Require all granted
</Directory>
EOF

sudo a2ensite wordpress
sudo a2enmod rewrite
sudo service apache2 reload

# sudo mysql -u root
# CREATE DATABASE wordpress;
# CREATE USER wordpress@localhost IDENTIFIED BY '567097';
# GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO wordpress@localhost;
# FLUSH PRIVILEGES;
# quit

sudo systemctl enable mysql
sudo service mysql start

sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php

sudo -u www-data sed -i 's/database_name_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/username_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/password_here/567097/' /srv/www/wordpress/wp-config.php

# sudo -u www-data nano /srv/www/wordpress/wp-config.php
# delete the lines: 
# define( 'AUTH_KEY',         'put your unique phrase here' );
# define( 'SECURE_AUTH_KEY',  'put your unique phrase here' );
# define( 'LOGGED_IN_KEY',    'put your unique phrase here' );
# define( 'NONCE_KEY',        'put your unique phrase here' );
# define( 'AUTH_SALT',        'put your unique phrase here' );
# define( 'SECURE_AUTH_SALT', 'put your unique phrase here' );
# define( 'LOGGED_IN_SALT',   'put your unique phrase here' );
# define( 'NONCE_SALT',       'put your unique phrase here' );

