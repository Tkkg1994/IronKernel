#!/bin/bash
{
	make mrproper
	make IronKernel_T700_defconfig
        make -j5
}
