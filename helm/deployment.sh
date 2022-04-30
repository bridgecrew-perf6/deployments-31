cd $HOME/anylog

echo "Install Master"
helm fetch https://github.com/AnyLog-co/deployments/blob/nvidia/helm/packages/anylog-master-1.0220301.tgz
helm install anylog-master-1.0220301.tgz
sleep 10

echo "Install Operators"
helm fetch https://github.com/AnyLog-co/deployments/blob/nvidia/helm/packages/anylog-operator1-1.0220301.tgz
helm install anylog-operator1-1.0220301.tgz

hel fetch https://github.com/AnyLog-co/deployments/blob/nvidia/helm/packages/anylog-operator2-1.0220301.tgz
helm install anylog-operator2-1.0220301.tgz

sleep 30

echo "Install Query"
helm fetch https://github.com/AnyLog-co/deployments/blob/nvidia/helm/packages/anylog-query-1.0220301.tgz
sleep 10
helm install anylog-query-1.0220301.tgz

sleep 30
