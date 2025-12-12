#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

echo "=== Aktualizace ==="
apt-get update && apt-get upgrade -y

echo "=== Instalace Apache, PHP, MariaDB ==="
apt-get install -y wget apache2 php php-mysql php-gd php-bcmath php-xml php-mbstring mariadb-server

echo "=== Databáze ==="
mysql <<EOF
CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix123';
GRANT ALL ON zabbix.* TO 'zabbix'@'localhost';
SET GLOBAL log_bin_trust_function_creators = 1;
FLUSH PRIVILEGES;
EOF

echo "=== Zabbix repozitář ==="
wget -q https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.0+debian13_all.deb
dpkg -i zabbix-release_latest_7.0+debian13_all.deb
apt-get update

echo "=== Instalace Zabbix ==="
apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent2

echo "=== Import databáze ==="
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql -uzabbix -pzabbix123 zabbix
mysql -e "SET GLOBAL log_bin_trust_function_creators = 0;"

echo "=== Konfigurace ==="
sed -i 's/# DBPassword=/DBPassword=zabbix123/' /etc/zabbix/zabbix_server.conf
cat > /etc/zabbix/zabbix_agent2.conf <<'EOF'
Server=127.0.0.1
ServerActive=127.0.0.1
Hostname=debian-zabbix
EOF

cat > /etc/zabbix/web/zabbix.conf.p