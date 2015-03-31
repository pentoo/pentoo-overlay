# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
DESCRIPTION="Enable compiling code and loading it on ATI/AMD GPU"
HOMEPAGE="http://ati.amd.com/technology/streamcomputing/sdkdwnld.htm"
SRC_URI="http://download2-developer.amd.com/amd/Stream20GA/ati-stream-sdk-v${PV}-lnx64.tgz"

LICENSE="AMD GPL-1 as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="livecd examples doc"
RESTRICT="strip"
RDEPEND="!livecd? ( >=x11-drivers/ati-drivers-10.11 )
	app-eselect/eselect-opencl
	examples? ( media-libs/glew )"

QA_EXECSTACK="
	opt/ati-stream-sdk/lib/x86/libatiocl32.so
	opt/ati-stream-sdk/lib/x86_64/libatiocl64.so
"

src_install() {
	local DEST=/opt/ati-stream-sdk
	insinto ${DEST}
	
	cd ati-stream-sdk-v${PV}-lnx64 || die

	if use amd64; then
		if use multilib; then
			dosym ../..${DEST}/lib/x86/libatiocl32.so    /usr/lib32/
		else
			rm -rf bin/x86 lib/x86
		fi
		dosym ../..${DEST}/lib/x86_64/libatiocl64.so /usr/lib64/
	else
		dosym ../..${DEST}/lib/x86/libatiocl32.so  /usr/lib/
		rm -rf bin/x86_64 lib/x86_64
	fi

	# Install executables
	insopts -m0755
	doins -r bin
	# Install libraries
	doins -r lib

    
	# Install includes
	# only selected header; not  glew
	insinto ${DEST}/include
	insopts -m0644
	doins -r include/*
    
	# Install examples & docs
	if use examples; then
		insinto ${DEST}
		doins -r samples
		doins -r make
	fi

	if use doc; then
		insinto ${DEST}
		doins -r docs
	fi

	# install OpenCL installable client driver
	# What should we do with the absolute symlink?
	dodir   /etc/OpenCL/vendors
	if use amd64; then
		echo "libatiocl64.so" > ${D}/etc/OpenCL/vendors/atiocl64.icd
	fi
	echo "libatiocl32.so" > ${D}/etc/OpenCL/vendors/atiocl32.icd

	# Create env file
	echo "ATISTREAMSDKROOT=${DEST}" > 99${PN}
	doenvd 99${PN}

}
