##### Remember you .env file like we always created.

##### Certbot will automatically generate the SSL configs for the webserver you want to use

### Lets install Apache and Nginx certbot packages. We wont use Apache, but now you know how to install them
sudo apt-get install python-certbot-nginx

sudo apt-get install python-certbot-apache

### Lets generate a wildcard certificate because then you can secure test.YOUR_DOMAIN.net and api.YOUR_DOMAIN.net etc

There are very good tutorials out there that shows how to automate literally everything, even the certbot portion. Here is one such tutorial: https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose#step-1-%E2%80%94-defining-the-web-server-configuration

##### But lets do certbot manually so we can learn what it does.
certbot certonly --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory --manual-public-ip-logging-ok -d '*.YOUR_DOMAIN.net' -d YOUR_DOMAIN.net

Letsencrypt will ask you to add a TXT record. Add it then press Enter to continue. It will then ask you to add another one. Add it but now wait. Dont press Enter. Those records must propagate. If you press Enter and they have not propagated yet, you will need to restart the process.

### Regenerate certs and config file
Sometimes you want to regenerate your certs and sometimes you want to use a different web server maybe. This command will allow you to do both.

certbot certonly -a nginx -d YOUR_DOMAIN.net

You can replace -a with e.g. Apache if you want to

### Now look in /etc/letsencrypt/
There you will find the conf file and also the following:

/etc/letsencrypt/live/YOUR_DOMAIN.net/ which contains the certificate and private key files.


### Cloudflare
As a side note, if you're using cloudflare and your site goes into an infinite redirect loop, set your SSL to Full (Strict) otherwise Cloudflare will make a connection over port 80 which we don't want because we don't want to listen or serve over port 80, only 443.
