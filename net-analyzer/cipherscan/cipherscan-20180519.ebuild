# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
EGO_PN=github.com/mozilla/${PN}

inherit python-single-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mozilla/cipherscan.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="b0548dff8e5f9a098b7e14211f610ff63e3f63f7"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="A very simple way to find out which SSL ciphersuites are supported by a target."
HOMEPAGE="https://github.com/mozilla/cipherscan"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# cipherscan depends on dev-python/tlslite-ng, not dev-python/tlslite.
RDEPEND="!dev-python/tlslite
	dev-python/tlslite-ng
	dev-python/ecdsa"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

src_prepare() {
	# Dirty hack to actually add a shebang to the file, so that we can then fix
	# it using python_fix_shebang. Without a shebang, python_fix_shebang won't
	# even work.
	sed -i '1i#!/usr/bin/env python' cscan.py
	python_fix_shebang cscan.py

	# We don't want cipherscan pulling in the latest and greatest
	# dev-python/tlslite and dev-python/ecdsa using GitHub. We fixed its
	# dependencies using RDEPENDs.
	sed -e 's|\$DIRNAMEPATH/cscan.sh|$DIRNAMEPATH/cscan.py|' -i ${PN} || die "sed for ${PN} failed"
	default
}

src_install(){
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins -r *

	fperms +x /usr/share/${PN}/${PN}
	fperms +x /usr/share/${PN}/cscan.py

	# cipherscan needs to be run from its installation directory.
	insinto /usr/bin
	doins "${FILESDIR}/${PN}"
	fperms +x /usr/bin/${PN}
}
