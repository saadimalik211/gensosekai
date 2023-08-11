#!/bin/bash

# Known network interfaces
INTERFACE1=eno1
INTERFACE2=enp1s0

# Configure IP addresses
/sbin/ip addr add 192.168.0.2/24 dev $INTERFACE1
/sbin/ip addr add 192.168.0.250/24 dev $INTERFACE2

# Create a separate script to run at boot
echo '#!/bin/bash
/sbin/ip addr add 192.168.0.2/24 dev '$INTERFACE1'
/sbin/ip addr add 192.168.0.250/24 dev '$INTERFACE2'' > /usr/local/bin/configure-network-boot.sh

# Make the boot script executable
chmod +x /usr/local/bin/configure-network-boot.sh

# Create systemd service file to run the above script at boot
echo '[Unit]
Description=Configure network interfaces
Wants=network.target
Before=network.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/configure-network-boot.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/configure-network.service

# Reload systemd configuration
systemctl daemon-reload

# Enable the service to start on boot
systemctl enable configure-network.service

# Start the service immediately
systemctl start configure-network.service

echo "Network configuration completed successfully."

