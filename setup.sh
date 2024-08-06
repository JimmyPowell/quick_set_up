#!/bin/bash

# 更新系统包
sudo apt-get update
sudo apt-get upgrade -y

# 安装Nginx
sudo apt-get install -y nginx

# 安装MariaDB
sudo apt-get install -y mariadb-server

# 安装Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# 安装JDK 17
sudo apt-get install -y openjdk-17-jdk

# 安装Screen
sudo apt-get install -y screen

# 安装Htop
sudo apt-get install -y htop

# 启动并启用Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# 启动并启用MariaDB
sudo systemctl start mariadb
sudo systemctl enable mariadb

# 启动并启用Docker
sudo systemctl start docker
sudo systemctl enable docker

# 配置MariaDB
# 编辑MariaDB配置文件
sudo sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# 重启MariaDB服务以应用配置更改
sudo systemctl restart mariadb

# 提示用户输入MariaDB密码
read -sp "Enter MariaDB root password: " MARIADB_PASSWORD
echo

# 设置MariaDB root用户远程访问权限
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_PASSWORD';"
sudo mysql -e "CREATE USER 'root'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
sudo mysql -e "FLUSH PRIVILEGES;"

# 输出安装信息
echo "Nginx, MariaDB, Docker, JDK 17, Screen, and Htop have been installed and configured."
echo "MariaDB root user has been configured for remote access."

