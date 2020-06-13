# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="recaf"
#MY_PV="$(ver_cut 1-3)-redesign.$(ver_cut 5)"

DESCRIPTION="A modern Java bytecode editor"
HOMEPAGE="https://col-e.github.io/Recaf/"
SRC_URI="https://github.com/Col-E/Recaf/releases/download/${PV}/recaf-${PV}-J8-jar-with-dependencies.jar -> ${P}.jar"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="system-openjfx"

RDEPEND="system-openjfx? ( dev-java/openjfx )
	virtual/jre:*"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	dodir "${S}"
	cp -L "${DISTDIR}/${A}" "${S}/${MY_PN}.jar" || die
}

src_install() {
	insinto "/opt/${MY_PN}/"
	doins "${MY_PN}.jar"

	newbin - ${MY_PN} <<-EOF
		#!/bin/sh
		FXLIB_PATH="/usr/lib64/openjfx-11/lib"

		FXLIBS="\$FXLIB_PATH/javafx.base.jar:\$FXLIB_PATH/javafx.controls.jar:\
\$FXLIB_PATH/javafx.graphics.jar:\
/opt/${MY_PN}/recaf.jar"

		java -cp \$FXLIBS me.coley.recaf.Recaf "--noupdate" "\$@"
	EOF
}

pkg_postinst() {
	if ! use system-openjfx; then
		einfo "The tool is installed without system-openjfx use flag"
		einfo "It will download openjfx during runtime into a home diretory"
	fi
}
