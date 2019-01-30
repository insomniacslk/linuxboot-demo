#!/bin/bash -exu
if [ $UID -ne 0 ]
then
    sudo $0 $@
    exit $?
fi

HELPER=/usr/lib/qemu/qemu-bridge-helper
    #-s -S \
qemu-system-x86_64 \
    -M q35 \
    -bios coreboot/build/coreboot.rom \
    -m 1024 \
    -enable-kvm \
    -nographic \
    -hda disk.img \
    -net bridge,br=virbr1 \
    -net nic -net bridge,br=virbr1 \
    -object rng-random,filename=/dev/urandom,id=rng0 \
    -device virtio-rng-pci,rng=rng0 \
    $@
