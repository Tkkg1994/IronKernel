#!/bin/bash
# kernel build script by Tkkg1994 v0.6 (optimized from apq8084 kernel source)

export MODEL=chagalllte
export ARCH=arm
export BUILD_CROSS_COMPILE=../Toolchain/Toolchain_5.3/bin/arm-cortex-linux-gnueabi-
export BUILD_JOB_NUMBER=`grep processor /proc/cpuinfo|wc -l`

RDIR=$(pwd)
OUTDIR=$RDIR/arch/$ARCH/boot
DTSDIR=$RDIR/arch/$ARCH/boot/dts
INCDIR=$RDIR/include

if [ $MODEL = chagalllte ]
then
	KERNEL_DEFCONFIG=ironkernel_chagalllte_defconfig
else if [ $MODEL = chagallwifi ]
then
	KERNEL_DEFCONFIG=ironkernel_chagallwifi_defconfig
else if [ $MODEL = klimtlte ]
then
	KERNEL_DEFCONFIG=ironkernel_klimtlte_defconfig
else [ $MODEL = klimtwifi ]
	KERNEL_DEFCONFIG=ironkernel_klimtwifi_defconfig
fi
fi
fi

FUNC_CLEAN_DTB()
{
	if ! [ -d $RDIR/arch/$ARCH/boot/dts ] ; then
		echo "no directory : "$RDIR/arch/$ARCH/boot/dts""
	else
		echo "rm files in : "$RDIR/arch/$ARCH/boot/dts/*.dtb""
		rm $RDIR/arch/$ARCH/boot/dts/*.dtb
		rm $RDIR/arch/$ARCH/boot/dtb/*.dtb
		rm $RDIR/arch/$ARCH/boot/boot.img-dtb
		rm $RDIR/arch/$ARCH/boot/boot.img-zImage
	fi
}

FUNC_BUILD_KERNEL()
{
	echo ""
        echo "=============================================="
        echo "START : FUNC_BUILD_KERNEL"
        echo "=============================================="
        echo ""
        echo "build common config="$KERNEL_DEFCONFIG ""
        echo "build variant config="$MODEL ""

	FUNC_CLEAN_DTB

	make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE \
			$KERNEL_DEFCONFIG || exit -1

	make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE || exit -1
	
	echo ""
	echo "================================="
	echo "END   : FUNC_BUILD_KERNEL"
	echo "================================="
	echo ""
}

FUNC_BUILD_RAMDISK()
{
	mv $RDIR/arch/$ARCH/boot/Image $RDIR/arch/$ARCH/boot/boot.img-zImage
	mv $RDIR/arch/$ARCH/boot/dtb.img $RDIR/arch/$ARCH/boot/boot.img-dtb

	case $MODEL in
	gracelte)
		rm -f $RDIR/ramdisk/SM-N930F/split_img/boot.img-zImage
		rm -f $RDIR/ramdisk/SM-N930F/split_img/boot.img-dtb
		mv -f $RDIR/arch/$ARCH/boot/boot.img-zImage $RDIR/ramdisk/SM-N930F/split_img/boot.img-zImage
		mv -f $RDIR/arch/$ARCH/boot/boot.img-dtb $RDIR/ramdisk/SM-N930F/split_img/boot.img-dtb
		cd $RDIR/ramdisk/SM-N930F
		./repackimg.sh
		echo SEANDROIDENFORCE >> image-new.img
		;;
	herolte)
		rm -f $RDIR/ramdisk/SM-G930F/split_img/boot.img-zImage
		rm -f $RDIR/ramdisk/SM-G930F/split_img/boot.img-dtb
		mv -f $RDIR/arch/$ARCH/boot/boot.img-zImage $RDIR/ramdisk/SM-G930F/split_img/boot.img-zImage
		mv -f $RDIR/arch/$ARCH/boot/boot.img-dtb $RDIR/ramdisk/SM-G930F/split_img/boot.img-dtb
		cd $RDIR/ramdisk/SM-G930F
		./repackimg.sh
		echo SEANDROIDENFORCE >> image-new.img
		;;
	hero2lte)
		rm -f $RDIR/ramdisk/SM-G935F/split_img/boot.img-zImage
		rm -f $RDIR/ramdisk/SM-G935F/split_img/boot.img-dtb
		mv -f $RDIR/arch/$ARCH/boot/boot.img-zImage $RDIR/ramdisk/SM-G935F/split_img/boot.img-zImage
		mv -f $RDIR/arch/$ARCH/boot/boot.img-dtb $RDIR/ramdisk/SM-G935F/split_img/boot.img-dtb
		cd $RDIR/ramdisk/SM-G935F
		./repackimg.sh
		echo SEANDROIDENFORCE >> image-new.img
		;;
	*)
		echo "Unknown device: $MODEL"
		exit 1
		;;
	esac
}

# MAIN FUNCTION
rm -rf ./build.log
(
    START_TIME=`date +%s`

	FUNC_BUILD_KERNEL
	FUNC_BUILD_RAMDISK

    END_TIME=`date +%s`
	
    let "ELAPSED_TIME=$END_TIME-$START_TIME"
    echo "Total compile time is $ELAPSED_TIME seconds"
) 2>&1	 | tee -a ./build.log
