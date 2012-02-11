# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="amd64? ( "http://downloads.metasploit.com/data/releases/metasploit-latest-linux-x64-installer.run" ) \
	x86? ( "http://downloads.metasploit.com/data/releases/metasploit-latest-linux-installer.run" )"

LICENSE=""
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="!net-analyzer/metasploit"
RDEPEND="${DEPEND}"

RESTRICT="strip"

S=${WORKDIR}

src_unpack() {
	die "This is not ready for use yet, don't even try"
        use amd64 && cp "${DISTDIR}/metasploit-latest-linux-x64-installer.run" "${WORKDIR}"
        use x86 && cp "${DISTDIR}/metasploit-latest-linux-installer.run" "${WORKDIR}"

        use amd64 && chmod 755 "${WORKDIR}/metasploit-latest-linux-x64-installer.run"
	use x86 && chmod 755 "${WORKDIR}/metasploit-latest-linux-installer.run"
}

pkg_setup() {
	:
}

src_install() {
	# We add the following line because metasploit insists on adding it's own postgres user otherwise
	# do a proper newuser newgroup in here, steal it from the postgres ebuild
	addpredict /etc/passwd

	use amd64 && ${WORKDIR}/metasploit-latest-linux-x64-installer.run --mode unattended --prefix "${ED}/opt/metasploit" --debuglevel 4 --debugtrace "${ED}/opt/metasploit/install.log"
	use x86 && ${WORKDIR}/metasploit-latest-linux-installer.run --mode unattended
#        make_wrapper skype ./skype /opt/skype /opt/skype
}
