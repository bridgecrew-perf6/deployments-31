# Deploying AnyLog Demo

The following directions are intended for a demo that has a 1 _master_, 3 _operators_ and a _query_ node. A user can (additionally)
deploy a _publisher_ node, which will distribute the data between the operators, rather than having data being sent directly into
each of the operators. 

**Requirements**
* Either docker or kubernetes to deploy nodes
* [Sample Data Generator](https://github.com/AnyLog-co/Sample-Data-Generator) - this will be used to generate data

## Deploy Postgres & AnyLog Node
1. Start Postgres Instance
```bash
# docker 
bash $HOME/deployments/docker-compose/postgres.sh

# helm
helm install --generate-name $HOME/deployments/helm/postgres 
```

2. Review and update Master node configs ([docker](docker-compose/anylog-node/envs/anylog_master.env) | [helm](helm/anylog-master/templates/master.yaml)) such as: 
    * Database credentials 
    * Company Name
    * TCP & REST Port 

3. Deploy Master node 
```bash
# docker
cd $HOME/deployments/docker-compose/anylog-node
cp $HOME/deployments/docker-compose/anylog-node/envs/anylog_master.env $HOME/deployments/docker-compose/anylog-node/envs/anylog_node.env
docker-compose up -d 

# helm
helm install --generate-name $HOME/deployments/helm/anylog-master
```

4. Review and update Operator configs ([docker](docker-compose/anylog-node/envs/anylog_operator.env) | [helm](helm/anylog-operator))
   * Database credentials
   * Master NODE IP + Port
   * Company Name
   * TCP & REST Port 
   * logical database name
   * cluster name (`NEW_CLUSTER`) - if 2 operators share a cluster they'll contain the same data (ie replication of one another)

5. Deploy Operator node
```bash
# docker
cd $HOME/deployments/docker-compose/anylog-node
cp $HOME/deployments/docker-compose/anylog-node/envs/anylog_operator.env $HOME/deployments/docker-compose/anylog-node/envs/anylog_node.env
docker-compose up -d 

# helm
helm install --generate-name $HOME/deployments/helm/anylog-operator
```

6. To add additional operators repeat steps 4 & 5 - Note, no two nodes can have the same ports against the same IP   
 

7. Review and update Query configs ([docker](docker-compose/anylog-node/envs/anylog_query.env) | [helm](helm/anylog-query))
   * Database credentials 
   * Master NODE IP + Port
   * Company Name
   * TCP & REST Port


8. Deploy Query node
```bash
# docker
cd $HOME/deployments/docker-compose/anylog-node
cp $HOME/deployments/docker-compose/anylog-node/envs/anylog_query.env $HOME/deployments/docker-compose/anylog-node/envs/anylog_query.env
docker-compose up -d 

# helm
helm install --generate-name $HOME/deployments/helm/anylog-query
```

9. **Optional**: Review and update Publisher configs ([docker](docker-compose/anylog-node/envs/anylog_publisher.env) | [helm](helm/anylog-publisher))
   * Database credentials 
   * Master NODE IP + Port
   * Company Name
   * TCP & REST Port


10. **Optional**: Deploy Publisher node
```bash
# docker
cd $HOME/deployments/docker-compose/anylog-node
cp $HOME/deployments/docker-compose/anylog-node/envs/anylog_publisher.env $HOME/deployments/docker-compose/anylog-node/envs/anylog_query.env
docker-compose up -d 

# helm
helm install --generate-name $HOME/deployments/helm/anylog-publisher
```

## Start Demo
1. Download [Sample Data Generator](https://github.com/AnyLog-co/Sample-Data-Generator) & add requirements  
   * [requests](https://pypi.org/project/requests)
   * [paho-mqtt](https://pypi.org/project/paho-mqtt/)
   * [pytz](https://pypi.org/project/pytz/)
   * [tzlocal](https://pypi.org/project/tzlocal/) 
   * [kafka-python]
```bash
git clone https://github.com/AnyLog-co/Sample-Data-Generator
python3 -m pip install --upgrade -r $HOME/Sample-Data-Generator/requirements.txt
```

2. Insert data into Operator Node(s)
```bash 
python3 /Users/orishadmon/Sample-Data-Generator/data_generator.py ${OPERATOR_1_IP}:${OPERATOR_1_REST_PORT},${OPERATOR_2_IP}:${OPERATOR_2_REST_PORT},${OPERATOR_3_IP}:${OPERATOR_3_REST_PORT} power post test --topic power1  --repeat 10
python3 /Users/orishadmon/Sample-Data-Generator/data_generator.py ${OPERATOR_1_IP}:${OPERATOR_1_BROKER_PORT} synchrophasor mqtt test --topic power2
```

3. Use Grafana or [other types analytics tools](https://github.com/AnyLog-co/documentation/tree/master/northbound%20connectors) to generate graphs


## Sample Commands to validate connection & data
* Get node status
```commandline
curl -X GET ${NODE_IP}:${NODE_REST_PORT} -H "command: get status" -H "User-Agent: AnyLog/1.23"
```

* View data coming in
```commandline
curl -X GET ${OPERATOR_IP}:${OPERATOR_REST_PORT} -H "command: get streaming" -H "User-Agent: AnyLog/1.23"
```
