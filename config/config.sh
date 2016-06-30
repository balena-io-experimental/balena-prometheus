# Replace all ENVARS in all config files
find /etc/config -type f -exec sed -i -e s/GMAIL_ACCOUNT/${GMAIL_ACCOUNT}/g \
-e s/GMAIL_AUTH_TOKEN/${GMAIL_AUTH_TOKEN}/g \
-e s/THRESHOLD_CPU/${THRESHOLD_CPU}/g \
-e s/THRESHOLD_MEM/${THRESHOLD_MEM}/g \
-e s/THRESHOLD_FS/${THRESHOLD_FS}/g \
-e s/RESIN_APP_ID/${RESIN_APP_ID}/g \
-e s/RESIN_DEVICE_UUID/${RESIN_DEVICE_UUID}/g \
-e s/ALERTMANAGER_PATH/alertmanager-${ALERTMANAGER_VERSION}.${DIST_ARCH}/g \
{} \;

# mv config files to correct dir
mv -t /etc/prometheus-$PROMETHEUS_VERSION.$DIST_ARCH/ /etc/config/prometheus.yml /etc/config/alert.rules
mv -t /etc/alertmanager-$ALERTMANAGER_VERSION.$DIST_ARCH/ /etc/config/alertmanager.yml /etc/config/default.tmpl
