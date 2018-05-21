# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

MY_P="${PN}2-${PV}"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/derv82/wifite2.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/derv82/wifite2/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/${MY_P}"
fi

DESCRIPTION="An automated wireless attack tool"
HOMEPAGE="https://github.com/derv82/wifite2"

LICENSE="GPL-2"
SLOT="2"
IUSE="dict extra"

DEPEND=""
RDEPEND="net-wireless/aircrack-ng
	dev-python/pexpect
	dict? ( sys-apps/cracklib-words )
	extra? ( net-analyzer/wireshark
		net-wireless/reaver-wps-fork-t6x
		!net-wireless/reaver
		net-wireless/bully
		net-wireless/cowpatty
		net-wireless/pyrit
		net-analyzer/macchanger
	)"

src_prepare() {
	python_fix_shebang .
	eapply_user
}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	dosym  "${EPREFIX}"/usr/$(get_libdir)/${PN}/Wifite.py /usr/sbin/${PN}2
}
