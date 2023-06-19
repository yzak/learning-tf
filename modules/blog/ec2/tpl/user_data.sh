#!/bin/bash
yum update -y

#EFSマウント設定
yum install -y amazon-efs-utils
efs_id="${efs_id}"
echo "$efs_id:/ /var/www/html efs defaults,_netdev 0 0" >> /etc/fstab

amazon-linux-extras install php7.2 -y
yum -y install mysql httpd php-mbstring php-xml gd php-gd

#/etc/fstabに記載がある全てのデバイスをマウント
mount -a

#WordPress初期化
#WordPress関連のフォルダが存在しなければ配置
if [ ! -e /var/www/html/wp-admin ]; then   
  cd /tmp
  wget https://ja.wordpress.org/latest-ja.tar.gz
  tar xzvf /tmp/latest-ja.tar.gz --strip 1 -C /var/www/html
  rm /tmp/latest-ja.tar.gz
fi
if [ ! -e /var/www/html/wp-config.php ]; then   
  cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
  sed -i "s/database_name_here/wordpress/" /var/www/html/wp-config.php
  sed -i "s/username_here/wordpress/" /var/www/html/wp-config.php
  sed -i "s/password_here/wordpress/" /var/www/html/wp-config.php
  sed -i "s/localhost/${db_host}/" /var/www/html/wp-config.php
  sed -i "s/define( 'WP_DEBUG', false );/define( 'WP_DEBUG', false );\$_SERVER['HTTPS'] = 'on';\$_SERVER['HTTP_HOST'] = 'yasuo1979.com';/" /var/www/html/wp-config.php
fi

#ファイルやディレクトリのユーザやグループを変更
chown -R apache:apache /var/www/html

#Apache自動起動を有効化
systemctl enable httpd

#Apache起動
systemctl start httpd