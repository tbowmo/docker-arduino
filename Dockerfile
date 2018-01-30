FROM anapsix/alpine-java:8_server-jre_unlimited
MAINTAINER Stephen Olesen <slepp@slepp.ca>

#RUN apt-get update \
#	&& apt-get install -y \
#		wget \
#		openjdk-8-jre \
#		xz-utils \
#	&& apt-get clean \
#	&& rm -rf /var/lib/apt/lists/*

RUN apk update \
    && apk add ca-certificates \
    && update-ca-certificates \
    && apk add openssl \
    && apk add libxext \
    && apk add libxrender \
    && apk add libxtst \
    && apk add libxi   
     
ENV ARDUINO_IDE_VERSION 1.8.5
ENV ARDUINO_SAMD_VERSION 1.6.17
ENV MYSENSORS_SAMD_VERSION 1.0.5

RUN (echo ${ARDUINO_IDE_VERSION} && wget -q -O- https://downloads.arduino.cc/arduino-${ARDUINO_IDE_VERSION}-linux64.tar.xz \
	| tar xJC / \
	&& ln -s /arduino-${ARDUINO_IDE_VERSION} /arduino \
	&& ln -s /arduino-${ARDUINO_IDE_VERSION}/arduino /usr/local/bin/arduino)

#RUN arduino --install-boards "arduino:samd:${ARDUINO_SAMD_VERSION}"
#RUN (arduino --install-boards "MySensors:samd:${MYSENSORS_SAMD_VERSION}" --pref boardsmanager.additional.urls=https://raw.githubusercontent.com/mysensors/ArduinoBoards/master/package_mysensors.org_index.json \
#   && arduino --install-library "MySensors")

VOLUME /root/.arduino15
VOLUME /root/Arduino

COPY ./start.sh /start.sh

CMD ["/bin/bash"]

ENTRYPOINT ["/start.sh"]
