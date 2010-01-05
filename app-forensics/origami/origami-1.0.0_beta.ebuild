# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

MY_P="${P/_/-}1b"
SRC_URI="http://security-labs.org/origami/files/${MY_P}.tar.gz"
DESCRIPTION="A Ruby framework designed to parse, analyze, and forge PDF documents"
HOMEPAGE="http://security-labs.org/origami/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gtk"

RDEPEND="dev-lang/ruby
	dev-ruby/rubygems
	gtk? ( dev-ruby/ruby-gtk2 )"
DEPEND=""

S="${WORKDIR}/${P/_/-}1"
src_install() {
	# should be as simple as copying everything into the target...
	dodir /usr/lib/${PN}
	cp -pR "${S}"/sources/* "${D}"/usr/lib/${PN} || die "Copy files failed"
	cd doc && dodoc *
	chown -R root:0 "${D}"
	dobin "${FILESDIR}/origami"
	use gtk && dobin "${FILESDIR}/origami-gui"
}
