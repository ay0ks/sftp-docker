FROM ubuntu:24.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl openssh-server gcc build-essential
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly
RUN mkdir -p /var/run/sshd

COPY files/sshd.conf /etc/ssh/sshd_config
COPY files/sftpctl /root/sftpctl
COPY files/entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN . /root/.cargo/env && cargo install --path /root/sftpctl --root /
RUN cp /bin/sftpctl /sbin/

RUN rm -rf /var/lib/apt/lists/*

ENV NOTVISIBLE="in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
ENTRYPOINT ["/entry.sh"]
