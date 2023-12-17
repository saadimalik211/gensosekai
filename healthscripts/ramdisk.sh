#!/bin/bash

#check ramdisk usage every 30 seconds and log it
#I will need to include a way to trim the log

dt=`date "+%D %T"`
ramdisklog="/opt/logs/ramdisk.log"

df /mnt/ramdisk/ -h > /tmp/du$$
while read line
do
  fields=`echo $line | awk '{print NF}'`
  case $fields in
     5) echo -n "$dt " >> $ramdisklog
         echo $line | awk '{print $5,$4}' >> $ramdisklog ;;
     6) echo -n "$dt " >> $ramdisklog
         echo $line | awk '{print $6,$5}' >> $ramdisklog ;;
     esac
done < /tmp/du$$
rm /tmp/du$$

