#!/bin/bash

DNS_SERVER_ADDRESS=$2 NUMBER=1 envsubst < ROS-TEST/ros-test.yaml | kubectl delete -n $1 -f -
DNS_SERVER_ADDRESS=$2 NUMBER=2 envsubst < ROS-TEST/ros-test.yaml | kubectl delete -n $1 -f -
