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

hcloud server list | grep $SERVER_NAME
if [ $? -eq 0 ]; then
  echo "Server $SERVER_NAME already exists"
  exit 1
fi

echo "Save SSH Key"
echo $HCLOUD_SSH_KEY > /tmp/hcloud_ssh_key
chmod 600 /tmp/hcloud_ssh_key


echo "Create server $SERVER_NAME"
hcloud server create --image ubuntu-20.04 --name $SERVER_NAME --type $SEVER_TYPE --firewall Web --datacenter nbg1-dc3 --ssh-key $HCLOUD_SSH_KEY




#hcloud context create my-hcloud-context --token $1

