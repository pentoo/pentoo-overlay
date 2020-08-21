# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7


DESCRIPTION="a tool for generating freedesktop-compliant menus"
HOMEPAGE="https://github.com/pentoo/genmenu"

LICENSE="GPL-2"
SLOT="0"

if [ "${PV}" = "9999" ];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pentoo/genmenu.git"
else
	KEYWORDS="amd64 x86"
	COMMIT="fd41747930ed56c4d00b09d1490b665d618ff52d"
	SRC_URI="https://github.com/pentoo/genmenu/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

#gnome-base/gnome-menus"
DEPEND=">=dev-python/lxml-1.3.6[python_targets_python2_7]"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/
	doins -r "${S}"/src/share
	chown -R root:root "${ED}"
	dobin src/bin/genmenu.py src/bin/launch
}

pkg_postinst() {
	einfo
	einfo "The genmenu has been updated."
	einfo "You should run the following command to regenerate the main Pentoo menu for a local user:"
	einfo "E17:  genmenu.py -e"
	einfo "Xfce: genmenu.py -x"
	einfo "KDE:  genmenu.py -k"
	einfo
	einfo "See -h for more options"
}
