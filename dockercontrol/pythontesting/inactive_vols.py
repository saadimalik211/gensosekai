import subprocess

def list_unassociated_volumes():
    print("Listing volumes not associated with a container:")
    # List all volumes
    all_volumes = subprocess.getoutput('docker volume ls --format "{{.Name}}"').splitlines()
    for volume_name in all_volumes:
        # Check if the volume is associated with any container
        associated_containers = subprocess.getoutput(f'docker ps -a --filter volume="{volume_name}" --format "{{.Names}}"')
        if not associated_containers:
            print(f"  {volume_name}")

