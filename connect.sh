#! /bin/bash


IP_ADDRESS=$(aws ec2 describe-instances --filter "Name=tag-value,Values=MyInstance" | jq -r '.Reservations[0].Instances[0].PublicIpAddress')
ssh -i adam.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ubuntu@$IP_ADDRESS
