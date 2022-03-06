# Deploying AnyLog 
This branch is intended for the deployment of [Aarna Network](https://www.aarnanetworks.com/) demo with AnyLog. The demo will include:
1 _Master_, 3 _Operator_ nodes and a _Query_ node against their [Multi-Cluster Orchestrator](https://www.aarnanetworks.com/amcop).

Please review the [original README](https://github.com/AnyLog-co/deployments/tree/master/REAME.md) for _docker_ deployment 


## Requirements
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) - Kubernetes command line tool
* [helm charts](https://jaya-maduka.medium.com/install-helm-on-ubuntu-20-04-bd5f490c895)
* [Sample Data Generator](https://github.com/AnyLog-co/Sample-Data-Generator) - AnyLog's sample data generator 
* [AnyLog API](https://github.com/AnyLog-co/AnyLog-API) - AnyLog API tool to update 

## Deploy AnyLog Nodes
### General Requirement - on all machines
1. Clone deployments directory & checkout _aarana_ branch  
```bash
cd $HOME
git clone https://github.com/AnyLog-co/deployments
cd $HOME/deployments
git checkout aarana 
```

2. Clone AnyLog-API directory - The AnyLog API has a set of 
[requirements](https://github.com/AnyLog-co/Sample-Data-Generator/blob/master/requirements.txt%20) that should be met 
for the run to succeed. 
```bash
cd $HOME
git clone https://github.com/AnyLog-co/AnyLog-API
```

3. Login into AnyLog for downloading repos - [contact us](mailto:info@anylog.co) for _DOCKER_PASSWORD_ 
```bash
bash $HOME/deployments//credentials.sh ${DOCKER_PASSWORD}
```

4. Deploy Postgres Database - if not deployed AnyLog will use [SQLite](https://sqlite.com/index.html) (no need to make any changes)
```commandline
helm install --generate-name $HOME/deployments/helm/postgres
```


### Master Node 
**Master Node** is a "notary" system between other nodes in the network via either a public or private blockchain.
The process will deploy a postgres database as well as an AnyLog node which will create a new database (called _blockchain_), 
which will contain information about the nodes and tables in the network. All other nodes in the network will sync against it. 

### Operator Node(s)
**Operator Node(s)** contain the data that's coming from the sensors; thus when executing a query the results are generated 
based on the information provided by the operator(s). For our demo, this section should be repeated 3 times on 3 different 
machines. 

### Query Node 
**Query Node** is a node dedicated to querying operator nodes, as well as generating reports using BI tools.  
1. On the same machine, or a machine that's accessible by the ndoe, install [Grafana](https://grafana.com/docs/grafana/latest/installation/) 
or other BI tool in order to [generate reports](https://github.com/AnyLog-co/documentation/tree/os-dev/northbound%20connectors) 
of the data. Docker deployment of Grafana can be found [here](grafana.sh) 

   
### Standalone 
**Standalone Node** deplolies _master_ and _operator_ as a single AnyLog instance. For the offical deployment we wil not 
be using this option. However, is avilable for testing purposes. 
1. Deploy [Standalone Helm Chart](helm/anylog-standalone)
    * Postgres 
    * AnyLog Node with Master and Operator 
    * [Remote-CLI](https://github.com/AnyLog-co/Remote-CLI) 
    * [GUI](https://github.com/AnyLog-co/AnyLog-GUI)
```bash
helm install --generate-name $HOME/deployments/helm/anylog-standalone/
```

2. Configure Remote Access to AnyLog Node
```bash 
minikube service --url anylog-node


<< COMMENT
http://192.168.49.2:31900 # TCP 
http://192.168.49.2:31864 # REST 
http://192.168.49.2:30260 # Broker 
COMMENT 
```

3. Start Data Generator(s) - AnyLog uses message clients to digest the data coming in. Since the processes are 
preconfigured, you cannot confuse between the two.
```bash
# REST 
python3 ~/Sample-Data-Generator/data_generator.py 192.168.49.2:31864 power post aarna_demo -e --topic power1

# Broker  
python3 ~/Sample-Data-Generator/data_generator.py 192.168.49.2:30260 synchrophasor mqtt aarna_demo -e --topic power2
```
