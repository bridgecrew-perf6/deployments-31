DESTINATIONS=$(curl -X GET localhost:32349 -H 'command: blockchain get operator bring [operator][local_ip] : [operator][port] separator=,' -H "User-Agent: AnyLog/1.23" -w "\n")

read -p "From a single point -- get information on any machine in the network"
printf "\n"
curl -X GET localhost:32349 -H "command: get platform info" -H "User-Agent: AnyLog/1.23" -H "service: sync" -H "destination: ${DESTINATIONS}"
printf "\n"
printf "\n"

#read -p "From a single point -- get information regarding the cpu info on any machine in the network"
#printf "\n"
#curl -X GET localhost:32349 -H "command: get cpu info" -H "User-Agent: AnyLog/1.23" -H "service: sync" -H "destination: 100.115.6.97:32148, 100.115.6.92:32158"
#printf "\n"
#printf "\n"


read -p "From a single point -- show INGESTION status"
printf "\n"
curl -X GET localhost:32349 -H "command: get streaming" -H "User-Agent: AnyLog/1.23" -H "service: sync" -H "destination: ${DESTINATIONS}"
printf "\n"
printf "\n"

read -p "From a single point --  query metadata (network members)"
printf "\n"
curl -X GET localhost:32349 -H 'command: blockchain get (master, operator, query) bring [*][name] \t - \t [*][local_ip] : [*][port]  separator=\n' -H "User-Agent: AnyLog/1.23" -w "\n"
printf "\n"
printf "\n"

read -p "From a single point -- query metadata (nodes hosting  device and insight data)"
printf "\n"
curl -X GET localhost:32349 -H "command: get data nodes" -H "User-Agent: AnyLog/1.23"
printf "\n"
printf "\n"

read -p "From a single point -- show data tables in the network (as a single machine)"
printf "\n"
curl -X GET localhost:32349 -H "command: get tables where dbms=*" -H "User-Agent: AnyLog/1.23"
printf "\n"
printf "\n"


read -p "From a single point -- show columns in a specific table"
printf "\n"
curl -X GET localhost:32349 -H "command: get columns where table=plc_sensor and dbms=nvidia" -H "User-Agent: AnyLog/1.23"
printf "\n"
printf "\n"


read -p "From a single point -- query the last 15 minutes of PLC data"
printf "\n"
curl -X GET localhost:32349 -H 'command: sql nvidia format=table and extend=(+ip, +node_name) "select timestamp, value FROM plc_sensor WHERE timestamp >= NOW() - 15 minutes ORDER BY value"' -H "User-Agent: AnyLog/1.23" -H "destination: network"
printf "\n"
printf "\n"



read -p "From a single point -- query statistics from the last 15 minutes"
printf "\n"
curl -X GET localhost:32349 -H 'command: sql nvidia format=table "select min(value), max(value), avg(value)  FROM plc_sensor WHERE timestamp >= NOW() - 15 minutes"' -H "User-Agent: AnyLog/1.23" -H "destination: network"
printf "\n"
printf "\n"


read -p "From a single point -- query TRAFFIC INSIGHTS over the past month"
printf "\n"
curl -X GET localhost:32349 -H 'command: sql nvidia format=table "select intersection, timestamp, speed FROM traffic_data ORDER BY timestamp"' -H "User-Agent: AnyLog/1.23" -H "destination: network"
printf "\n"
printf "\n"

read -p "Destination Nodes"
printf "\n"
curl -X GET localhost:32349 -H "command: query status" -H "User-Agent: AnyLog/1.23"
printf "\n"
printf "\n"

read -p "From a single point -- 101 N X University Ave."
printf "\n"
DESTINATION=$(curl -X GET localhost:32349 -H 'command: blockchain get operator where name=nvidia-nodeA bring [operator][local_ip] : [operator][port] ' -H "User-Agent: AnyLog/1.23" -w "\n")
curl -X GET localhost:32349 -H "command: sql nvidia format=table select intersection, timestamp, speed FROM traffic_data WHERE intersection='101 N / University Ave' ORDER BY timestamp DESC " -H "User-Agent: AnyLog/1.23" -H "destination: ${DESTINATION}"
printf "\n"
printf "\n"

read -p "Destination Nodes"
printf "\n"
curl -X GET localhost:32349 -H "command: query status" -H "User-Agent: AnyLog/1.23"
printf "\n"