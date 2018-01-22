# Pull base image
FROM resin/raspberry-pi-alpine-python
MAINTAINER Pablo Veron <pveron2001@gmail.com>
# Enable OpenRC
ENV INITSYSTEM on

# Install packages
RUN apk --no-cache add mosquitto mosquitto-clients

RUN mkdir -p /mqtt/config /mqtt/data /mqtt/log

COPY config/* /mqtt/config/
VOLUME ["/mqtt/config", "/mqtt/data", "/mqtt/log"]

ENTRYPOINT ["/usr/sbin/mosquitto", "-c", "/mqtt/config/mosquitto.conf"]
