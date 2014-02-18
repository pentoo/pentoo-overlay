# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3} )
inherit versionator linux-info distutils-r1

MY_PV=$(delete_version_separator 3)
MY_P=${PN}-${MY_PV}

DESCRIPTION="Single Packet Authorization and Port Knocking application"
HOMEPAGE="http://www.cipherdyne.org/fwknop/"
SRC_URI="http://www.cipherdyne.org/${PN}/download/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+gpg +client +server python"

DEPEND=""
RDEPEND="${DEPEND}
	net-libs/libpcap
	net-firewall/iptables
	>=app-crypt/gpgme-1.3.0-r1"

S=${WORKDIR}/${MY_P}

ERROR_NET="PF_RING-${PV} requires CONFIG_NET=y set in the kernel."
CONFIG_CHECK="~NETFILTER_XT_MATCH_COMMENT"

pkg_setup() {
	linux-info_pkg_setup
	if use python; then
		python_setup
	fi
}

src_prepare() {
	sed -i 's|gpgme.h|gpgme/gpgme.h|g' lib/{fko_common.h,fko_error.c} || die
	if use python; then
		cd "${S}/python"
		distutils-r1_src_prepare
	fi
}

src_configure() {
	econf \
		$(use_enable client) \
		$(use_enable server) \
		$(use_with gpg gpgme)
}

src_compile() {
	emake || die "emake failed"
	if use python; then
		cd "${S}/python"
		distutils-r1_src_compile
	fi
}

src_install() {
	# copy init debian script
	newinitd "${FILESDIR}"/fwknopd.initd fwknopd
	newconfd "${FILESDIR}"/fwknopd.confd fwknopd
	emake DESTDIR="${D}" install

	if use python; then
		cd "${S}/python"
		distutils-r1_src_install
	fi
}
