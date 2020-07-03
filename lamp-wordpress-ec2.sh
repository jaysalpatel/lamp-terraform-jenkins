#! /bin/bash

##userdata/shell script to  LAMP stack with apache/mysql/php/wordpress

#run as sudo su

echo "this is a shell script to install apache/mysql/php/wordpress on an ec2 instance"
echo "make you run as root with command sudo su"
echo "run script? (y/n)"

read -e run
if ["$run" == n ] ; then
echo "you should run this"
exit else

##install 'expect' to input input/y/n/passwords
yum -y install expect

#install apache
yum -y install httpd

##start apache
service httpd start

#install PHP
yum -y install php php-mysql

##restart httpd/apache
service httpd restart

#install MYSQL
yum -y install mysql-server

#start mysql
service mysqld start

#create a database named blog
mysqladmin -uroot create blog

#secure database

SECURE_MYSQL=$(expect -c "

set timeout 10
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
sned \"\r\"

expect \"Change the root password?\"
send \"y\r\"

expect \"New password:\"
send \"password\r\"

expect \"Re-enter new password:\"
send \"password\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilage tables now?\"
send \"y\r\"

expect eof
")

echo "$SECURE_MYSQL"

# change directory to web root
cd var/www/html

#download wordpress
wget http://wordpress.org/latest.tar.gz

#extract wordpress
tar -xzvf latest.tar.gz

# rename wordpress directory to blog
mv wordpress blog

#change directory to blog
cd /var/www/html/blog/

#create a wordpress config file
mv wp-config-sample.php wp-config.php

#set database details with perl find and replace
sed -i "s/wordpress-blog/g" /var/www/html/blog/wp-config.php
sed -i "s/username_here/root/g" /var/www/html/blog/wp-config.php
sed -i "s/password_here/password/g" /var/www/html/blog/wp-config.php

#create uploads folder and set permissions
mkdir wp-content/uploads
chmod 777 wp-content/uploads

#remove wp file
rm /var/www/html/latest.tar.gz

echo "Ready, go to http://'your ec2 url'/blog and enter the blog info to finish the installation."

fi