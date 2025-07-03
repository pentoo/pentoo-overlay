# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-utils-2

DESCRIPTION="Java OpenJFX client application platform"
HOMEPAGE="https://gluonhq.com/products/javafx/"
SRC_URI="
https://repo1.maven.org/maven2/org/openjfx/javafx-base/${PV}/javafx-base-${PV}-linux.jar
https://repo1.maven.org/maven2/org/openjfx/javafx-controls/${PV}/javafx-controls-${PV}-linux.jar
https://repo1.maven.org/maven2/org/openjfx/javafx-graphics/${PV}/javafx-graphics-${PV}-linux.jar
https://repo1.maven.org/maven2/org/openjfx/javafx-media/${PV}/javafx-media-${PV}-linux.jar
"
S="${WORKDIR}/"

LICENSE="GPL-2-with-classpath-exception"
SLOT="${PV%%[.+]*}"
KEYWORDS="amd64"

DEPEND="
	dev-java/openjdk-bin:${SLOT}
"
RDEPEND="${DEPEND}"

src_unpack() {
	dodir "${S}"

	for MY_A in $A; do
		cp -L "${DISTDIR}/${MY_A}" "${S}/${MY_A}" || die
		echo "${MY_A}"
	done
}

src_install() {
	java-pkg_newjar javafx-base-${PV}-linux.jar javafx.base.jar
	java-pkg_newjar javafx-controls-${PV}-linux.jar javafx.controls.jar
	java-pkg_newjar javafx-graphics-${PV}-linux.jar javafx.graphics.jar
	java-pkg_newjar javafx-media-${PV}-linux.jar javafx.media.jar
}
