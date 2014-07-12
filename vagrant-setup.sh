#!/bin/bash
sudo apt-get update
sudo apt-get install -y build-essential gcc binutils bzip2 flex python perl \
  unzip gawk zlib1g-dev libc6-dev ncurses-dev subversion git diff npm gettext
# Have to copy the files into the VM's hard drive, because building cerowrt requires
# hardlinks which are not supported under /vagrant.
rsync -au /vagrant/ ~/OpenWireless/
cd ~/OpenWireless/
./sendToBuild
cp ./OWrt/config-OWrt-qemu cerowrt/.config

# Additional setup (interactive):
# cd ~/OpenWireless/cerowrt
# make menuconfig
#  Advanced configuration options (for developers) -- hit space, then enter
#    Toolchain options -- hit space, then enter
#      GCC Compiler version -- hit enter
#         gcc 4.6.x with Linaro enhancements
#         (exit back to top level)
# Target System
#   MIPS Malta CoreLV board (qemu)
#
# Subtarget
#   Big endian -- the ar71xxx platform that the actual builds are based off are
#                 big endian, so for binary compatibility we need this.
# (exit and save config)
#
# make V=s

