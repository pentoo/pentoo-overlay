# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Command line Java Decompiler"
HOMEPAGE="https://github.com/kwart/jd-cli"
SRC_URI="https://github.com/kwart/jd-cli/releases/download/jd-cli-${PV}/jd-cli-${PV}-dist.tar.gz"

LICENSE="Apache-2.0"
SLOT="GPL-3"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( virtual/jre virtual/jdk )"

S="${WORKDIR}"

#upsteam can't make up its mind: https://github.com/kwart/jd-cmd/issues/40
src_install() {
	insinto "/opt/jd-cli/"
	doins jd-cli.jar
	cp jd-cli "${ED}"/opt/jd-cli/
	dosym "${EPREFIX}"/opt/jd-cli/jd-cli /usr/bin/jd-cli
}
