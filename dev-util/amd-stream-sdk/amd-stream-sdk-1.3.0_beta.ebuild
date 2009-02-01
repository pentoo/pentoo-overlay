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
IUSE="doc examples"
RESTRICT="strip"
DEPEND="app-arch/rpm2targz"
RDEPEND=">=x11-drivers/ati-drivers-8.561"

src_unpack() {
	mkdir -p "${S}"
	tar -xzf "${DISTDIR}/${A}" -C "${WORKDIR}"
	if use x86; then
#		einfo "Unpacking AMD-Cal"
#		dd if="${WORKDIR}/amdstream-cal-${PV}.i386.run" of="${WORKDIR}/amdcal.tar.gz" bs=16384 skip=1 >& /dev/null
		einfo "Unpacking AMD-Brook"
		dd if="${WORKDIR}/amdstream-brook-${PV}.i386.run" of="${WORKDIR}/amdbrook.tar.gz" bs=16384 skip=1 >& /dev/null
	else
#		einfo "Unpacking AMD-Cal"
#		dd if="${WORKDIR}/amdstream-cal-${PV}.x86_64.run" of="${WORKDIR}/amdcal.tar.gz" bs=16384 skip=1 >& /dev/null
		einfo "Unpacking AMD-Brook"
		dd if="${WORKDIR}/amdstream-brook-${PV}.x86_64.run" of="${WORKDIR}/amdbrook.tar.gz" bs=16384 skip=1 >& /dev/null
	fi

	cd ${WORKDIR}
	einfo "Converting rpm to tar"
#	mkdir AMD-Cal
#	tar xf amdcal.tar.gz -C AMD-Cal >& /dev/null
	mkdir AMD-Brook
	tar xf amdbrook.tar.gz -C AMD-Brook >& /dev/null
	
#	cd "${WORKDIR}/AMD-Cal"
#	rpm2tar amdstream-cal-${PV}-1.*.rpm
	cd "${WORKDIR}/AMD-Brook"
	rpm2tar amdstream-brook-${PV}-1.*.rpm

#	einfo "Extracting AMD-Cal"
#	tar xf "${WORKDIR}"/AMD-Cal/amdstream-cal-${PV}-1.*.tar -C "${S}"
	einfo "Extracting AMD-Brook"
	tar xf "${WORKDIR}"/AMD-Brook/amdstream-brook-${PV}-1.*.tar -C "${S}"
}

src_install() {
	local DEST=/opt/amdbrook
	if use amd64 ; then
		MY_BASE_DIR="${BASE_DIR}_64a"
		ARCH_DIR="lnx64"
	else
		MY_BASE_DIR="${BASE_DIR}"
		ARCH_DIR="lnx32"
	fi

	# don't use lib32 or lib64 directories
	unset ABI

	into ${DEST}
	dobin usr/local/amdbrook/sdk/bin/*
	dolib usr/local/amdbrook/sdk/lib/*

	insinto ${DEST}/include
	doins -r usr/local/amdbrook/sdk/include/*

	insinto ${DEST}/utils
	doins -r usr/local/amdbrook/utils/*

	newenvd "${FILESDIR}/99amdstream" 99amdstream || die "Failed to install env file."
}
