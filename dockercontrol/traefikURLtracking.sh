#!/bin/bash
#### This script will:
### A. Update traefik acme.json to remove any no longer used certs.
### B. Update DDNS to add/remove any URLs
### C. Keep logs of URLs+Dates. Also maintain a 'current' file of latest URLs.

### B. Updated DDNS.env for dynamic dns
## Get the currently configured for traefik URLs
urls=$( cat /opt/Docker/Compose/*/* | grep traefik.frontend.rule | cut -c 37- | cut -d . -f 1 )

## Make a new copy of the env file, stripping the SUBDOMAINS out, to be repopulated
sed '5d' /opt/Docker/Compose/DDNS.gensosekai.com/DDNS.test.env > /tmp/DDNS.env.new
sed -i '5i SUBDOMAINS=@,' /tmp/DDNS.env.new

## Loop to add the subdomain URLs using the current list of configured URLs for traefik.
for val in $urls; do
  sed -i "/SUBDOMAINS/s/$/$val,/" /tmp/DDNS.env.new
done


### A. Update traefik acme.json to remove any no longer used certs
## Get the currently configured URLs for traefik certs
traefikcerts=$( cat /mnt/raid5/DockerVolumes/Traefik/acme.json | grep Main | cut -c 18- | cut -d . -f 1 )

#maybe iterate, and then diff?
#once we know one does not belong, we find and use sed to exclude that line plus the ones around it that are needed
# NEED TO REMOVE 2 ABOVE, 5 BELOW, AND CURRENT. 8 LINES TOTAL.
# MAYBE OUTPUT LINE NUMBER OF ENTRY, THEN REMOVE ALL 8 AT ONCE USING THE LINE#?
#
#{ 
#   Domain {
#      Main: URL <<<<<<<<<<< key line.
#      SANS: null
#  }
#  CERTLINE
#  KEYLINE
# },
#
#   


