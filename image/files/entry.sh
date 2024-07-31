#!/usr/bin/env bash

sftpctl entry --users-file=/etc/sftp/users.conf
sftpctl start 
tail -f /dev/null # run forever