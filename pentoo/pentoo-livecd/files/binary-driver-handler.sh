#!/bin/sh
#seriously, fuck you AMD and Nvidia. Write a sane license that permits redistribution, we just want your shitty hardware to work

handle_nvidia(){
	emerge -1 nvidia-drivers
	modprobe nvidia
	nvidia-xconfig
	#eselect opengl set nvidia
	eselect opencl set nvidia
}

handle_amd(){
	emerge -1 ati-drivers
	modprobe fglrx
	aticonfig --initial
	#eselect opengl set ati
	eselect opencl set amd
}

if $(lspci | grep VGA | grep -iq NVIDIA); then
	handle_nvidia
elif $(lspci | grep VGA | grep -ir Radeon); then
	handle_amd
fi

eselect opengl set xorg-x11
