## To add an agent to a remote server:

docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent

#### By default only the portainer instance that connects to that host first, will be allowed to connect to it

#### Port 9000 is used for the GUI, and port 8000 is used for comms

#### Now add these servers to your portainer web interface.
