#!/bin/bash
wget -O /tmp/dban.iso https://github.com/kachind/dban/raw/master/dban-2.3.0_i586.iso
sudo mount -o loop /tmp/dban.iso /mnt
sudo cp -a /mnt /var/lib/tftpboot
sudo mv /var/lib/tftpboot/mnt/* /var/lib/tftpboot
sudo rm -r /var/lib/tftpboot/mnt
sudo umount /mnt
cd /var/lib/tftpboot
sudo wget http://mirrors.tummy.com/pub/ftp.ubuntulinux.org/ubuntu/dists/precise/main/installer-i386/current/images/netboot/ubuntu-installer/i386/pxelinux.0
sudo mkdir /var/lib/tftpboot/pxelinux.cfg
sudo wget -O /var/lib/tftpboot/pxelinux.cfg/default https://raw.githubusercontent.com/kachind/dban/master/default
sudo chmod -R 755 /var/lib/tftpboot/

sleep 30

sudo apt-get install -y docker.io
sudo docker run -v /var/lib/tftpboot:/var/lib/tftpboot \
--rm --cap-add=NET_ADMIN --net=host quay.io/coreos/dnsmasq \
  -d -q \
  --dhcp-range=192.168.7.1,proxy,255.255.255.0 \
  --enable-tftp --tftp-root=/var/lib/tftpboot \
  --pxe-service=x86PC, "PXE-Linux", "pxelinux" \
  --log-queries \
  --log-dhcp
