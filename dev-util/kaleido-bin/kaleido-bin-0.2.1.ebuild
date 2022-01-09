# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="kaleido"

DESCRIPTION="Static image export for web-based visualization libraries"
HOMEPAGE="https://github.com/plotly/Kaleido"
SRC_URI="
amd64? (
	https://github.com/plotly/Kaleido/releases/download/v0.2.1/kaleido_linux_x64.zip -> ${P}.zip
)
"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S="${WORKDIR}/"
INSTALLDIR="/opt/kaleido"

src_install() {
	# application
	insinto ${INSTALLDIR}
	doins -r *

	# binaries
	chmod 755 "${D}/${INSTALLDIR}/bin/kaleido"
	chmod 755 "${D}/${INSTALLDIR}/kaleido"

#	dosym "${EPREFIX}"/${INSTALLDIR}/kaleido /usr/bin/kaleido

	newbin - ${MY_PN} <<-EOF
		#!/bin/sh

		cd ${INSTALLDIR}
		./${MY_PN} "\$@"
	EOF

	# default docs
	dodoc README.md
}
