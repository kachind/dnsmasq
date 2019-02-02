#!/bin/bash
wget -O /tmp/dban.iso https://downloads.sourceforge.net/project/dban/dban/dban-2.3.0/dban-2.3.0_i586.iso?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fdban%2Ffiles%2Fdban%2Fdban-2.3.0%2Fdban-2.3.0_i586.iso%2Fdownload%3Fuse_mirror%3Dphoenixnap&ts=1549130611
sudo mount -o loop /tmp/dban.iso /mnt
sudo cp /mnt/\* /var/lib/tftpboot
cd /var/lib/tftpboot
sudo wget http://mirrors.tummy.com/pub/ftp.ubuntulinux.org/ubuntu/dists/precise/main/installer-i386/current/images/netboot/ubuntu-installer/i386/pxelinux.0
sudo mkdir /var/lib/tftpboot/pxelinux.cfg
sudo nano /var/lib/tftpboot/pxelinux.cfg/default
--
DEFAULT autonuke

LABEL autonuke
KERNEL dban.bzi
APPEND nuke="dwipe --autonuke" silent
--

sudo chmod -R 755 /var/lib/tftpboot/

sudo apt-get install -y docker.io
sudo docker run -v /var/lib/tftpboot:/var/lib/tftpboot \
--rm --cap-add=NET_ADMIN --net=host quay.io/coreos/dnsmasq \
  -d -q \
  --dhcp-range=192.168.7.1,proxy,255.255.255.0 \
  --enable-tftp --tftp-root=/var/lib/tftpboot \
  --dhcp-userclass=set:ipxe,iPXE \
  --dhcp-boot=pxelinux.0 \
  --log-queries \
  --log-dhcp
