#!/bin/bash
{
	make mrproper
	make chagallwifi_00_defconfig
        make -j5
}
