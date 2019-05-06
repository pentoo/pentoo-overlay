# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6,3_7} )
inherit distutils-r1

DESCRIPTION="Python interface for a malware identification and classification tool"
HOMEPAGE="https://github.com/VirusTotal/yara-python"
SRC_URI="https://github.com/virustotal/yara-python/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/virustotal/yara/archive/v${PV}.tar.gz -> yara-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="${PYTHON_DEPS}
	~app-forensics/yara-${PV}"
DEPEND="${RDEPEND}"

#need to use local yara, see
#https://github.com/pentoo/pentoo-overlay/issues/397
src_prepare() {
	cp -r "${WORKDIR}/yara-${PV}/"* "${S}/yara/"
	default
}
