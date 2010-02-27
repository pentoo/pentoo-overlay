#!/bin/bash

MY_BASE=$(basename $1)
if [ -f ${FILESDIR}/${PV}/${MY_BASE}.patch ];
then
	echo -n "Module Patcher: "
	patch -f -p1 ${1} < ${FILESDIR}/${PV}/${MY_BASE}.patch
fi
