# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Enable compiling code and loading it on ATI/AMD GPU"
HOMEPAGE="http://ati.amd.com/technology/streamcomputing/sdkdwnld.htm"
BASE_URI="http://download-developer.amd.com/GPU/executables/atistream-${PV}"
SRC_URI="amd64? ( ${BASE_URI}-lnx64.tar.gzip ) 
         x86? ( ${BASE_URI}-lnx32.tar.gzip )"

LICENSE="AMD GPL-1 as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="livecd"
RESTRICT="strip"
DEPEND="app-arch/rpm2targz"
RDEPEND=" !livecd? ( >=x11-drivers/ati-drivers-8.561 )
	 !dev-util/amd-stream-sdk-bin"

src_unpack() {
	mkdir -p "${S}"
	tar -xzf "${DISTDIR}/${A}" -C "${WORKDIR}"
	if use x86; then
		MY_ARCH="i386"
	else
		MY_ARCH="x86_64"
	fi

	einfo "Unpacking ATI-Cal"
	dd if="${WORKDIR}/atistream-cal-${PV}.${MY_ARCH}.run" of="${WORKDIR}/atical.tar.gz" bs=16384 skip=1 >& /dev/null
	einfo "Unpacking ATI-Brook"
	dd if="${WORKDIR}/atistream-brook-${PV}.${MY_ARCH}.run" of="${WORKDIR}/atibrook.tar.gz" bs=16384 skip=1 >& /dev/null

	cd ${WORKDIR}
	einfo "Converting rpm to tar"
	mkdir ATI-Cal
	tar xf atical.tar.gz -C ATI-Cal >& /dev/null
	mkdir ATI-Brook
	tar xf atibrook.tar.gz -C ATI-Brook >& /dev/null
	
	cd "${WORKDIR}/ATI-Cal"
	rpm2tar atistream-cal-${PV}-1.*.rpm
	cd "${WORKDIR}/ATI-Brook"
	rpm2tar atistream-brook-${PV}-1.*.rpm

	einfo "Extracting ATI-Cal"
	tar xf "${WORKDIR}"/ATI-Cal/atistream-cal-${PV}-1.*.tar -C "${S}"
	einfo "Extracting ATI-Brook"
	tar xf "${WORKDIR}"/ATI-Brook/atistream-brook-${PV}-1.*.tar -C "${S}"

	cd "${S}"
	epatch "${FILESDIR}/gcc-4.3-atistream.patch"
}

src_install() {
	local DEST=/opt/atibrook
	if use ati64 ; then
		MY_BASE_DIR="${BASE_DIR}_64a"
		ARCH_DIR="lnx64"
	else
		MY_BASE_DIR="${BASE_DIR}"
		ARCH_DIR="lnx32"
	fi

	# don't use lib32 or lib64 directories
	unset ABI

	into ${DEST}
	dobin usr/local/atibrook/sdk/bin/*
	dolib usr/local/atibrook/sdk/lib/*

	insinto ${DEST}/include
	doins -r usr/local/atibrook/platform/include/*
	doins -r usr/local/atical/include/*
	insinto ${DEST}/include/brook
	for file in `find usr/local/atibrook/platform/runtime/ -name \*.h`
	do
		doins "${file}"
	done

	insinto ${DEST}/utils
	doins -r usr/local/atibrook/utils/*

	newenvd "${FILESDIR}/99atistream" 99atistream || die "Failed to install env file."
}
