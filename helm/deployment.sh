cd anylog
echo Deploy Master
helm fetch https://github.com/AnyLog-co/deployments/raw/nvidia/helm/packages/anylog-master-1.0220301.tgz
helm install anylog-master-1.0220301.tgz --generate-name

sleep 15

echo Depoloy Operator1
helm fetch https://github.com/AnyLog-co/deployments/raw/nvidia/helm/packages/anylog-operator1-1.0220301.tgz
helm install anylog-operator1-1.0220301.tgz --generate-name

sleep 10

echo Depoloy Operator2
helm fetch https://github.com/AnyLog-co/deployments/raw/nvidia/helm/packages/anylog-operator2-1.0220301.tgz
helm install anylog-operator2-1.0220301.tgz --generate-name

sleep 40

echo Deploy Query
helm fetch https://github.com/AnyLog-co/deployments/raw/nvidia/helm/packages/anylog-query-1.0220301.tgz
helm install anylog-query-1.0220301.tgz --generate-name

cd $HOME

curl -X GET localhost:32349 -H "command: blockchain get *" -H "User-Agent: AnyLog/1.23"

