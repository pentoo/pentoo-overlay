# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="recaf"
JAVA_SLOT=21
JFX_SLOT=11

DESCRIPTION="A modern Java bytecode editor"
HOMEPAGE="https://col-e.github.io/Recaf/"
SRC_URI="https://github.com/Col-E/Recaf/releases/download/${PV}/recaf-${PV}-J8-jar-with-dependencies.jar -> ${P}.jar"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="system-openjfx"

RDEPEND="
	system-openjfx? ( dev-java/openjfx:${JFX_SLOT} )
	!system-openjfx? ( dev-java/openjfx-bin:${JAVA_SLOT} )
	dev-java/openjdk-bin:${JAVA_SLOT}"
DEPEND="${RDEPEND}"

src_unpack() {
	dodir "${S}"
	cp -L "${DISTDIR}/${A}" "${S}/${MY_PN}.jar" || die
}

src_install() {
	insinto "/opt/${MY_PN}/"
	doins "${MY_PN}.jar"

	if ! use system-openjfx; then
		FXLIB_PATH="/usr/lib64/openjfx-${JFX_SLOT}/lib"
	else
		FXLIB_PATH="/usr/share/openjfx-bin-${JAVA_SLOT}/lib"
	fi

	newbin - ${MY_PN} <<-EOF
		#!/bin/sh

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
