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
  --pxe-service=http://ec2-18-219-205-208.us-east-2.compute.amazonaws.com/rancheros.ipxe \
  --log-queries \
  --log-dhcp



# inspect the vendor class string and match the text to set the tag
dhcp-vendorclass=BIOS,PXEClient:Arch:00000
dhcp-vendorclass=UEFI32,PXEClient:Arch:00006
dhcp-vendorclass=
dhcp-vendorclass=

# Set the boot file name based on the matching tag from the vendor class (above)
dhcp-boot=net:UEFI32,i386-efi/,,192.168.1.5
dhcp-boot=net:UEFI,ipxe.efi,,192.168.1.5
dhcp-boot=net:UEFI64,ipxe.efi,,192.168.1.5

# PXE menu. The first part is the text displayed to the user. The second is the timeout, in seconds.
# pxe-prompt="Booting FOG Client", 1

# The known types are x86PC, PC98, IA64_EFI, Alpha, Arc_x86,
# Intel_Lean_Client, IA32_EFI, BC_EFI, Xscale_EFI and X86-64_EFI
# This option is first and will be the default if there is no input from the user.
pxe-service=X86PC, "Boot to FOG", undionly.kpxe
pxe-service=X86-64_EFI, "Boot to FOG UEFI", ipxe.efi
pxe-service=BC_EFI, "Boot to FOG UEFI PXE-BC", ipxe.efi
