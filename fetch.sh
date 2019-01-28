#!/bin/bash -exu

git clone https://review.coreboot.org/coreboot.git
cp coreboot-config coreboot/.config

wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.19.6.tar.xz
tar xvJf linux-4.19.6.tar.xz
cp linux-config linux-4.19.6/.config

