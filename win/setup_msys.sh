#!/bin/bash
pacman -Syu vim bash-completion


# change home directory
sed -i '/db_home /c\db_home: windows' /etc/nsswitch.conf
