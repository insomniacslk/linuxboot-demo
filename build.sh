#!/bin/bash -exu

rm -f /tmp/initramfs.linux_amd64.cpio
rm -f /tmp/initramfs.linux_amd64.cpio.xz
u-root \
    -build=bb \
    -files /usr/bin/strace \
    core \
    github.com/systemboot/systemboot/{uinit,localboot,netboot}

xz --check=crc32 --lzma2=dict=512KiB /tmp/initramfs.linux_amd64.cpio

KERNEL_VER=4.19.6
#KERNEL_VER=4.14.96
cd "linux-${KERNEL_VER}"
make -j$(nproc)
cd ../coreboot/
make
# RW_VPD
vpd -f build/coreboot.rom -i RW_VPD -O
vpd -f build/coreboot.rom -i RW_VPD -s 'LinuxBoot=IsCool'
# RO_VPD
vpd -f build/coreboot.rom -i RO_VPD -O
vpd -f build/coreboot.rom -i RO_VPD -s 'Boot0000={"type":"netboot","method":"dhcpv6"}'
vpd -f build/coreboot.rom -i RO_VPD -g Boot0000
cd ..

echo 'Image built under coreboot/build/coreboot.rom'
