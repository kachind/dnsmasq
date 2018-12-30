sudo docker run --rm --cap-add=NET_ADMIN --net=host quay.io/coreos/dnsmasq \
  -d -q \
  --dhcp-range=192.168.1.1,192.168.255.255 \
  --enable-tftp --tftp-root=/var/lib/tftpboot \
  --dhcp-match=set:bios,option:client-arch,0 \
  --dhcp-boot=tag:bios,undionly.kpxe \
  --dhcp-match=set:efi32,option:client-arch,6 \
  --dhcp-boot=tag:efi32,ipxe.efi \
  --dhcp-match=set:efibc,option:client-arch,7 \
  --dhcp-boot=tag:efibc,ipxe.efi \
  --dhcp-match=set:efi64,option:client-arch,9 \
  --dhcp-boot=tag:efi64,ipxe.efi \
  --dhcp-userclass=set:ipxe,iPXE \
  --pxe-service=x86PC,http://ec2-18-219-205-208.us-east-2.compute.amazonaws.com/rancheros.ipxe \
  --address=/ec2-18-219-205-208.us-east-2.compute.amazonaws.com/18.219.205.208 \
#  --log-queries \
  --log-dhcp
