#!/bin/bash

if [ "$#" -ne 5 ]; then
  echo "Usage: create.sh COM_NAME COM_PASSWORD SUPERNODE_URL NAMESPACE DNS_SERVER_ADDRESS" >&2
  exit 1
fi

kubectl create namespace $4

# CONFIG MAP
COM_NAME=$1 COM_PASSWORD=$2 SUPERNODE_URL=$3 TENANT_ID=$4 envsubst < configmap.yaml | kubectl apply -n $4 -f -

# NORMAL PODS
kubectl apply -n $4 -f Frontend/aviot-fe.yaml
kubectl apply -n $4 -f MongoDB/mongodb.yaml
kubectl apply -n $4 -f REDIS/redis.yaml
kubectl apply -n $4 -f REST-API/rest-api.yaml
kubectl apply -n $4 -f WebSoketServer/ws-server.yaml

# PODS WITH N2N ADDRESS
DNS_SERVER_ADDRESS=$5 envsubst < DnsServerAppComplete/dnsserverapp-complete.yaml | kubectl apply -n $4 -f -
DNS_SERVER_ADDRESS=$5 envsubst < MLVPN/MLVPN.yaml | kubectl apply -n $4 -f -
DNS_SERVER_ADDRESS=$5 envsubst < ROS-CORE/ros.yaml | kubectl apply -n $4 -f -
DNS_SERVER_ADDRESS=$5 envsubst < ROS-NODE-JS/ros-node.yaml | kubectl apply -n $4 -f -
DNS_SERVER_ADDRESS=$5 envsubst < VideoServer/janus.yaml | kubectl apply -n $4 -f -

# INGRESS RULES
TENANT_ID=$4 envsubst < Ingress-Rules/ingress_rules.yaml | kubectl apply -n $4 -f -

# ISSUERS
TENANT_ID=$4 envsubst < Issuer/letsencrypt.yaml | kubectl apply -n $4 -f -
