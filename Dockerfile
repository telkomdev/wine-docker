FROM ubuntu:18.04

WORKDIR /usr/src/app
ENV APP_PATH=/usr/src/app

RUN apt-get update

RUN apt-get install -y wget software-properties-common gnupg2 winbind

RUN dpkg --add-architecture i386
RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key
RUN apt-key add winehq.key
RUN apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
RUN add-apt-repository ppa:cybermax-dexter/sdl2-backport
RUN apt-get update

RUN apt install -y --install-recommends --allow-unauthenticated winehq-stable

RUN apt-get clean -y
RUN apt-get autoremove -y

# setup vars for wine
#ENV DISPLAY="11.0"
ENV DISPLAY=":0.0"
ENV WINEARCH="win64"
ENV WINEPREFIX="/root/.wine64"
ENV WINESYSTEM32="/root/.wine64/drive_c/windows/system32"
ENV WINEDLLOVERRIDES="mscoree,mshtml="
ENV WINEDEBUG=fixme-all

RUN winecfg

COPY hello ${APP_PATH}/hello
COPY start ${APP_PATH}/start
RUN chmod +x ${APP_PATH}/start

CMD ["/usr/src/app/start"]