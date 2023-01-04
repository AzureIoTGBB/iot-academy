FROM registry.hub.docker.com/grafana/grafana
SHELL ["/bin/bash", "-c"]

WORKDIR /home/root

COPY datasources.yaml /etc/grafana/provisioning/datasources/
COPY dashboards.yaml /etc/grafana/provisioning/dashboards/
COPY dashboard.json /var/lib/grafana/dashboards/
COPY dashboard.json /usr/share/grafana/public/dashboards/home.json
