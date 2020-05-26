# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1 eutils

DESCRIPTION="Python interface for a malware identification and classification tool"
HOMEPAGE="https://github.com/VirusTotal/yara-python"
SRC_URI="https://github.com/virustotal/yara-python/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test +dex"

RDEPEND="${PYTHON_DEPS}
	~app-forensics/yara-${PV}[dex?]"
DEPEND="${RDEPEND}"

src_compile() {
	compile_python() {
		${EPYTHON} setup.py build --dynamic-linking
		distutils-r1_python_compile
	}
	python_foreach_impl compile_python
}
