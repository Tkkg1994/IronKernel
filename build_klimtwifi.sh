#!/bin/bash
{
	make mrproper
	make klimtwifi_00_defconfig
        make -j5
}
