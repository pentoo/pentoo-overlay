# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit eutils

DESCRIPTION="A Ruby framework designed to parse, analyze, and forge PDF documents"
HOMEPAGE="https://code.google.com/p/origami-pdf/"
SRC_URI="https://github.com/cogent/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="gtk"

RDEPEND="dev-lang/ruby
	dev-ruby/rubygems
	gtk? ( dev-ruby/ruby-gtk2 )"
DEPEND=""

src_install() {
	# should be as simple as copying everything into the target
	dodir /usr/$(get_libdir)/${PN}
	cp -R "${S}"/* "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	fowners -R root:0 /

	dodoc README CHANGELOG

	#we use a first bin file as a template for the rest
	newbin "${FILESDIR}/origami-sym" pdfdecompress
	for pdfname in "pdfdecrypt" "pdfencrypt" "pdfmetadata" "pdf2graph" "pdf2ruby" "pdfextract" \
		"pdfcop" "pdfcocoon" "pdfsh" "pdfwalker" "pdf2pdfa"
	do
		dosym /usr/bin/pdfdecompress /usr/bin/$pdfname
	done
	use gtk && dosym /usr/bin/pdfwalker /usr/bin/$pdfname
}
