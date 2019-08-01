# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6} )
PYTHON_REQ_USE="threads"

inherit eutils python-r1

DESCRIPTION="A simple command line tool designed to brute force dirs and files in websites"
HOMEPAGE="https://github.com/maurosoria/dirsearch"
SRC_URI="https://github.com/maurosoria/dirsearch/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT=0
IUSE=""

RDEPEND="${PYTHON_DEPS}"

pkg_setup() {
	python_setup
}

src_prepare() {
	eapply "${FILESDIR}/add_homedir_support.patch"

	python_fix_shebang "${S}"
	default
}

src_install() {
	insinto "/usr/share/${PN}"
	for x in db \
			 lib \
			 thirdparty \
			 dirsearch.py \
			 default.conf
	do
		doins -r "$x"
	done

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper $PN \
		"python3 /usr/share/${PN}/dirsearch.py"

	dodoc \
		CHANGELOG.md \
		README.md
}

pkg_postinst() {
	elog "\nExample: https://infosectoughguy.blogspot.com/2016/10/lazy-directory-searching-for-pentesters.html\n"
}
