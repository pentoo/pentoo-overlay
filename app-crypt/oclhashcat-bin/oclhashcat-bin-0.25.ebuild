# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="oclHashcat-${PV}"
MY_A="${MY_P}".7z

inherit eutils pax-utils
DESCRIPTION="An opencl multihash cracker"
HOMEPAGE="http://hashcat.net/oclhashcat/"

#we have to use a custom downloader because of the wacky download link
SRC_URI=""

LICENSE="Artistic"
SLOT="0"
KEYWORDS="-*"
IUSE=""

RDEPEND="|| ( >=x11-drivers/nvidia-drivers-260 
	      >=x11-drivers/ati-drivers-10.12 )
	virtual/opencl-sdk"
DEPEND="${RDEPEND}
	app-arch/p7zip"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	URL="http://hashcat.net"
	UNIQUE=$(curl -A Firefox "$URL/files/${MY_A}" --silent|grep -E '(\?d=.*)'|cut -d'"' -f2)
	UAGENT="Please stop making my life harder than it needs to be and allow	people to download your work without jumping through mindless hoops."
	addwrite "${PORTAGE_ACTUAL_DISTDIR}"
	wget -U "${UAGENT}" $URL/files/${MY_A}$UNIQUE -O "${PORTAGE_ACTUAL_DISTDIR}"/${MY_A} || die
	ln -s "${PORTAGE_ACTUAL_DISTDIR}"/${MY_A} /"${WORKDIR}"/${MY_A} || die
	unpack "./${MY_A}"
}

src_install() {
	dodoc *Example.* docs
	rm -rf *.exe *Example.* docs
	if use x86; then
		rm oclHashcat64.bin
		pax-mark m oclHashcat32.bin
	else
		rm oclHashcat32.bin
		pax-mark m oclHashcat64.bin
	fi
	insinto /opt/${PN}
	doins -r "${S}"/* /opt/${PN} || die "Copy files failed"
	dobin "${FILESDIR}"/oclhashcat  || die "dobin failed"
	chown -R root:0 "${D}"
}
