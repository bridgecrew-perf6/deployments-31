DOCKER_REGISTRY_SERVER=docker.io
kubectl create secret docker-registry git-imagepullsecret \
  --docker-server=${DOCKER_REGISTRY_SERVER} \
  --docker-username=\$oauthtoken \
  --docker-password=a83691ce-df29-46e2-8c0e-00ff8a97e5b4 \

