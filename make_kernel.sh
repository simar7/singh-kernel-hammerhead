#!/bin/bash

DEFCONFIG_FILE=$1
CROSS_COMPILE=$2
DEBUG=$3

if [ -z "$DEFCONFIG_FILE" ]; then
	echo "Need defconfig file(hammerhead_defconfig)!"
	exit -1
fi

if [ ! -e arch/arm/configs/$DEFCONFIG_FILE ]; then
	echo "No such file : arch/arm/configs/$DEFCONFIG_FILE"
	exit -1
fi

# make .config
env KCONFIG_NOTIMESTAMP=true \
make ARCH=arm CROSS_COMPILE=arm-eabi- ${DEFCONFIG_FILE}

if [ -n "$DEBUG" ]; then
	# run menuconfig for custom config
	env KCONFIG_NOTIMESTAMP=true \
	make menuconfig ARCH=arm
fi

make savedefconfig ARCH=arm

# copy .config to defconfig
mv defconfig arch/arm/configs/${DEFCONFIG_FILE}

# clean kernel object
make mrproper

# build kernel image
make -j16 hammerhead_defconfig ARCH=arm SUBARCH=arm CROSS_COMPILE=${CROSS_COMPILE}
make -j16 ARCH=arm SUBARCH=arm CROSS_COMPILE=${CROSS_COMPILE}

