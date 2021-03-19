### First time setup
Go to host_ip:8080  
Select maria/mysql as your database  
In database host enter db:3306 (remember your second container in the compose file has the name db and it runs on port 3306 even though we did not expose a port to the host)  
Set your database name to nextcloud  
Set your database user to nextcloud  
Set your database password to the password in your env file  

### Backup NextCloud
docker cp NEXTCLOUD IMAGE:/var/www/html /tmp  
Then on the host: tar -zcvf file.tar.gz /tmp/html  
docker exec mysqldump --single-transaction -h localhost -u -p nextcloud > /tmp/nextcloudDB_1.sql  
