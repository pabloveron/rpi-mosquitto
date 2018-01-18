# Pull base image
FROM resin/raspberry-pi-alpine-python
MAINTAINER Pablo Veron <pveron2001@gmail.com>
# Enable OpenRC
ENV INITSYSTEM on

# Install packages
RUN apk --no-cache add mosquitto mosquitto-clients

#RUN adduser --system --disabled-password --disabled-login mosquitto
RUN mkdir -p /mqtt/config /mqtt/data /mqtt/log

COPY config /mqtt/config
VOLUME ["/mqtt/config", "/mqtt/data", "/mqtt/log"]

#RUN chown -R mosquitto:mosquitto /mqtt
#RUN export uid=1000 gid=4
#RUN chown -R ${uid}:${gid} -R /mqtt

# Expose MQTT ports
#EXPOSE 1883 9001

#CMD /usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf

#ENV PATH /usr/sbin:$PATH

ENTRYPOINT ["/usr/sbin/mosquitto", "-c", "/mqtt/config/mosquitto.conf"]
#ENTRYPOINT ["/usr/sbin/mosquitto"]
