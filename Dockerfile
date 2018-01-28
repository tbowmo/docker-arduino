FROM ubuntu:16.04
MAINTAINER Stephen Olesen <slepp@slepp.ca>

RUN apt-get update \
	&& apt-get install -y \
		wget \
		openjdk-9-jre \
		xvfb \
		xz-utils \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ENV ARDUINO_IDE_VERSION 1.8.5
ENV ARDUINO_SAMD_VERSION 1.6.17
ENV MYSENSORS_SAMD_VERSION 1.0.5

RUN (echo ${ARDUINO_IDE_VERSION} && wget -q -O- https://downloads.arduino.cc/arduino-${ARDUINO_IDE_VERSION}-linux64.tar.xz \
	| tar xJC /usr/local/share \
	&& ln -s /usr/local/share/arduino-${ARDUINO_IDE_VERSION} /usr/local/share/arduino \
	&& ln -s /usr/local/share/arduino-${ARDUINO_IDE_VERSION}/arduino /usr/local/bin/arduino)

RUN arduino --install-boards "arduino:samd:${ARDUINO_SAMD_VERSION}"
RUN (arduino --install-boards "MySensors:samd:${MYSENSORS_SAMD_VERSION}" --pref boardsmanager.additional.urls=https://raw.githubusercontent.com/mysensors/ArduinoBoards/master/package_mysensors.org_index.json \
   && arduino --install-library "MySensors")

COPY ./start-xvfb.sh /usr/local/bin/start-xvfb

ENV DISPLAY :1.0

COPY ./start-session.sh /usr/local/bin/start-session

CMD ["/bin/bash"]

ENTRYPOINT ["/usr/local/bin/start-session"]
