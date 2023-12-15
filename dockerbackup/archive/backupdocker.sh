#!/bin/bash


#backup Box / NextCloud
docker stop Box
docker stop BoxRedis
docker stop BoxDB

rsync -avh --delete /mnt/raid5/DockerVolumes/NextCloud /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/NextCloud /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/NextCloudData /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/NextCloudData /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/NextCloudDB /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/NextCloudDB /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/NextCloudRedis /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/NextCloudRedis /mnt/backup/dockerbackup

docker start BoxDB
docker start BoxRedis
docker start Box
#end


#backup Photoprism
docker stop Photoprism
docker stop PhotoprismDB

rsync -avh --delete /mnt/raid5/DockerVolumes/PhotoprismDB /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/PhotoprismDB /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/PhotoprismImport /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/PhotoprismImport /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/PhotoprismOriginals /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/PhotoprismOriginals /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/PhotoprismStorage /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/PhotoprismStorage /mnt/backup/dockerbackup

docker start Photoprism
docker start PhotoprismDB
#end


#backup Mealie
docker stop Mealie
docker stop MealiePostgres

rsync -avh --delete /mnt/raid5/DockerVolumes/Mealie /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/Mealie /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/MealiePostgres /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/MealiePostgres /mnt/backup/dockerbackup

docker start Mealie
docker start MealiePostgres
#end


#backup Bitwarden
docker stop Bitwarden

rsync -avh --delete /mnt/raid5/DockerVolumes/BitwardenData /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/BitwardenData /mnt/backup/dockerbackup

docker start Bitwarden
#end


#backup PiHole
docker stop PiHole

rsync -avh --delete /mnt/raid5/DockerVolumes/PiHoleCnfg /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/PiHoleCnfg /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/PiHoleDNSMASQ /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/PiHoleDNSMASQ /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/PiHoleInternal /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/PiHoleInternal /mnt/backup/dockerbackup

docker start PiHole
#end


#backup Traefik
docker stop Traefik

rsync -avh --delete /mnt/raid5/DockerVolumes/Traefik /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/Traefik /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/TraefikTmp /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/TraefikTmp /mnt/backup/dockerbackup

docker start Traefik
#end


#backup Portainer
docker stop Portainer

rsync -avh --delete /mnt/raid5/DockerVolumes/Portainer /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/Portainer /mnt/backup/dockerbackup

docker start Portainer
#end


#backup Radarr, Sonarr, Lidarr, Transmission
docker stop Radarr
docker stop Sonarr
docker stop Lidarr
docker stop Transmission

rsync -avh --delete /mnt/raid5/DockerVolumes/RadarrConfig /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/RadarrConfig /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/SonarrConfig /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/SonarrConfig /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/LidarrConfig /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/LidarrConfig /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/TransmissionCfg /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/TransmissionCfg /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/TransmissionDownloads /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/TransmissionDownloads /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/TransmissionWatch/mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/TransmissionWatch /mnt/backup/dockerbackup

docker start Radarr
docker start Sonarr
docker start Lidarr
docker start Transmission
#end


#backup Plex
docker stop Plex

rsync -avh --delete /mnt/raid5/DockerVolumes/PlexData /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/PlexData /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/PlexDB /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/PlexDB /mnt/backup/dockerbackup

docker start Plex
#end

#backup Tautulli
docker stop Tautulli

rsync -avh --delete /mnt/raid5/DockerVolumes/TautulliConfig /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/TautulliConfig /mnt/backup/dockerbackup

rsync -avh --delete /mnt/raid5/DockerVolumes/TautulliLogs /mnt/backup/dockerbackup
rsync -avh /mnt/raid5/DockerVolumes/TautulliLogs /mnt/backup/dockerbackup

docker start Tautulli
#end


#prune unused images
docker image prune -f -a

#record completion in log
echo $(date "+%D - %T") --- Docker backup successfully completed. >> /opt/logs/backupdocker.log
