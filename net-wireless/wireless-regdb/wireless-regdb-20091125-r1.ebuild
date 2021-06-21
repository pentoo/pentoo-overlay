# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="wireless-regdb-master-${PV:0:4}-${PV:4:2}-${PV:6:2}"
DESCRIPTION="Binary regulatory database for CRDA"
HOMEPAGE="http://wireless.kernel.org/en/developers/Regulatory"
#SRC_URI="http://wireless.kernel.org/download/wireless-regdb/${MY_P}.tar.bz2"
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/snapshot/${MY_P}.tar.gz"
#https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/snapshot/wireless-regdb-master-2021-04-21.tar.gz
LICENSE="as-is"
SLOT="0"

KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""
DEPEND="dev-libs/openssl
	dev-python/m2crypto"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_prepare() {
	eapply "${FILESDIR}"/extra-monitor-${PV}.patch
	eapply_user
}

#TODO: add pentoo use flag to not patch the regdb, maybe adjust deps

src_compile() {
	emake install-distro-key || die "make install-distro-key failed"
	emake || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/crda/
	doins regulatory.bin
	doins *.key.pub.pem
}
