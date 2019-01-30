#!/bin/bash -exu

get_coreboot() {
    git clone https://review.coreboot.org/coreboot.git
    cp coreboot-config coreboot/.config
    (
        cd coreboot
        git checkout tags/4.9
    )
}

KERNEL_VER=4.19.6
#KERNEL_VER=4.14.96

get_kernel() {
    wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-${KERNEL_VER}.tar.xz
    tar xvJf linux-${KERNEL_VER}.tar.xz
    cp linux-config linux-${KERNEL_VER}/.config
}


#get_coreboot
get_kernel
