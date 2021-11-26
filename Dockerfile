FROM ubuntu:latest
LABEL maintainer = "kilho.cho"

# install apt
RUN apt-get update
RUN apt-get -y upgrade
#install sudo
RUN apt-get install sudo
#install nginx
RUN apt-get install -y nginx
#install php8-fpm
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt install -y php8.0-fpm
#install nano
RUN apt-get install -y nano
#install git
RUN apt-get install -y git
#copy ssh-key
RUN mkdir /root/.ssh/
ADD id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
#git clone
RUN git clone git@github.com:DeathByS/docker.git

COPY default /etc/nginx/sites-available/

WORKDIR /docker/apiserver

CMD service php8.0-fpm start && nginx -g "daemon off;"

EXPOSE 80 
