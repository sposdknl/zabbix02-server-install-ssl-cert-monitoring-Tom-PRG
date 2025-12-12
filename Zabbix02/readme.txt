# Instalace Zabbix 7.0 s Vagrantem

**Autor:** Tom-PRG (veselyt)  
**Škola:** SPOŠDK.nl  
**Rok:** 2025

## Spuštění
```cmd
vagrant up
```

## Přístup
- **URL:** http://localhost:8080/zabbix
- **Login:** Admin
- **Heslo:** zabbix

## Konfigurace
- **OS:** Debian 13
- **RAM:** 2048 MB
- **CPU:** 2 jádra
- **Porty:** SSH 2206, HTTP 8080

## Ověření
```cmd
vagrant ssh
ps aux | grep zabbix
sudo systemctl status zabbix-server
sudo systemctl status zabbix-agent2
sudo apt-get install htop
htop
```

## Komponenty
- Apache2
- MariaDB
- Zabbix Server 7.0
- Zabbix Agent2
- Zabbix Frontend

## Screenshoty
- `Images/zabbix-web-gui.png` - Dashboard s "Tom-PRG Zabbix Server"
- `Images/processes.png` - ps aux | grep zabbix
- `Images/htop.png` - htop
- `Images/ssl-monitoring.png` - SSL monitoring sposdk.cz