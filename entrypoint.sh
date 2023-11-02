#!/bin/sh -l
# hcloud context create my-hcloud-context --token $HCLOUD_TOKEN
SEVER_TYPE=$1
SERVER_NAME=$2
HCLOUD_TOKEN=$3
HCLOUD_SSH_KEY=$4
HCLOUD_DNS_ZONE=$5
HCLOUD_FIREWALL=$6

echo "Set ENV VAR HCLOUD_TOKEN"
export HCLOUD_TOKEN=$HCLOUD_TOKEN

hcloud server list




#hcloud context create my-hcloud-context --token $1

