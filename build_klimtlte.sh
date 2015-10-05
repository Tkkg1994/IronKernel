#!/bin/bash
{
	make mrproper
	make IronKernel_T705_defconfig
        make -j5
}
