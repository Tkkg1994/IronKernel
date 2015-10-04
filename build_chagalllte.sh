#!/bin/bash
{
	make mrproper
	make chagalllte_00_defconfig
        make -j5
}
