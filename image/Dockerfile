FROM ubuntu:24.04
USER root

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl openssh-server gcc build-essential
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly
RUN mkdir -p /var/run/sshd

COPY files/entry.sh /root/entry.sh
COPY files/sshd.conf /etc/ssh/sshd_config
COPY files/sftpctl /root/sftpctl

RUN . /root/.cargo/env && cargo install --path /root/sftpctl --root /
RUN cp /bin/sftpctl /sbin/

RUN rm -f /etc/ssh/id_*
RUN rm -rf /var/lib/apt/lists/*

ENV NOTVISIBLE="in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
ENTRYPOINT ["/root/entry.sh"]