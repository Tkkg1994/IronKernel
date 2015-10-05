#!/bin/bash
{
	make mrproper
	make IronKernel_T800_defconfig
        make -j5
}
