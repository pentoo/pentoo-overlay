# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit base eutils python-single-r1

DESCRIPTION="Hexadecimal viewer and disassembler"
HOMEPAGE="https://github.com/joxeankoret/pyew"
#SRC_URI="https://github.com/xx/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="http://http.debian.net/debian/pool/main/p/pyew/pyew_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/01_fix_python_mini.patch
	epatch "${FILESDIR}"/02_kenshoto_bad_import.patch
	epatch "${FILESDIR}"/101_system_install.patch
}

RDEPEND="dev-libs/distorm64"
DEPEND="${RDEPEND}"

src_install() {
	dodoc AUTHORS ChangeLog

	dobin ${FILESDIR}/pyew
	insinto /usr/share/pyew/
	doins *.py
	doins -r anal/
	doins -r contrib/
	doins -r Elf/
	doins -r plugins/
	python_fix_shebang "${ED}"/usr/share/pyew
	fperms 755 /usr/share/pyew/pyew.py
}
