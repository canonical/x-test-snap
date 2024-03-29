#! /bin/bash

if [ "$1" == "build" ]
then
    snapcraft --destructive-mode --target-arch=arm64 --enable-experimental-target-arch

elif [ "$1" == "clean" ]
then
    rm -f *.snap
    snapcraft clean --destructive-mode
fi
