# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 eutils

DESCRIPTION="Python interface for a malware identification and classification tool"
HOMEPAGE="https://github.com/VirusTotal/yara-python"
SRC_URI="https://github.com/virustotal/yara-python/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test +dex"

RDEPEND="${PYTHON_DEPS}
	=app-forensics/yara-4.0*[dex?]"
DEPEND="${RDEPEND}"

# Dex isn't enabled because dynamic-linking and dex aren't compatible
# We just make sure that if someone asks for dex, the yara library is compiled with it

src_compile() {
	compile_python() {
		distutils-r1_python_compile --dynamic-linking
	}
	python_foreach_impl compile_python
}
