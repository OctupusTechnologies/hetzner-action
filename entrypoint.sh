#!/bin/sh -l
# hcloud context create my-hcloud-context --token $HCLOUD_TOKEN
SEVER_TYPE=$1
SERVER_NAME=$2
HCLOUD_TOKEN=$3
HCLOUD_SSH_KEY=$4
HCLOUD_DNS_ZONE=$5
HCLOUD_FIREWALL=$6
HETZNER_DNS_TOKEN=$7
HETZNER_DATACENTER=$8




echo "Set ENV VAR HCLOUD_TOKEN"
export HCLOUD_TOKEN=$HCLOUD_TOKEN

hcloud server list | grep $SERVER_NAME
while [ $? -eq 0 ] ; do
  echo "Server $SERVER_NAME already exists"
  SERVER_NAME=$SERVER_NAME-$(date +%s)
  echo "Try to create server $SERVER_NAME"
  hcloud server list | grep $SERVER_NAME
done

backup_id=$(hcloud image list | grep 'backup' | awk '{print $1}' | tail -n 1)
echo "LAST Backup ID: $backup_id"


echo "Create server $SERVER_NAME"
echo "SERVER_NAME=$SERVER_NAME" >> $GITHUB_OUTPUT



# if cloud-config.yaml exists
if [ -f "cloud-config.yaml" ]; then
  sudo chmod a+r cloud-config.yaml
  echo "Create server with cloud-config"
  output=$(hcloud server create --image $backup_id --name $SERVER_NAME --type $SEVER_TYPE --firewall $HCLOUD_FIREWALL --datacenter $HETZNER_DATACENTER --ssh-key $HCLOUD_SSH_KEY --user-data-from-file cloud-config.yaml --without-ipv6  )
else
  echo "Create server without cloud-config"
  output=$(hcloud server create --image $backup_id --name $SERVER_NAME --type $SEVER_TYPE --firewall $HCLOUD_FIREWALL --datacenter $HETZNER_DATACENTER --ssh-key $HCLOUD_SSH_KEY --without-ipv6 )
fi
echo $output

SERVER_IPV4=$(echo "$output" | awk '/IPv4:/ {print $2}')
echo "Server IPv4: $SERVER_IPV4"
echo "SERVER_IPV4=$SERVER_IPV4" >> $GITHUB_OUTPUT
echo "Create DNS entry for $SERVER_NAME"
# Create Record
# Creates a new record DNS.

#TODO Type DNS A or AAAA
curl -X "POST" "https://dns.hetzner.com/api/v1/records" \
     -H 'Content-Type: application/json' \
     -H "Auth-API-Token: $HETZNER_DNS_TOKEN" \
     -d '{
        "value": "'"$SERVER_IPV4"'",
        "ttl": 86400,
        "type": "A",
        "name": "'"$SERVER_NAME"'",
        "zone_id": "'"$HCLOUD_DNS_ZONE"'"
     }'



#hcloud context create my-hcloud-context --token $1
