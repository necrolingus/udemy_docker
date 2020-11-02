## Update on renewing certificates
##### You can run "certbot renew" and it will renew all certificates that expire in less than 30 days. But, if you want to use the DNS method or another method, you can still issue this command: certbot certonly --manual --preferred-challenges dns -d 'DOMAIN.net,*.DOMAIN.net'
##### Running "certbot certificates" will show which certificates are being managed and their expiration dates

##### To learn more about certbot, you can go here: https://certbot.eff.org/
##### Certbot online Manual: https://certbot.eff.org/docs/using.html?highlight=manual

### Lets install Apache and Nginx certbot packages. We wont use Apache, but now you know how to install them
sudo apt-get install certbot

#### Install the relevant plugins for certbot

sudo apt-get install python-certbot-nginx

sudo apt-get install python-certbot-apache

### Lets generate a wildcard certificate because then you can secure test.YOUR_DOMAIN.net and api.YOUR_DOMAIN.net etc

There are very good tutorials out there that shows how to automate literally everything, even the certbot portion. Here is one such tutorial: https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose#step-1-%E2%80%94-defining-the-web-server-configuration

##### But lets do certbot manually so we can learn what it does.
certbot certonly --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory --manual-public-ip-logging-ok -d '*.YOUR_DOMAIN.net' -d YOUR_DOMAIN.net

--staging: If you want to play around first, add the --staging flag to the above command so that you don't reach any potential request limits.

--manual: If you’d like to obtain a certificate running certbot on a machine other than your target webserver or perform the steps for domain validation yourself, you can use the manual plugin

--server: By default, Certbot uses Let’s Encrypt’s production server at https://acme-v02.api.letsencrypt.org/. You can tell Certbot to use a different CA by providing --server

--manual-public-ip-logging-ok: Automatically allows public IP logging (default: Ask)

--preferred-challenges: Use this option with the Manual flag to choose the challenge of your preference (http/dns). We used DNS


Letsencrypt will ask you to add a TXT record. Add it then press Enter to continue. It will then ask you to add another one. Add it but now wait. Dont press Enter. Those records must propagate. If you press Enter and they have not propagated yet, you will need to restart the process.


### Now look in /etc/letsencrypt/
There you will find the config file and also the following:

/etc/letsencrypt/live/YOUR_DOMAIN.net/ which contains the certificate and private key files.

##### Certbot will automatically generate the SSL configs for the webserver you want to use. By default it should generate apache, but what if you want an Nginx config file? We can do that using the below command


### Regenerate certs and generate a new config file
If you do get an nginx error, make sure nginx is installed on your host as certbot needs it to generate the config file. You can install it using "sudo apt-get nginx"

If port 80 (the default port nginx uses) is already in use, do "sudo nano /etc/nginx/sites-enabled/default" and change port 80 to e.g. 40001 (there will be 2 lines right at the top where you should change it)

##### Then run this command: 
sudo certbot certonly -a nginx -d YOUR_DOMAIN.net

##### And then if you want to stop and disable nginx on the host, you can run the following commands:

sudo service nginx stop

sudo update-rc.d -f nginx disable

##### You can replace -a with e.g. Apache if you want to

### Cloudflare
As a side note, if you're using cloudflare and your site goes into an infinite redirect loop, set your SSL to Full (Strict) otherwise Cloudflare will make a connection over port 80 which we don't want because we don't want to listen or serve over port 80, only 443.
