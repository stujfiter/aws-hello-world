#! /bin/bash

aws ec2 create-key-pair --key-name adam | jq -r '.KeyMaterial' > adam.pem
chmod 600 adam.pem
aws ec2 create-security-group --group-name my-sg --description "My Security Group"
aws ec2 authorize-security-group-ingress --group-name my-sg --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name my-sg --protocol tcp --port 80 --cidr 0.0.0.0/0
INSTANCE_ID=$(aws ec2 run-instances --image-id ami-d732f0b7 --key-name adam --instance-type t2.micro --security-groups my-sg | jq -r '.Instances[0].InstanceId')

aws ec2 create-tags --resources $INSTANCE_ID --tags Key=Name,Value=MyInstance

aws ec2 describe-instances --filters "Name=tag-value,Values=MyInstance" | jq -r '.Reservations[0].Instances[0].PublicIpAddress'
