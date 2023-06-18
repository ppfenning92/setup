FROM ubuntu

ENV USER=p
ARG PASS=p
# update
RUN apt update -qqq && apt upgrade -y && apt dist-upgrade -y
RUN apt install sudo -y

# add user
RUN useradd -ms /bin/bash $USER
RUN echo "${USER}:${PASS}" | chpasswd
RUN usermod -aG sudo $USER
RUN mkdir -p /opt/system-setup
RUN chown "$USER:$USER" -R /opt/system-setup

USER $USER

WORKDIR /home/$USER

