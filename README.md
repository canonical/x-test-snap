# A X-Test Snap for Arm64/hf

This snap currently supports ubuntu-core 20/22 with optee 3.14 to 3.22 with arm64. We are still working on armhf.

## Build

You can simply run ./run.sh build to build the snap, but you need to prepare the relevant build environment, such as arm64 Debian source. The script below can help you do that, but use it at your own risk.

```no-highlight
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
```

## Clean

You can simply run ./run.sh clean

## How to use

```no-highlight
# Install x-test snap
$ sudo snap install x-test --channel=<UBUNTU-CORE-VER>/stable
# Choose x-test version
$ sudo snap connect x-test:xtest x-test:xtest-<314~322>
# Run x-test
$ sudo snap start x-test.tee-supplicant
$ sudo x-test.xtest

# Note: please disconnect the existing connection when connecting to a new x-test version
$ sudo snap disconnect x-test:xtest
```

## Command

- x-test.xtest:  
  run xtest
- x-test.tee-supplicant:  
  run tee-supplicant (in case your system not support tee-supplicant)
- x-test.sign-ta:  
  local sign TAs, please read the help
- x-test.unsign-ta:  
  restore unsign TAs
- x-test.import:  
  import your own TAs, please connect x-test first before you import your TAs.  
  command example: x-test.import <your TAs folder/TA>  
  If you would like to restore default TAs, please disconnect and then re-connect x-test:xtest.
