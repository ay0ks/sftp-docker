#!/usr/bin/env bash

sftpctl entry --users-file=/etc/sftp/users.conf
tail -f /dev/null # run forever