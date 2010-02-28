# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
DESCRIPTION="Enable compiling code and loading it on ATI/AMD GPU"
HOMEPAGE="http://ati.amd.com/technology/streamcomputing/sdkdwnld.htm"
SRC_URI="http://download2-developer.amd.com/amd/Stream20GA/${PN/-bin/}-v${PV}-lnx64.tgz"

LICENSE="AMD GPL-1 as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="livecd examples doc"
RESTRICT="strip fetch"
RDEPEND=" !livecd? ( >=x11-drivers/ati-drivers-9.11 ) \
           examples? ( media-libs/glew )"

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
		dosym ${DEST}/lib/x86_64/libOpenCL.so /usr/lib64/
		dosym ${DEST}/lib/x86/libOpenCL.so /usr/lib32/
	else
		dosym ${DEST}/lib/x86/libOpenCL.so /usr/lib/    
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
	fi

	if use doc; then
		insinto ${DEST}
		doins -r docs
	fi

	# install OpenCL installable client driver
	# What should we do with the absolute symlink?
	dodir   /usr/lib/OpenCL/vendors

	dosym ${DEST}/lib/x86/libatiocl32.so    /usr/lib/OpenCL/vendors
	if use amd64; then
		dosym ${DEST}/lib/x86_64/libatiocl64.so /usr/lib/OpenCL/vendors
	fi

}
