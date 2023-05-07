#!/bin/bash

# Will output information from: backupdocker.log  backupspace.log  certbotmail.log  hostdisk.log  raid5space.log  ramdisk.log


#backupdocker.log
tmp=`tail -n 5 /opt/logs/backupdocker.log`
echo -e "Docker Backup:\n$tmp"

#backupspace.log
tmp=`tail -n 1 /opt/logs/backupspace.log`
tmp2=`df -h | grep backup | awk '{print $5}'`
echo -e "Backup Disk:\n$tmp live: $tmp2"

#raid5space.log
tmp=`tail -n 1 /opt/logs/raid5space.log`
tmp2=`df -h | grep raid | awk '{print $5}'`
echo -e "Raid5 Array:\n$tmp live: $tmp2"

#hostdisk.log
tmp=`tail -n 1 /opt/logs/hostdisk.log`
tmp2=`df -h | grep sda6 | awk '{print $5}'`
echo -e "Host Disk:\n$tmp live: $tmp2"

#UPS power load
#tmp=`apcaccess | grep LOAD`
#echo -e "UPS Power Load: $tmp"

#certbotmail.log


#ramdisk peak 10
tmp=`cat /opt/logs/ramdisk.log | sort -rk4 | head -10`
tmp2=`df -h | grep ramdisk | awk '{print $5}'`
echo -e "Top 10 ramdisk entries:\n$tmp \nCurrently: $tmp2"


