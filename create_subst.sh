#!/bin/bash

if [ "$#" -ne 5 ]; then
  echo "Usage: create.sh COM_NAME COM_PASSWORD SUPERNODE_URL NAMESPACE DNS_SERVER_ADDRESS" >&2
  exit 1
fi

kubectl create namespace agri

# CONFIG MAP
COM_NAME=agri COM_PASSWORD=agri SUPERNODE_URL=18.188.136.98:7654 TENANT_ID=agri envsubst < configmap.yaml | kubectl apply -n agri -f -

# NORMAL PODS
kubectl apply -n agri -f Frontend/aviot-fe.yaml
kubectl apply -n agri -f MongoDB/mongodb.yaml
kubectl apply -n agri -f REDIS/redis.yaml
kubectl apply -n agri -f REST-API/rest-api.yaml
kubectl apply -n agri -f WebSoketServer/ws-server.yaml

# PODS WITH N2N ADDRESS
#DNS_SERVER_ADDRESS=10.11.0.1 envsubst < DnsServerAppComplete/dnsserverapp-complete.yaml | kubectl apply -n agri -f -
#DNS_SERVER_ADDRESS=10.11.0.1 envsubst < MLVPN/MLVPN.yaml | kubectl apply -n agri -f -
DNS_SERVER_ADDRESS=10.11.0.1 envsubst < ROS-CORE/ros.yaml | kubectl apply -n agri -f -
DNS_SERVER_ADDRESS=10.11.0.1 envsubst < ROS-NODE-JS/ros-node.yaml | kubectl apply -n agri -f -
DNS_SERVER_ADDRESS=10.11.0.1 envsubst < VideoServer/janus.yaml | kubectl apply -n agri -f -

# INGRESS RULES
TENANT_ID=agri envsubst < Ingress-Rules/ingress_rules.yaml | kubectl apply -n agri -f -

# ISSUERS
TENANT_ID=agri envsubst < Issuer/letsencrypt.yaml | kubectl apply -n agri -f -
