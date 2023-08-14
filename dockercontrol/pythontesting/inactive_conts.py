import subprocess

def list_inactive_containers():
    print("Listing inactive Docker containers and their associated volumes:")
    # List inactive containers
    result = subprocess.getoutput('docker ps --filter "status=exited" --format "{{.Names}}"').splitlines()
    for container_name in result:
        print(f"Container: {container_name}")
        # List associated volumes for the container
        container_volumes = subprocess.getoutput(f'docker container inspect --format "{{{{ range .Mounts }}}}{{{{ .Name }}}}-{{{{ .Destination }}}}; {{{{ end }}}}" {container_name}').strip()
        if container_volumes:
            volumes = container_volumes.split(";")
            for volume in volumes:
                if volume:
                    volume_name, volume_destination = volume.split("-", 1)
                    if volume_name == "None":
                        print(f"  Anonymous Volume: {volume_destination}")
                    else:
                        print(f"  Volume: {volume_name} | Destination: {volume_destination}")
        else:
            print("  No Volumes")

