## This is a demo of prometheus.io monitoring system with resin.io

It's composed of three services.

The [node_exporter](https://github.com/prometheus/node_exporter) - Crawls for machine metrics and posts to localhost:9100
The [prometheus server](https://github.com/prometheus/prometheus) - Scrapes target urls (in this case the node_exporter) and saves this in db which then allows you to query and perform actions on this data
The [alertmanager](https://github.com/prometheus/alertmanager/) - This is a server that prometheus server will post to if any of the [rules](/config/alert.rules) and broken. It then forwards the alert to the receivers you have configured.

## How to use

Push this repo to you're resin application and set the following environment variables

| Key              | Value                            |   Default |
|------------------|----------------------------------|           |
| GMAIL_ACCOUNT    | your gmail email                 |           |
| GMAIL_AUTH_TOKEN | you gmail password or auth token |           |
| THRESHOLD_CPU    | max % of CPU that should be in use |         |
| THRESHOLD_FS     | max % of filesystem that should be in use |  |
| THRESHOLD_MEM    | max mb of mem that should be be in use |     |
| LOCAL_STORAGE_RETENTION |                          |            |

## View data

Then visit `http://<your-device-ip>:9100/metrics`, you'll see all your machine metrics from the node_exporter in plain-text.

This data is also accessible from the prometheus server. The prometheus server is hosted on port `80` so you can view it locally `http://<your-device-ip>` or enable your [public device url](http://docs.resin.io/#/pages/management/devices.md#enable-public-device-url) and then visit the generated url.

From here you can create custom graphs and query data using [prometheus's query language](https://prometheus.io/docs/querying/basics/), or view a prebuilt template by visiting `http://<your-device-ip>/consoles/node.html`.

## Test ALERTS

Visit `http://<your-device-ip>/alerts`, you'll see a few alerts there. These are defined in [alert.rules](/config/alert.rules). The easiest one to test is the first, `service_down`, this alert is triggered when the targets (the instances prometheus server is scraping) drops to zero. Because we only have one target instance (`node_exporter`) we simply have to kill that process to trigger the alert.

Using the [resin web terminal](http://docs.resin.io/runtime/terminal/) run `$ pkill node_exporter`. If you then refresh `http://<your-device-ip>/alerts` you'll see the alert is firing. You will also get an email with the alert description and which device it is affecting.

![email-alert]('docs/email-alert.png')

## Sync with Grafana

[Grafana](http://grafana.org/) is an open source graphing platform which syncs really well with prometheus. It also allows you to view all of your data sources, which in this case is all your resin devices in one place.

It's a 3 step process.

1. [Install Grafana](http://docs.grafana.org/installation/)
2. [Add your resin devices as data sources using your resin device url](https://prometheus.io/docs/visualization/grafana/)
3. Import dashboards: from the Grafana menu go `dashboards` -> `import` and select a json file from [/dashboards](/dashboards)

!![single-device]('docs/single-device.png')

NOTE: The `All-devices.json` dashboard view will not automatically pull in your datasources, you'll have to manually add them.

TODO:
* Add example of multiple receivers for alertmanager `eg team-x, team-y`
* Script to auto import new devices into grafana as device sources
* Sensor monitoring example http://www.robustperception.io/quick-sensor-metrics-with-the-textfile-collector/
