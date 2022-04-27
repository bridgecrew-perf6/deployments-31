# Code to deploy Remote-CLI
# --> Repo: https://github.com/AnyLog-co/Remote-CLI

CONN_IP=0.0.0.0
CLI_PORT=31800

docker run -p ${CLI_PORT}:${CLI_PORT} --name remote-cli \
   -e CONN_IP=${CONN_IP} \
   -e CLI_PORT=${CLI_PORT} \
   -v remote-cli:/app/Remote-CLI/anylog_query/static/json \
   --rm -d -it --detach-keys="ctrl-d" anylogco/remote-cli:latest