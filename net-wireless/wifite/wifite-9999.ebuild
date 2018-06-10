# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#PYTHON_COMPAT=( python2_7 )
PYTHON_COMPAT=( python{2_7,3_5,3_6} )
inherit python-r1

MY_P="${PN}2-${PV}"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/derv82/wifite2.git"
	KEYWORDS=""
else
#	SRC_URI="https://github.com/derv82/wifite2/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
#	S="${WORKDIR}/${MY_P}"
	MY_COMMIT="f24ec55999e78a6f1de543d8d75a8cd65a4676cf"
	SRC_URI="https://github.com/derv82/wifite2/archive/${MY_COMMIT}.zip -> ${P}.zip"

	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/${PN}2-${MY_COMMIT}"
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

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	dosym  "${EPREFIX}"/usr/$(get_libdir)/${PN}/Wifite.py /usr/sbin/${PN}2
}

#src_prepare() {
#	#make it a module
#	sed -e 's|from .|from wifite.|' -i wifite/wifite.py || die "sed failed"
#	touch __init__.py
#	default
#}

#src_install() {
#	python_moduleinto ${PN}
#	python_foreach_impl python_domodule wifite __init__.py
#	newsbin wifite/wifite.py wifite2
#	dodoc README.md LICENSE
#}
