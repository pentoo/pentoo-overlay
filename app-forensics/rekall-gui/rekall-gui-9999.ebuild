# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$ 

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Rekall Memory Forensic Framework"
HOMEPAGE="http://www.rekall-forensic.com/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/google/rekall.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/rekall"
S="${WORKDIR}/rekall/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
app-forensics/rekall-core"
