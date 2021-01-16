# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{7..9} )
EGO_PN=github.com/mozilla/${PN}

inherit eutils python-single-r1

DESCRIPTION="A very simple way to find out which SSL ciphersuites are supported by a target"
HOMEPAGE="https://github.com/mozilla/cipherscan"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mozilla/cipherscan.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	HASH_COMMIT="885b34593035c73d1fd2dd6ca1a42e211932fee0"
	SRC_URI="https://${EGO_PN}/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="MPL-2.0"
SLOT="0"

# cipherscan depends on dev-python/tlslite-ng, not dev-python/tlslite.
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		!dev-python/tlslite[${PYTHON_MULTI_USEDEP}]
		dev-python/tlslite-ng[${PYTHON_MULTI_USEDEP}]
		dev-python/ecdsa[${PYTHON_MULTI_USEDEP}]
	')"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

QA_PREBUILT="/usr/share/${PN}/openssl"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	default

	# Dirty hack to actually add a shebang to the file, so that we can then fix
	# it using python_fix_shebang. Without a shebang, python_fix_shebang won't
	# even work.
	sed -i '1i#!/usr/bin/env python' cscan.py || die
	python_fix_shebang "${S}"

	# We don't want cipherscan pulling in the latest and greatest
	# dev-python/tlslite and dev-python/ecdsa using GitHub. We fixed its
	# dependencies in RDEPEND.
	sed -e 's|\$DIRNAMEPATH/cscan.sh|$DIRNAMEPATH/cscan.py|' -i ${PN} || die "sed for ${PN} failed"

	sed -e 's|import .messages|import cscan.messages|' -i cscan/*.py
}

src_install(){
	insinto /usr/share/${PN}
	doins -r *

	fperms 0755 "/usr/share/${PN}/${PN}"
	fperms 0755 "/usr/share/${PN}/cscan.py"
	python_optimize "${D}usr/share/${PN}"

	# cipherscan needs to be run from its installation directory.
	make_wrapper $PN \
        "/usr/share/${PN}/${PN}"

	dodoc README.md
}
