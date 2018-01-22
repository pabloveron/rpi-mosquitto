# rpi-mosquitto

```
Raspberry Pi compatible Docker Image with mosquitto MQTT broker. This version is configured with
volumes to persist data and logs.
```

## Add user pi into docker group.

```
  sudo usermod -aG docker pi
```

## Prepare directories for use as volume

```
sudo mkdir -p /tmp/mosquitto_alpine/data /tmp/mosquitto_alpine/log /tmp/mosquitto_alpine/config
	
sudo chmod -R 777 /tmp/*
```

## Copy next content in /tmp/mosquitto_alpine/config/mosquitto.conf (create if not exists)

```
pid_file /var/run/mosquitto.pid

persistence true
persistence_location /mqtt/data/

user mosquitto

port 1883

log_dest file /mqtt/log/mosquitto.log
```  

## Clone git repo in your user directory
```
git clone https://github.com/pabloveron/rpi-mosquitto.git
```

## GO TO RPI-MOSQUITTO
```
cd rpi-mosquitto
```

## Build Container
```
docker build -t docker-mosquitto . --no-cache
```

## Run

```
docker run -ti -p 1883:1883 
-v /tmp/mosquitto_alpine/data/:/mqtt/data:rw
-v /tmp/mosquitto_alpine/log/:/mqtt/log:rw 
-v /tmp/mosquitto_alpine/config/:/mqtt/config:ro  docker-mosquitto
```

## (How to run using network bridge)
```
create the bridge network interface
docker network create --driver=bridge --subnet=162.0.0.0/24 --gateway=162.0.0.1 mqttbridge

start container assigning ip address and bridge network interface
docker run --ip=162.0.0.10 --net=mqttbridge -ti -p 1883:1883 -v /tmp/mosquitto_alpine/data/:/mqtt/data:rw -v /tmp/mosquitto_alpine/log/:/mqtt/log:rw -v /tmp/mosquitto_alpine/config/:/mqtt/config:ro  docker-mosquitto

subscribe to moquito using bridge network interface
docker run --net=mqttbridge mqtt-subscriber

send messages using bridge network interface
docker run --net=mqttbridge -t mqtt-publisher message_1
```

## NOTE:

```
When try to run the related projects MQTT-Publish and MQTT-Subscribe need to check
if the python files match with the ip address of the docker-mosquitto container.
In order to check that you can use the combination of "docker ps" and 
"docker inspect <container ID>". Update the publish.py and subscribe.py if needed.

