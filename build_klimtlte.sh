#!/bin/bash
{
	make mrproper
	make klimtlte_00_defconfig
        make -j5
}
