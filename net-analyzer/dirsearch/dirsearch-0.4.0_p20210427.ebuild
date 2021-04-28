# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

HASH_COMMIT="c038c6b1b7e625c1ba5d9d5845ecc0aee89f73ac"
DESCRIPTION="A simple command line tool designed to brute force dirs and files in websites"
HOMEPAGE="https://github.com/maurosoria/dirsearch"
SRC_URI="https://github.com/maurosoria/dirsearch/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64 ~arm64 x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-${HASH_COMMIT}

src_prepare() {
	#use ~/.dirsearch directory
	sed -e "s|save-logs-home = False|save-logs-home = True|g" -i default.conf || die "sed 1"
	sed -e "s|autosave-report = True|autosave-report = False|g" -i default.conf || die "sed 2"
#	mv *.md Dockerfile  "${T}" || die
	eapply_user
}

pkg_postinst() {
	elog "\nExample: https://infosectoughguy.blogspot.com/2016/10/lazy-directory-searching-for-pentesters.html\n"
}
