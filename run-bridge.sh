#!/bin/bash -exu
IFACE=$1

if [ $UID -ne 0 ]
then
    sudo $0 $@
    exit $?
fi

echo "Bringing up $IFACE for bridged mode..."
ip link set "${IFACE}" up promisc on
echo "Adding $IFACE to br0..."
brctl addif br0 "${IFACE}"
sleep 2
