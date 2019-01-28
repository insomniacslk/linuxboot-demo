#!/bin/bash -exu
if [ $UID -ne 0 ]
then
    sudo $0 $@
    exit $?
fi

ip link set tap0 up
ip addr add 2001:db8:1::/64 dev tap0
#ip addr add 2001:db8:0:1::1/64 dev tap0
ip6tables -P INPUT ACCEPT

