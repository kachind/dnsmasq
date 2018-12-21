#!/bin/bash
sudo apt-get install -y docker.io
sudo docker run --rm --cap-add=NET_ADMIN --net=host quay.io/coreos/dnsmasq \
  -d -q \
  --dhcp-range=192.168.1.1,proxy,255.255.0.0 \
  --enable-tftp --tftp-root=/var/lib/tftpboot \
  --dhcp-userclass=set:ipxe,iPXE \
  --pxe-service=tag:#ipxe,x86PC,"PXE chainload to iPXE",undionly.kpxe \
  --pxe-service=tag:ipxe,x86PC,"iPXE",http://ec2-18-219-205-208.us-east-2.compute.amazonaws.com/rancheros.ipxe \
  --log-queries \
  --log-dhcp
