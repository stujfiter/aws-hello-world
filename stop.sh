#! /bin/bash

INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag-value,Values=MyInstance" | jq -r ".Reservations[0].Instances[0].InstanceId")

STATE=$(aws ec2 describe-instances --instance-id $INSTANCE_ID | jq -r '.Reservations[0].Instances[0].State.Name')

if [ "$STATE" = "running" ]; then
    aws ec2 terminate-instances --instance-id $INSTANCE_ID
    until [ "$STATE" = "terminated" ]; do
        STATE=$(aws ec2 describe-instances --instance-id $INSTANCE_ID | jq -r '.Reservations[0].Instances[0].State.Name')
    done
else
    echo "$INSTANCE_ID: $STATE.  Instance must be in running state to terminate"
fi

aws ec2 delete-tags --resources $INSTANCE_ID
aws ec2 delete-security-group --group-name my-sg
aws ec2 delete-key-pair --key-name adam
rm adam.pem
