### take note: the below process is similar to https://github.com/necrolingus/passwordpusher_nginx_auto_certbot

# nginxwordpressmysqlautocertbot
Auto renew letsencrypt certs and using nginx as a reverse proxy 

### All credit goes to:
https://pentacent.medium.com/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71  
https://github.com/wmnnd  
https://github.com/pglombardo/PasswordPusher  


### Below I will sum up what they said
1. I want this website to run on ppusher.leighonline.net, so I set up the A record on Cloudflare to point to my server IP address so long. Dont enable the cloud icon for now.  
2. In data/nginx/app.conf replace ppusher.leighonline.net with your own domain name. You will find initial.conf in the data/nginx/ folder that must be used when you initially get a cert otherwise it might fail.  
3. Do not replace the proxy_pass domain name. If you want to, make sure it is a working domain name otherwise the domain validaion will fail. Once we have our initial cert, we can change it to whatever it needs to be.  
4. In the init-letsenrcypt.sh remember to add your email address otherwise verfication might also fail.  
5. Now chmod +x init.letsencrypt.sh and then ./init-letsencrypt.sh  
6. This cool file that wmnd created will create a dummy SSL cert (otherwise nginx cannot start up because we told it to use SSL but we dont have certs yet) and then it will also start up your docker-compose. Very nice.  
7. Remember to enable your cloudflare cloud icon now.  

### Take note
The bash command under certbot is so that certbot will check every 12 hours if the cert is up for renewal.  
The bash command under nginx is so that nginx will reload its config every 6 hours in case a cert did get renewed.  

### nginx config file notes
include /etc/letsencrypt/options-ssl-nginx.conf;  The bash file grabs best practice for nginx that is why we load it  
ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;  Good practice for Diffie Helman key exchange. Read more here if you want to https://security.stackexchange.com/questions/94390/whats-the-purpose-of-dh-parameters


## How to run this?
The very first time, run ./init-letsencrypt.sh so that it can create the dummy cert and request your actual cert.  
Remember to use the initial.conf nginx config file.  
After this, you can use normal docker-compose to up and down your stack and you can use your actual nginx app.conf file.
