# rpi-mosquitto

Raspberry Pi compatible Docker Image with mosquitto MQTT broker. This version is configured with volumes to persist data and logs.

## Add user pi into docker group.

```
  sudo usermod -aG docker pi
```

## Prepare directories for use as volume

```
sudo mkdir -p /tmp/mosquitto_alpine/data /tmp/mosquitto_alpine/log /tmp/mosquitto_alpine/config
	
sudo chmod -R 777 /tmp/*
```

## Copy next content in /tmp/mosquitto_alpine/config/mosquitto.cond (create if not exists)

```
pid_file /var/run/mosquitto.pid

persistence true
persistence_location /mqtt/data

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
docker run -ti -p 1883:1883 -v /tmp/mosquitto_alpine/data/:/mqtt/data/:rw -v /tmp/mosquitto_alpine/log:/mqtt/log:rw -v /tmp/mosquitto_alpine/config/:/mqtt/config:ro  docker-mosquitto
```


