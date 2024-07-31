FROM ubuntu:22.04
USER root

RUN apt-get update && apt-get-upgrade -y
RUN apt-get install -y curl openssh-server
RUN rm -rf /var/lib/apt/lists/* && rm -f /etc/ssh/id_*
RUN mkdir -p /var/run/sshd

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly
copy files/sshd.conf /etc/ssh/sshd_config
COPY files/sftpctl /root/
RUN cd /root/sftpctl && cargo install --path .

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
ENTRYPOINT ["sftpctl entry --users-file=/etc/sftp/users.conf"]
