

IP_ADDRESS=$(aws ec2 describe-instances --filter "Name=tag-value,Values=MyInstance" | jq -r '.Reservations[0].Instances[0].PublicIpAddress')
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i adam.pem ubuntu@$IP_ADDRESS /bin/bash << EOF
    echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee -a /etc/apt/sources.list.d/docker.list;
    sudo apt-get update;
    sudo apt-get install docker-engine -y --force-yes;
    sudo docker run -d -p 80:4567 stujfiter/sparky;
EOF
