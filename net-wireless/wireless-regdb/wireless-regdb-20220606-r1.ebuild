# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )
inherit python-any-r1

MY_P="wireless-regdb-${PV:0:4}.${PV:4:2}.${PV:6:2}"
DESCRIPTION="Binary regulatory database for CRDA"
HOMEPAGE="https://wireless.wiki.kernel.org/en/developers/regulatory/wireless-regdb"
SRC_URI="https://www.kernel.org/pub/software/network/${PN}/${MY_P}.tar.xz"
S="${WORKDIR}/${MY_P}"
IUSE="pentoo"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~ia64 ~loong ~mips ppc ppc64 ~riscv sparc x86"

BDEPEND="$(python_gen_any_dep 'dev-python/m2crypto[${PYTHON_USEDEP}]')"

src_prepare() {
	eapply "${FILESDIR}"/no-no-ir.patch
	eapply_user
}

#TODO: add pentoo use flag to not patch the regdb, maybe adjust deps

src_compile() {
	if use pentoo; then
		emake install-distro-key || die "make install-distro-key failed"
		emake -j1 || die "emake failed"
	fi
	true
}

src_install() {
	# This file is not ABI-specific, and crda itself always hardcodes
	# this path.  So install into a common location for all ABIs to use.
	insinto /usr/lib/crda
	doins regulatory.bin

	insinto /etc/wireless-regdb/pubkeys
	doins *.key.pub.pem

	# Linux 4.15 now complains if the firmware loader
	# can't find these files #643520
	insinto /lib/firmware
	doins regulatory.db
	doins regulatory.db.p7s

	doman regulatory.bin.5
	dodoc README db.txt
}
