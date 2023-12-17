#!/bin/bash 

#backup /opt to backup drive

rsync -avh /opt /mnt/backup/optbackup
rsync -avh --delete /opt /mnt/backup/optbackup

#record completion in log
echo $(date "+%D - %T") --- opt backup successfully completed. >> /opt/logs/optbackup.log

