###############################################################
# backup.sh                                                   #
###############################################################
# Source: https://github.com/kuchenmond/minecraft             #
# Documentation: https://github.com/kuchenmond/minecraft      #
###############################################################
# Usage:                                                      #
# Add your information in the settings section.               #
# Mcrcon is required to run this script.                      #
###############################################################
# Version 0.8                                                 #
###############################################################

###############################################################
#  settings start                                             #
###############################################################

#connection             #directories - no trailing "/"
rcon_host=              rcon=/opt/minecraft/tools/mcrcon
rcon_port=              minecraft=/opt/minecraft/server
rcon_password=          backup=/mnt/backup/minecraft

###############################################################
#  settings end                                               #
###############################################################

function rcon {
  $rcon/mcrcon -H $rcon_host -P $rcon_port -p $rcon_password "$1"
}

rcon "save-off"
rcon "save-all"

tar -cvpzf $backup/server-$(date +%F_%R).tar.gz $minecraft

rcon "save-on"

find $backup/ -type f -mtime +7 -name '*.gz' -delete