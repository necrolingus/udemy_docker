In the docker-compose file we create several environment variables.
These environment variables will be read by docker-compose and are available to the init-mongo.sh script which mongo will run because we passed it through in the volumes section.

MONGO_INITDB_DATABASE in docker-compose will create this database (Mongo looks for the env variable at startup)
The sh script will create a user that has access to that database.

This is the proper, more secure method as your credentials will also not be stored in any nodeJS files. You can reference them with the envrionment variables.

Remember to rename env to .env when deploying and to create the mongodb-data folder as well
