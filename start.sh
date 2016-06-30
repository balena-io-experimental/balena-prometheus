# Do some intial setup
bash /etc/config/config.sh
# Start the node exporter
cd /etc/node_exporter-$NODE_EXPORTER_VERSION.$DIST_ARCH \
  && ./node_exporter &
# Start prometheus server
cd /etc/prometheus-$PROMETHEUS_VERSION.$DIST_ARCH \
  && ./prometheus -web.listen-address ":80" \
  -storage.local.path "/data" -storage.local.retention ${STORAGE_LOCAL_RETENTION} \
  -alertmanager.url "http://localhost:9093" &
# Load configs from envars && start alertmanager
cd /etc/alertmanager-$ALERTMANAGER_VERSION.$DIST_ARCH \
  && ./alertmanager -config.file=alertmanager.yml
