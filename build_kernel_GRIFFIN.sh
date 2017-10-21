#!/bin/sh
export KERNELDIR=`pwd`
export CROSS_COMPILE="aarch64-linux-androidkernel-"
export ARCH=arm64

if [ ! -f $KERNELDIR/.config ];
then
	make defconfig TurboZ_CustomRom_7.1.1_defconfig
fi

. $KERNELDIR/.config

cd $KERNELDIR/
make -j10 || exit 1

mkdir -p $KERNELDIR/BUILT_GRIFFIN/

rm $KERNELDIR/BUILT_GRIFFIN/modules/qca_cld/*
rm -R $KERNELDIR/BUILT_GRIFFIN/modules/qca_cld
rm $KERNELDIR/BUILT_GRIFFIN/modules/*
rm -R $KERNELDIR/BUILT_GRIFFIN/modules
rm $KERNELDIR/BUILT_GRIFFIN/zImage

if [ ! -f $KERNELDIR/arch/arm64/boot/zImage ];
then
	cp $KERNELDIR/arch/arm64/boot/Image.gz-dtb $KERNELDIR/BUILT_GRIFFIN/zImage
else
	cp $KERNELDIR/arch/arm64/boot/zImage $KERNELDIR/BUILT_GRIFFIN/zImage
fi
