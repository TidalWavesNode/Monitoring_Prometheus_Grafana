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

![image](https://github.com/TidalWavesNode/Monitoring_Prometheus_Grafana/assets/33072338/4ad16966-fc5d-4894-a880-49995a0d0c51)


## Access Grafana

    http://MONITORINGIP:3000

    user name (admin) 
    pw (admin)
