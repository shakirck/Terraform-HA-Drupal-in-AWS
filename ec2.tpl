#!/bin/bash
sudo apt-get update
sudo apt-get -y install git binutils 
sudo git clone https://github.com/aws/efs-utils
cd efs-utils
./build-deb.sh
sudo apt-get -y install ./build/amazon-efs-utils*deb
cd ..
sudo mkdir efs
sudo mount -t efs -o tls ${fsid}:/ efs

# aws efs describe-mount-targets --file-system-id fs-082c344f63dcd177b --region us-east-1
# |jq -r '.[]|.[]|select(.AvailailityZoneName|contains("us-east-1a"))'
# 

#   EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
#   EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed 's/[a-z]$//'`"
