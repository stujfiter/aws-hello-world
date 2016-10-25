#! /bin/bash

aws ec2 describe-instances --filter "Name=tag-value,Values=MyInstance" | jq -r '.Reservations[0].Instances[0].PublicIpAddress'
aws ec2 describe-instances --filter "Name=tag-value,Values=MyInstance" | jq -r '.Reservations[0].Instances[0].State.Name'
