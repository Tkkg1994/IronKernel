#!/bin/bash
{
	make mrproper
	make IronKernel_T805_defconfig
        make -j5
}
