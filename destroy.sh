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
kubectl delete --all clusterissuer -n $1
kubectl delete --all certificate -n $1
kubectl delete --all secrets -n $1

# DELETE NAMESPACE
# NOTE: This is DESTRUCTIVE! It deletes EVERY resource added to
# the given namespace. USE ONLY IF NEEDED!
kubectl delete namespaces $1


