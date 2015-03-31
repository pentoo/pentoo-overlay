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
RDEPEND="!livecd? ( >=x11-drivers/ati-drivers-10.1 )
	app-eselect/eselect-opencl
	examples? ( media-libs/glew )"
#	!x11-drivers/nvidia-drivers"

src_install() {
	local DEST=/opt/ati-stream-sdk
	insinto ${DEST}
	
	cd ati-stream-sdk-v${PV}-lnx64 || die

	# Install executables
	insopts -m0755
	doins -r bin

	# Install libraries

	doins -r lib

	# There should be something like eselect opencl, to switch
	# between OpenCL implementations  	
	if use amd64; then
# Managed by eselect opencl
#		dosym ../..${DEST}/lib/x86_64/libOpenCL.so   /usr/lib64/
#		dosym ../..${DEST}/lib/x86/libOpenCL.so      /usr/lib32/
		dosym ../..${DEST}/lib/x86_64/libatiocl64.so /usr/lib64/
		dosym ../..${DEST}/lib/x86/libatiocl32.so    /usr/lib32/
	else
# Managed by eselect opencl
#		dosym ../..${DEST}/lib/x86/libOpenCL.so    /usr/lib/
		dosym ../..${DEST}/lib/x86/libatiocl32.so  /usr/lib/
	fi
    
	# Install includes
	# only selected header; not  glew
	insinto ${DEST}/include
	insopts -m0644
	doins  include/cal*.h
	doins -r include/CL
	doins -r include/GL
    
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
