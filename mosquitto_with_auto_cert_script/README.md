# mosquitto-mqtt-docker-compose

### To get initial config file from the container because you need a config file to start mosquitto up
The below step is not necessary because I already have a config file we can mount, but in case you want the default config you can run the below  

sudo docker exec <container> cat /mosquitto/config/mosquitto.conf > /tmp/mosquitto.conf

### Password file
To set up the password file, bash into your container and run the below  
mosquitto_passwd -c /home/svennuc/dev_stuff/mosquitto/config/mosquitto.passwd USERNAME    
If you want to add more users, do not use the -c flag as it will recreate the passwd file.

### Generating the certs
chmod +x generate_certs.sh  
./generate_certs.sh

### Folder structures
config (in here we have mosquitto.conf and mosquitto.passwd, and the certs folder)


### There are issues with user permissiona and UID and GIDs and stuff.
To get the uid of the mosquitto user after you started up your docker-compose, run this command:  
ps aux | grep mosquitto  
OR, you can do this sudo docker exec <container> cat /etc/passwd

### Now lets test it
sudo apt install mosquitto-clients  
mosquitto_sub -h <brokerhost> -t "test" -u "<username>" -P "<password>"  
mosquitto_sub -h 192.168.88.110 -t "test" -u "test" -P "test"  
mosquitto_pub -h 192.168.88.110 -t "test" -u "test" -P "test" -m "hi there"


### Test your ca.crt using openssl
openssl s_client -connect 192.168.88.110:8883 -CAfile client_certs/ca.crt

### Connect using SSL
mosquitto_sub -h 192.168.88.110 -p 8883  --cafile certs_open/ca.crt  -t "test_topic" -u "test" -P "test" --tls-version tlsv1.2  
mosquitto_pub -h 192.168.88.110 -p 8883 --cafile certs_open/ca.crt -t "test_topic" -u "test" -P "test" --tls-version tlsv1.2 -m "hallo"  
Add --insecure to the above commands if you're having issues


### SONOFF Commands Tasmota
https://tasmota.github.io/docs/Commands/

#### Subscribe

$ mosquitto_sub -h 192.168.88.110 -t "stat/sonoff/dining-lamp/#" -u "xxx" -P "xxx"


#### Publish

$ mosquitto_pub -h 192.168.88.110 -t "cmnd/sonoff/dining-lamp/Latitude" -u "xxx" -P "xxx" -m "-26.204103"  
$ mosquitto_pub -h 192.168.88.110 -t "cmnd/sonoff/dining-lamp/Longitude" -u "xxx" -P "xxx" -m "28.047304"  
$ mosquitto_pub -h 192.168.88.110 -t "cmnd/sonoff/dining-lamp/Power" -u "xxx" -P "xxx" -m "1"  
$ mosquitto_pub -h 192.168.88.110 -t "cmnd/sonoff/dining-lamp/Power" -u "xxx" -P "xxx" -m "0"  
https://tasmota.github.io/docs/MQTT/

#### Tasmota uses 3 prefixes for forming a FullTopic:

cmnd - prefix to issue commands; ask for status  
stat - reports back status or configuration message  
tele - reports telemetry info at specified intervals  

#### More Examples
Will send back 2 lines:  
$ mosquitto_sub -h 192.168.88.110 -t "stat/sonoff/dining-lamp/#" -u "xxx" -P "xxx"  
{"POWER":"OFF"}  
OFF

##### Notice POWER below only sends 1 word. Perfect for MQTT Dash. In MQTT Dash commands are case sensitive
$ mosquitto_sub -h 192.168.88.110 -t "stat/sonoff/dining-lamp/POWER" -u "xxx" -P "xxx"  
OFF

