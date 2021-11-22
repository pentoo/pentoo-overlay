# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

MY_P="${PN}${PV/./}"

DESCRIPTION="A Web Content Scanner to look for existing/hidden content"
HOMEPAGE="http://dirb.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/gcc10.patch"
	"${FILESDIR}/ext_vars.patch"
	"${FILESDIR}/html2dict_man.patch"
	"${FILESDIR}/gendict_man.patch"
	"${FILESDIR}/manpage_cleaning.patch"
	"${FILESDIR}/spelling.patch"
	"${FILESDIR}/fix-bug-with-rootdir-as-home.patch"
	"${FILESDIR}/fix-usage-examples.patch"
	"${FILESDIR}/path-as-is.patch"
	"${FILESDIR}/client_cert.patch"
)

src_prepare() {
	# cleanup
	rm -f configure || die
	eautoreconf

	sed -e "s/\$(EXEEXT)/\$(DIC_EXEEXT)/g" \
		-i gendict_src/Makefile.{am,in} || die

	default
}

src_install() {
	emake DIC_EXEEXT="-${PN}" DESTDIR="${D}" install

	insinto "/usr/share/dict/dirb-wordlists"
	doins -r wordlists/*
	dodir /usr/share/dirb
	ln -s /usr/share/dict/dirb-wordlists "${ED}/usr/share/dirb/wordlists"
}
