# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

MY_P="${P/_/-}"
DESCRIPTION="A secure remote execution framework using a compact Scheme-influenced VM"
HOMEPAGE="https://sourceforge.net/projects/mosref/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	 doc? ( mirror://sourceforge/${PN}/${MY_P}-documentation.tar.gz )"

KEYWORDS="-* ~x86"
LICENSE="LGPL-2"
SLOT="0"
IUSE="doc sources"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"/"${MY_P}"

src_unpack() {
	for x in ${A}
	do
		unpack "${x}"
	done
	if use sources;then
		cp -a "${MY_P}" "${MY_P}.src"
	fi
}

src_prepare() {
	eapply "${FILESDIR}"/${PN}-gentoo.patch

	sed -i -e "s|%%DESTDIR%%|${D}usr|" bin/install.ms || die "sed failed"

	default
}

src_compile() {
	emake -j1
}

src_install() {
	emake install

	if use doc;then
		dodoc doc/vm-implementation*
		cd "${WORKDIR}"/"${PN}"-reference
		dodoc *
	fi

	if use sources;then
		einfo "Installing the sources for further cross-compile"
		dodir /usr/src/
		cd "${WORKDIR}"
		rm -rf "${MY_P}.src"/doc
		cp -R "${MY_P}.src" "${D}/usr/src/${P}"
	fi
}
