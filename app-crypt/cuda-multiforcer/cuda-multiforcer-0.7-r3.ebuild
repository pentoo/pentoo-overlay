# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils

DESCRIPTION="A GPU-based MD5 MD4 NTLM bruteforcer"
HOMEPAGE="http://www.cryptohaze.com/"
SRC_URI="http://www.cryptohaze.com/releases/CUDA-Multiforcer-src-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="~dev-util/nvidia-cuda-sdk-3.0[pentoo]
	<dev-util/nvidia-cuda-toolkit-3.2
	=dev-libs/argtable-2*
	x11-drivers/nvidia-drivers"
RDEPEND="${DEPEND}"

S="${WORKDIR}/CUDA-Multiforcer-Release"

pkg_setup() {
	if [ -e "${ROOT}"/opt/cuda/sdk/C/common/common.mk ]; then
		export CUDAVERSION="2.3"
		elif [ -e "${ROOT}"/opt/cuda/sdk/common/common.mk ]; then
		export CUDAVERSION="2.2"
	else
		die "Something failed to detect the CUDA SDK version properly. Report this to the pentoo devs."
	fi
}

src_prepare() {
	# We have it installed
	epatch "${FILESDIR}"/learntodep-0.7.patch
	rm -rf argtable2-9

	case ${CUDAVERSION} in
		2.2) epatch "${FILESDIR}/multiforcer-${PV}-path.patch" ;;
		2.3) epatch "${FILESDIR}/cuda-sdk-greater-than-2.2-${PV}-path.patch" ;;
		*)   die "Why is CUDAVERSION set to $CUDAVERSION?"
	esac

#	if [ $CUDAVERSION = "2.2" ]; then
#		epatch "${FILESDIR}"/multiforcer-"${PV}"-path.patch
#	elif [ $CUDAVERSION = "2.3" ]; then
#		epatch "${FILESDIR}"/cuda-sdk-greater-than-2.2-"${PV}"-path.patch
#	else
#		die "Why is CUDAVERSION set to $CUDAVERSION?"
#	fi
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin bin/linux/release/cuda-multiforcer  || die "dobin failed"
	insinto /usr/share/cuda-multiforcer
	doins -r charsets test_hashes
	dodoc doc/*
}
