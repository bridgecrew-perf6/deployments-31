DOCKER_REGISTRY_SERVER=nvcr.io 
DOCKER_USER=\$oauthtoken
DOCKER_PASSWORD=ZHZ1b3EyNWdlcG5kNXJzZHBzbXVoM2Y5ZmI6ODQ4YzNlYWQtZThmNi00NTY5LTliNDItZDgzMTU5NGU5NDAy
kubectl create secret docker-registry imagepullsecret \
  --docker-server=${DOCKER_REGISTRY_SERVER} \
  --docker-username=${DOCKER_USER} \
  --docker-password=${DOCKER_PASSWORD} \