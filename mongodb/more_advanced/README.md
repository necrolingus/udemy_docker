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

### Linking containers on the same network
You will not able to access mongodb_1 from another container because each container you start up lives inside its own network and we are not exposing mongodb_1 to the host to reduce our attack footprint. This also allows containers to referenece each other by name.

In order to link to containers (the containers don't have to be running, they can also be in a stopped state), do this:

docker network create myNetwork

docker network connect myNetwork container1

docker network connect myNetwork container2

docker network inspect myNetwork == check if the containers are on the same network
