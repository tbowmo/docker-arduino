FROM alpine:latest
MAINTAINER Thomas Mørch

RUN apk update \
    && apk add ca-certificates \
    && update-ca-certificates \
    && apk add openssl \
    && apk add libxext \
    && apk add libxrender \
    && apk add libxtst \
    && apk add libxi \
    && apk add openjdk8-jre
     
ENV ARDUINO_IDE_VERSION 1.8.5
ENV ARDUINO_SAMD_VERSION 1.6.17
ENV MYSENSORS_SAMD_VERSION 1.0.5

RUN (echo ${ARDUINO_IDE_VERSION} && wget -q -O- https://downloads.arduino.cc/arduino-${ARDUINO_IDE_VERSION}-linux64.tar.xz \
	| tar xJC / \
	&& ln -s /arduino-${ARDUINO_IDE_VERSION} /arduino \
	&& ln -s /arduino-${ARDUINO_IDE_VERSION}/arduino /usr/local/bin/arduino)

VOLUME /root/.arduino15
VOLUME /root/Arduino

COPY ./start.sh /start.sh

CMD ["/bin/bash"]

ENTRYPOINT ["/start.sh"]
