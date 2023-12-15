#!/bin/bash

#stop all the docker containers in an order that is a little safer

docker stop Box
docker stop BoxRedis
docker stop BoxDB

docker stop Photoprism
docker stop PhotoprismDB

docker stop Mealie
docker stop MealiePostgres

docker stop Bitwarden

docker stop Lidarr
docker stop Sonarr
docker stop Radarr
docker stop Transmission
docker stop Plex
docker stop Tautulli

docker stop PiHole
docker stop Traefik
docker stop Portainer

