docker run -d -it --detach-keys="ctrl-d" -p 3000:3000 \
  --name=grafana \
  -v grafana-data:/var/lib/grafana \
  -v grafana-log:/var/log/grafana \
  -v grafana-config:/etc/grafana \
  -e "GF_INSTALL_PLUGINS=simpod-json-datasource,grafana-worldmap-panel" \
  grafana/grafana:7.5.7
