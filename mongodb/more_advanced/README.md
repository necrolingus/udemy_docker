In the docker-compose file we create several environment variables.
These environment variables will be read by docker-compose and are available to the init-mongo.sh script which mongo will run because we passed it through in the volumes section.

MONGO_INITDB_DATABASE in docker-compose will create this database (Mongo looks for the env variable at startup)
The sh script will create a user that has access to that database.

This is the proper, more secure method as your credentials will also not be stored in any nodeJS files. You can reference them with the envrionment variables.

Remember to rename env to .env when deploying and to create the mongodb-data folder as well

### Take Note
This container is not exposed to the host. You can only connect to it from other containers or using the command below. This ensures it is not exposed on the internet

docker exec -it mongodb_1 mongo --username NOT_ROOT_USER --password NOT_ROOT_PASS --authenticationDatabase expenses --host mongodb_1 --port 27017

mongodb_1 is my mongodb service name in the docker-compose file
