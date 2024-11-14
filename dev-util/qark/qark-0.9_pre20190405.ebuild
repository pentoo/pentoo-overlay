# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A tool to look for Android application vulnerabilities"
HOMEPAGE="https://github.com/linkedin/qark/"

HASH_COMMIT="ba1b26562507d631389b111e5033dad4128a8541"
SRC_URI="https://github.com/linkedin/qark/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${HASH_COMMIT}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="exploit"

RDEPEND="${PYTHON_DEPS}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pluginbase[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/javalang[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	exploit? ( >=dev-util/android-sdk-update-manager-21.1 )
	dev-util/dex2jar
	dev-util/apktool
"
DEPEND="${RDEPEND}"

#FIXME unbundle:
#"decompilers", "*.jar")

#unbundle existing system jars
src_prepare() {
	rm -r qark/lib/dex2jar-2.0
	sed -i '/dex2jar-2.0/d' setup.py || die
	rm -r qark/lib/apktool
	sed -i '/apktool/d' setup.py || die
	default
}

python_install_all() {
	distutils-r1_python_install_all

	create_symlinks() {
		dosym -r "${EPREFIX}/opt/dex2jar" "$(python_get_sitedir)/qark/lib/dex2jar-2.0"
		dosym -r "${EPREFIX}/opt/apktool" "$(python_get_sitedir)/qark/lib/apktool"
	}
	python_foreach_impl create_symlinks
}
