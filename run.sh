#!/bin/bash -exu
if [ $UID -ne 0 ]
then
    sudo $0 $@
    exit $?
fi

HELPER=/usr/lib/qemu/qemu-bridge-helper
qemu-system-x86_64 \
    -s -S \
    -M q35 \
    -bios coreboot/build/coreboot.rom \
    -m 1024 \
    -enable-kvm \
    -nographic \
    -hda disk.img \
    -net bridge,br=virbr1 \
    -net nic -net bridge,br=virbr1 \
    $@
