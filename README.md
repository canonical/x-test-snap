This snap currently support ubuntu-core 20/22 with optee 3.14 to 3.22 with arm64
We are still working on armhf.

Build:
    you can simply run ./run.sh build to build the snap, but you need to prepare relevant build environment like 
    amr64 debian source. The script below can help you to do that. but use it as your own risk

    ========================================
    CROSS_ARCH=arm64
    if [ "$(dpkg --print-foreign-architectures | grep -c $CROSS_ARCH)" -ne 1 ] ; then
        sudo dpkg --add-architecture $CROSS_ARCH
        sudo sed -i 's/^deb \(.*\)/deb [arch=amd64] \1/g' /etc/apt/sources.list
    for f in $(ls /etc/apt/sources.list.d/*.list); do
        sudo sed -i 's/^deb \(.*\)/deb [arch=amd64] \1/g' \$f
    done
    for f in $(ls /etc/apt/sources.list.d/*.sources); do
        echo "Architectures: amd64" | sudo tee -a \$f
    done
    fi

    SERIES=focal
    cat << EOF2 | sudo tee /etc/apt/sources.list.d/ports.list
    deb [arch=$CROSS_ARCH] http://ports.ubuntu.com/ubuntu-ports $SERIES main restricted universe multiverse
    deb [arch=$CROSS_ARCH] http://ports.ubuntu.com/ubuntu-ports $SERIES-updates main restricted universe multiverse
    deb [arch=$CROSS_ARCH] http://ports.ubuntu.com/ubuntu-ports $SERIES-backports main restricted universe multiverse
    deb [arch=$CROSS_ARCH] http://ports.ubuntu.com/ubuntu-ports $SERIES-security main restricted universe multiverse
    EOF2

    sudo apt-get update
    ======================================

Clean:
    you can simply run ./run.sh clean
