#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: destroy.sh NAMESPACE" >&2
  exit 1
fi

# DELETE CONFIGMAP
kubectl delete configmap -n $1 configmap-aviot

# DELETE RESOURCES
kubectl delete --all deployment -n $1
kubectl delete --all service -n $1
kubectl delete --all ingress -n $1

# DELETE NAMESPACE
# NOTE: This is DESTRUCTIVE! It deletes EVERY resource added to
# the given namespace. USE ONLY IF NEEDED!
kubectl delete namespaces $1

# kubectl delete deployment -n $1 aviot-fe
# kubectl delete deployment -n $1 dnsserverapp-complete
# kubectl delete deployment -n $1 janus-gateway
# kubectl delete deployment -n $1 mlvpn
# kubectl delete deployment -n $1 mongo
# kubectl delete deployment -n $1 redis
# kubectl delete deployment -n $1 restapi
# kubectl delete deployment -n $1 ros-master
# kubectl delete deployment -n $1 ros-node
# kubectl delete deployment -n $1 wss

# kubectl delete service -n $1 aviot-fe
# kubectl delete service -n $1 dnsserverapp
# kubectl delete service -n $1 janus-gateway
# kubectl delete service -n $1 mlvpn
# kubectl delete service -n $1 mongo
# kubectl delete service -n $1 redis
# kubectl delete service -n $1 restapi
# kubectl delete service -n $1 ros-master
# kubectl delete service -n $1 ros-node
# kubectl delete service -n $1 wss


