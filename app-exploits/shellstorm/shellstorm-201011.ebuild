# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Search shellstorm shellcode repo"
HOMEPAGE="http://www.shell-storm.org/project/framework/"
SRC_URI="http://www.shell-storm.org/project/framework/files/framework-${PV}.py"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86 arm"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	newbin "${DISTDIR}/framework-${PV}.py" shellstorm.py || die
}
