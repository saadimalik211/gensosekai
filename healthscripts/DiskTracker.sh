#!/bin/bash

dt=`date +%D`
raid5log="/opt/logs/raid5space.log"
backuplog="/opt/logs/backupspace.log"
hostdisklog="/opt/logs/hostdisk.log"

#raid5check
df /mnt/raid5/ -h > /tmp/du$$
while read line
do
    fields=`echo $line | awk '{print NF}'`
    case $fields in
    5) echo -n "$dt " >> $raid5log
        echo $line | awk '{print $5,$4}' >> $raid5log ;;
    6) echo -n "$dt " >> $raid5log
        echo $line | awk '{print $6,$5}' >> $raid5log ;;
    esac
done < /tmp/du$$
rm /tmp/du$$
#end raid5check


#backupcheck
df /mnt/backup/ -h >> /tmp/du$$
while read line
do
    fields=`echo $line | awk '{print NF}'`
    case $fields in
    5) echo -n "$dt " >> $backuolog
        echo $line | awk '{print $5,$4}' >> $backuplog ;;
    6) echo -n "$dt " >> $backuplog
        echo $line | awk '{print $6,$5}' >> $backuplog ;;
    esac
done < /tmp/du$$
rm /tmp/du$$
#end backupcheck


#hostdrivecheck
df /dev/sda6 -h >> /tmp/du$$
while read line
do
    fields=`echo $line | awk '{print NF}'`
    case $fields in
    5) echo -n "$dt " >> $hostdisklog
        echo $line | awk '{print $5,$4}' >> $hostdisklog ;;
    6) echo -n "$dt " >> $hostdisklog
        echo $line | awk '{print $6,$5}' >> $hostdisklog ;;
    esac
done < /tmp/du$$
rm /tmp/du$$
#end hostdrivecheck
