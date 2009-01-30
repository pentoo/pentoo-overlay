# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Enable compiling code and loading it on ATI/AMD GPU"
HOMEPAGE="http://ati.amd.com/technology/streamcomputing/sdkdwnld.htm"
SRC_URI="amd64? ( http://www2.ati.com/sdkdwnld/amdstream-${PV}-lnx64.tar.gzip ) 
         x86? ( http://www2.ati.com/sdkdwnld/amdstream-${PV}-lnx32.tar.gzip )"
LICENSE="AMD GPL-1 as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=">=x11-drivers/ati-drivers-8.561"

src_unpack() {
	tar -zxf ${A}
	cd ${WORKDIR}

	if use x86; then
		
		einfo "Unpacking AMD-Cal"
		dd if=${WORKDIR}/amdstream-cal-${PV}.i386.run of=${WORKDIR}/amdcal.tar.gz bs=1 skip=16384 >& /dev/null
		
		einfo "Unpacking AMD-Brook"
		dd if=${WORKDIR}/amdstream-brook-${PV}.i386.run of=${WORKDIR}/amdbrook.tar.gz bs=1 skip=16384 >& /dev/null
	
	else
		
		einfo "Unpacking AMD-Cal"
		dd if=${WORKDIR}/amdstream-cal-${PV}.x86_64.run of=${WORKDIR}/amdcal.tar.gz bs=1 skip=16384 >& /dev/null

		einfo "Unpacking AMD-Brook"
		dd if=${WORKDIR}/amdstream-brook-${PV}.x86_64.run of=${WORKDIR}/amdbrook.tar.gz bs=1 skip=16384 >& /dev/null
	
	fi

	einfo "Converting rpm to tar"
	mkdir AMD-Cal
	tar xvf amdcal.tar.gz -C AMD-Cal >& /dev/null
	mkdir AMD-Brook
	tar xvf amdbrook.tar.gz -C AMD-Brook >& /dev/null
	
	cd ${WORKDIR}/AMD-Cal
	rpm2tar amdstream-cal-${PV}-1.*.rpm
	cd ${WORKDIR}/AMD-Brook
	rpm2tar amdstream-brook-${PV}-1.*.rpm
}

src_install() {
	einfo "Installing AMD-Cal"
	tar xvf ${WORKDIR}/AMD-Cal/amdstream-cal-${PV}-1.*.tar -C ${D}/
	einfo "Installing AMD-Brook"
	tar xvf ${WORKDIR}/AMD-Brook/amdstream-brook-${PV}-1.*.tar -C ${D}/
	newenvd "${FILESDIR}/99amdstream" 99amdstream || die "Failed to install env file."
}
