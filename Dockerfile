FROM ubuntu

ENV USER=p
ARG PASS=p
# update
RUN apt update -qqq && apt upgrade -y && apt dist-upgrade -y && apt autoremove -y
RUN apt install sudo git -y

# add user
RUN useradd -ms /bin/bash $USER
RUN echo "${USER}:${PASS}" | chpasswd
RUN usermod -aG sudo $USER

USER $USER

WORKDIR /home/$USER


