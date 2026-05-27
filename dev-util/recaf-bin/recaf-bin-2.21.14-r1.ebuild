# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

MY_PN="${PN%-bin}"
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
	dev-java/openjdk-bin:${JAVA_SLOT}
"

DEPEND="${RDEPEND}"

src_install() {
	insinto "/opt/${MY_PN}/"
	newins "${DISTDIR}/${P}.jar" "${MY_PN}.jar"

	domenu "${FILESDIR}/recaf.desktop"

	if use system-openjfx; then
		FXLIB_PATH="/usr/lib64/openjfx-${JFX_SLOT}/lib"
	else
		FXLIB_PATH="/usr/share/openjfx-bin-${JAVA_SLOT}/lib"
	fi

	newbin - ${MY_PN} <<-EOF
		#!/bin/sh
		FXLIB_PATH=${FXLIB_PATH}
		FXLIBS="\$FXLIB_PATH/javafx.base.jar:\$FXLIB_PATH/javafx.controls.jar:\
\$FXLIB_PATH/javafx.graphics.jar:\
/opt/${MY_PN}/recaf.jar"

		if [ \$# -eq 1 ] && [ -f "\$1" ]; then
			java -cp \$FXLIBS me.coley.recaf.Recaf "--noupdate" "--input=\$1"
		else
			java -cp \$FXLIBS me.coley.recaf.Recaf "--noupdate" "\$@"
		fi
	EOF
}
