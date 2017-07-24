# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Advanced command line hexadecimal editor and more"
HOMEPAGE="http://www.radare.org"
#SRC_URI="http://cloud.radare.org/get/${PV}/${P}.tar.gz"
SRC_URI="https://github.com/radare/radare2/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+syscapstone ssl"

RDEPEND="syscapstone? ( >dev-libs/capstone-4.0_alpha5:= )
	ssl? ( dev-libs/openssl:0= )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${PN}-0.9.9-nogit.patch
)
#	"${FILESDIR}/pull7666.patch"

src_configure() {
	econf \
		$(use_with ssl openssl) \
		$(use_with syscapstone)
}

src_install() {
	# a workaround for unstable $(INSTALL) call, bug #574866
	local d
	for d in doc/*; do
		if [[ -d $d ]]; then
			rm -rfv "$d" || die "failed to delete '$d'"
		fi
	done

	default
}
