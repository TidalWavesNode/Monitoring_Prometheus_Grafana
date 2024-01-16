#!/bin/bash

read -p "Do you want to install Prometheus and Node Exporter? (yes/no): " choice
if [[ $choice == "yes" ]]; then

#Install prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.49.1/prometheus-2.49.1.linux-amd64.tar.gz
tar xvfz prometheus-*.tar.gz
sleep 2
rm prometheus-*.tar.gz
mkdir /etc/prometheus /var/lib/prometheus
cd prometheus-2.49.1.linux-amd64
mv prometheus promtool /usr/local/bin/
mv prometheus.yml /etc/prometheus/prometheus.yml
mv consoles/ console_libraries/ /etc/prometheus/
useradd -rs /bin/false prometheus
chown -R prometheus: /etc/prometheus /var/lib/prometheus
sleep 2

# Content to be added
CONTENT="[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries \
    --web.listen-address=0.0.0.0:9090 \
    --web.enable-lifecycle \
    --log.level=info

[Install]
WantedBy=multi-user.target"

# Add the content to the prometheus.service file
echo "$CONTENT" | sudo tee /etc/systemd/system/prometheus.service > /dev/null

# Reload systemd to apply changes
systemctl daemon-reload

# Enable and start the Prometheus service
systemctl enable prometheus
systemctl start prometheus

# Check status with systemctl status prometheus

#Install and configure Node Exporter on the Client

wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz
tar xvfz node_exporter-*.tar.gz
mv node_exporter-1.7.0.linux-amd64/node_exporter /usr/local/bin
rm -r node_exporter-1.7.0.linux-amd64*
useradd -rs /bin/false node_exporter
sleep 2

# Define the content to be added
CONTENT="[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target"

# Add the content to the node_exporter.service file
echo "$CONTENT" | sudo tee /etc/systemd/system/node_exporter.service > /dev/null

# Reload systemd to apply changes
sudo systemctl daemon-reload

# Enable and start the Node Exporter service
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

#sudo systemctl status node_exporter

 echo "Prometheus and Node Exporter installation completed."

else
    echo "Prometheus and Node Exporter installation canceled."
fi
