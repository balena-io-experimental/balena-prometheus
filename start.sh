# Start the node exporter
cd /etc/node_exporter-$NODE_EXPORTER_VERSION.$DIST_ARCH \
  && ./node_exporter -web.listen-address ":80" \
    -storage.local.path "/data" -storage.local.retention 360h0m0s
