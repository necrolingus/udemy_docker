#!/bin/bash
# thanks to https://medium.com/himinds/mqtt-broker-with-secure-tls-and-docker-compose-708a6f483c92

IP="192.168.88.110"
SUBJECT_CA="/C=ZA/ST=Johannesburg/L=Johannesburg/O=mosquitto/OU=CA/CN=$IP"
SUBJECT_SERVER="/C=ZA/ST=Johannesburg/L=Johannesburg/O=mosquitto/OU=Server/CN=$IP"
SUBJECT_CLIENT="/C=ZA/ST=Johannesburg/L=Johannesburg/O=mosquitto/OU=Client/CN=$IP"

function generate_CA () {
   echo "$SUBJECT_CA"
   openssl req -x509 -nodes -sha256 -newkey rsa:2048 -subj "$SUBJECT_CA"  -days 365 -keyout ca.key -out ca.crt
}

function generate_server () {
   echo "$SUBJECT_SERVER"
   openssl req -nodes -sha256 -new -subj "$SUBJECT_SERVER" -keyout server.key -out server.csr
   openssl x509 -req -sha256 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 365
}

function generate_client () {
   echo "$SUBJECT_CLIENT"
   openssl req -new -nodes -sha256 -subj "$SUBJECT_CLIENT" -out client.csr -keyout client.key 
   openssl x509 -req -sha256 -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 365
}

function copy_keys_to_broker () {
   mv ca.crt config/certs
   mv server.crt config/certs
   mv server.key config/certs
   rm client.*
   rm server.*
   rm ca.*
}

generate_CA
generate_server
generate_client
copy_keys_to_broker
