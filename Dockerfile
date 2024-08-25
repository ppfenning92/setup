FROM ubuntu:24.04

ENV TZ=Europe/Berlin
ENV USER_TEST=p_test
ENV USER_SSH=p_ssh
ENV TERM=xterm-256color
ARG PASS=p

# update
RUN apt update -qqq && apt upgrade -y && apt dist-upgrade -y && apt autoremove -y
RUN apt install sudo git openssh-server -y

# config openssh-server
# RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "$USER_TEST ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
RUN echo "$USER_SSH ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

# add users
RUN useradd -ms /bin/bash $USER_TEST
RUN echo "${USER_TEST}:${PASS}" | chpasswd
RUN usermod -aG sudo $USER_TEST

RUN useradd -ms /bin/bash $USER_SSH
RUN echo "${USER_SSH}:${PASS}" | chpasswd
RUN usermod -aG sudo $USER_SSH


RUN mkdir /home/$USER_SSH/.ssh && chmod 700 /home/$USER_SSH/.ssh
COPY --chmod=0644 ./secrets/ssh/id_rsa.pub /home/$USER_SSH/.ssh/authorized_keys
RUN chown "$USER_SSH:$USER_SSH" -R /home/$USER_SSH 

WORKDIR /home/$USER_TEST

HEALTHCHECK CMD test -d /home/$USER_TEST || exit 1

# trivy:ignore:AVD-DS-0004
EXPOSE 22

USER $USER_TEST
# CMD ["/usr/sbin/sshd","-D"]
ENTRYPOINT sudo service ssh start && bash
