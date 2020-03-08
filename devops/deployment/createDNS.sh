#!/bin/bash

tag=$1

external_ip=""

while [ -z $external_ip ];
do
    sleep 10
    external_ip=$(kubectl get svc $tag --template="{{range.status.loadBalancer.ingress}}{{.ip}}{{end}}")
    echo $(kubectl get svc)
    echo "La ip es:"$external_ip

done

# Public IP address of your ingress controller
IP=$external_ip

# Name to associate with public IP address
DNSNAME=$tag

# Get the resource-id of the public ip
PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv)

# Update public ip address with DNS name
az network public-ip update --ids $PUBLICIPID --dns-name $DNSNAME
