#!/bin/bash
sudo apt-get install -y docker.io
sudo wget https://github.com/kachind/dnsmasq/raw/master/undionly.pxe -O /var/lib/tftpboot/undionly.pxe
sudo docker run -v /var/lib/tftpboot:/var/lib/tftpboot \
--rm --cap-add=NET_ADMIN --net=host quay.io/coreos/dnsmasq \
  -d -q \
  --dhcp-range=192.168.1.1,proxy,255.255.0.0 \
  --enable-tftp --tftp-root=/var/lib/tftpboot \
  --dhcp-userclass=set:ipxe,iPXE \
  --pxe-service=tag:#ipxe,x86PC,"PXE chainload to iPXE",intel.kpxe \
  --address=/ec2-18-219-205-208.us-east-2.compute.amazonaws.com/18.219.205.208 \
  --pxe-service=tag:ipxe,x86PC,"iPXE",http://ec2-18-219-205-208.us-east-2.compute.amazonaws.com/rancheros.ipxe \
  --log-queries \
  --log-dhcp
