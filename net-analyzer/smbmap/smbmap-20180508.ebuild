# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
EGO_PN=github.com/ShawnDEvans/${PN}

inherit python-single-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/madengr/ham2mon.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="b55fc051afa477943c017c5f0afe86e9e2f241ad"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="SMBMap is a handy SMB enumeration tool."
HOMEPAGE="https://github.com/ShawnDEvans/smbmap"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

src_prepare() {
	# Dirty hack to actually add a shebang to the file, so that we can then fix
	# it using python_fix_shebang. Without a shebang, python_fix_shebang won't
	# even work
	sed -i '1 s|^.*$|#!/usr/bin/env python|' "${PN}.py"
	python_fix_shebang "${PN}.py"
	eapply_user
}

src_install() {
	newbin "${PN}.py" "${PN}"
}
