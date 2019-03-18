# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit distutils-r1

DESCRIPTION="Library to instrument executable formats"
HOMEPAGE="https://lief.quarkslab.com/"

HASH_COMMIT="dbfc9b0d04318a705395b0e688d12633e0cbb8e5"
SRC_URI="https://github.com/linkedin/qark/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="exploit"

RDEPEND="dev-python/requests[ssl,${PYTHON_USEDEP}]
	dev-python/pluginbase[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	virtual/python-enum34[${PYTHON_USEDEP}]
	dev-python/javalang[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	exploit? ( >=dev-util/android-sdk-update-manager-21.1 )
	dev-util/dex2jar
	dev-util/apktool
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S=${WORKDIR}/${PN}-${HASH_COMMIT}

#FIXME unbundle:
#"decompilers", "*.jar")

#unbundle existing system jars
src_prepare() {
	rm -r qark/lib/dex2jar-2.0
	sed -i '/dex2jar-2.0/d' setup.py || die
	rm -r qark/lib/apktool
	sed -i '/apktool/d' setup.py || die
	eapply_user
}

python_install_all() {
	distutils-r1_python_install_all

	create_symlinks() {
		dosym "${EPREFIX}/opt/dex2jar" "$(python_get_sitedir)/qark/lib/dex2jar-2.0"
		dosym "${EPREFIX}/opt/apktool" "$(python_get_sitedir)/qark/lib/apktool"
	}
	python_foreach_impl create_symlinks
}
