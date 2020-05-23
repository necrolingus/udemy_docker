# drupal-nginx-postgres-docker


1. Lets change our keyboard to US layout so that keys are where they should be
sudo nano /etc/default/keyboard

XKBMODEL="pc104"
XKBLAYOUT="us"
XKBVARIANT=""

PS If you dont want WiFi and BlueTooth do this: (from: https://blog.sleeplessbeastie.eu/2018/12/31/how-to-disable-onboard-wifi-and-bluetooth-on-raspberry-pi-3/)

Disable onboard WiFi on boot.
$ echo "dtoverlay=pi3-disable-wifi" | sudo tee -a /boot/config.txt

Disable Bluetooth boot.
$ echo "dtoverlay=pi3-disable-bt" | sudo tee -a /boot/config.txt

Disable systemd service that initializez Bluetooth Modems connected by UART.
$ sudo systemctl disable hciuart

Reboot Raspberry Pi device.
$ sudo reboot


2. Lets connect to a WIFI network 
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf

add this to the end of the file
network={
    ssid="the essid"
    psk="Your_wifi_password"
}


3. Follow this post to install docker on your pi.
https://www.codeastar.com/install-docker-raspberry-pi/ (follow step 1 to 5 and do the hellw-world test)

To test if your docker is working run the below:
sudo docker run hello-world (if you get some weird permission error, then login first like the below)

docker login --username YOUR_USERNAME --password YOUR_PASSWORD


4. To run docker without sudo, do this:
--First read this! Because apparently the docker group has like root privileges, so yeah, rather use sudo maybe
--https://docs.docker.com/install/linux/linux-postinstall/
sudo usermod -aG docker pi
sudo deluser username group -- to remove the user if you change your mind


5. Stop and start docker serice
sudo systemctl stop docker.service
sudo systemctl start docker.service
systemctl |grep running (to see all running services. docker.service should be in there)

6. lets install docker compose
sudo apt-get install python python-pip
pip install --upgrade pip 
sudo pip install docker-compose==1.23.2 (not specifying a version gives errors)


to enable ssh on raspberry pi just run "sudo raspi-config"