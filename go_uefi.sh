#!/bin/bash
sudo apt-get install -y docker.io
sudo docker run --rm --cap-add=NET_ADMIN --net=host quay.io/coreos/dnsmasq \
  -d -q \
  --dhcp-range=192.168.1.1,proxy,255.255.0.0 \
  --enable-tftp --tftp-root=/var/lib/tftpboot \
  --dhcp-vendorclass=BIOS,PXEClient:Arch:00000 \
  --dhcp-vendorclass=UEFI32,PXEClient:Arch:00006 \
  --dhcp-vendorclass=UEFI,PXEClient:Arch:00007 \
  --dhcp-vendorclass=UEFI64,PXEClient:Arch:00009 \
  --dhcp-boot=net:BIOS,undionly.kpxe \
  --dhcp-boot=net:UEFI32,ipxe.efi \
  --dhcp-boot=net:UEFI,ipxe.efi \
  --dhcp-boot=net:UEFI64,ipxe.efi \
  --pxe-service=x86PC,http://ec2-18-219-205-208.us-east-2.compute.amazonaws.com/rancheros.ipxe \
  --log-queries \
  --log-dhcp
