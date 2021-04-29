#!/bin/bash

if [ "$#" -ne 4 ]; then
  echo "Usage: create.sh COM_NAME COM_PASSWORD SUPERNODE_URL NAMESPACE" >&2
  exit 1
fi

kubectl create namespace $4

COM_NAME=$1 COM_PASSWORD=$2 SUPERNODE_URL=$3 TENANT_ID=$4 envsubst < configmap.yaml | kubectl apply -n $4 -f -
kubectl apply -n $4 -f DnsServerAppComplete/dnsserverapp-complete.yaml
kubectl apply -n $4 -f Frontend/aviot-fe.yaml
kubectl apply -n $4 -f MLVPN/MLVPN.yaml
kubectl apply -n $4 -f MongoDB/mongodb.yaml
kubectl apply -n $4 -f REDIS/redis.yaml
kubectl apply -n $4 -f REST-API/rest-api.yaml
kubectl apply -n $4 -f ROS-CORE/ros.yaml
kubectl apply -n $4 -f ROS-NODE-JS/ros-node.yaml
kubectl apply -n $4 -f VideoServer/janus.yaml
kubectl apply -n $4 -f WebSoketServer/ws-server.yaml

