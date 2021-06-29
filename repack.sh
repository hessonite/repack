#!/bin/bash

temp_og="$1"

if [ -n "$2" ]
then
	temp_out="$2"
else
	temp_out="windows_11.iso"
fi

# Create directories needed
[ ! -d iso ] && mkdir -p iso/tools
[ ! -d mnt ] && mkdir mnt

# Mount and copy iso
sudo mount -o loop $temp_og mnt/
cp -r mnt/* iso/
chmod -R 755 iso

# Copies patch
cp appraiserres.dll iso/sources/

# Create repacked iso
genisoimage -b boot/etfsboot.com -no-emul-boot -boot-load-size 8 -iso-level 3 -udf -joliet -D -N -relaxed-filenames -o $temp_out -V win_10_pro_x64_vl -allow-limited-size iso

# Cleanup
sudo umount mnt
sudo rm -rf iso mnt og
