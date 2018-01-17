# Pull base image
FROM resin/raspberry-pi-alpine-python
MAINTAINER Pablo Veron <pveron2001@gmail.com>

RUN sudo apt-get install mosquitto mosquitto-clients -y

#RUN adduser --system --disabled-password --disabled-login mosquitto

#COPY config /mqtt/config
#VOLUME ["/mqtt/config", "/mqtt/data", "/mqtt/log"]

EXPOSE 1883 9001
CMD /usr/sbin/mosquitto -c /mqtt/config1/mosquitto.conf
