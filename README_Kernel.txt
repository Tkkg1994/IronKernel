################################################################################

1. How to Build
	- get Toolchain
		From android git server , codesourcery and etc ..
		 - arm-eabi-4.6
		
	- edit Makefile
		edit "CROSS_COMPILE" to right toolchain path(You downloaded).
		  EX)  CROSS_COMPILE= $(android platform directory you download)/android/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-
          Ex)  CROSS_COMPILE=/usr/local/toolchain/arm-eabi-4.6/bin/arm-eabi-          // check the location of toolchain
	
	$ make ARCH=arm chagallwifi_00_defconfig
	$ make ARCH=arm
	
2. Output files
	- Kernel : Kernel/arch/arm/boot/zImage
	- module : Kernel/drivers/*/*.ko
	
3. How to Clean	
    $ make clean
	
4. How to make .tar binary for downloading into target.
	- change current directory to Kernel/arch/arm/boot
	- type following command
	$ tar cvf SM-T805_EUR_MM_XX.tar zImage
#################################################################################