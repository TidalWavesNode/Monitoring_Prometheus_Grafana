## Monitoring remote servers using Prometheus, Node Exporter, and Grafana

### Prometheus and Node Exporter Install

#### Download script:
    wget https://raw.githubusercontent.com/TidalWavesNode/Monitoring_Prometheus_Grafana/main/prometheus.sh

#### Change permissions:
    chmod +x prometheus.sh

#### Run script:
    bash prometheus.sh

### Grafana Server Install:

#### Download script:
    wget https://raw.githubusercontent.com/TidalWavesNode/Monitoring_Prometheus_Grafana/main/grafana.sh

#### Change permissions:

    chmod +x grafana.sh

#### Run script:
    bash grafana.sh

## Configure Prometheus to Monitor Client Nodes

### On the monitoring server running Prometheus, open prometheus.yml

    nano /etc/prometheus/prometheus.yml

### Example config, add remote server IP with port 9100

#!/bin/bash
#example
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "remote_collector"
    scrape_interval: 10s
    static_configs:
      - targets:
        - "SERVERIP:9100"
        - "localhost:9100"
