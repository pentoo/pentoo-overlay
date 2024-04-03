# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Soapy SDR module for SRDPlay API v3"
HOMEPAGE="https://github.com/pothosware/SoapySDRPlay3"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pothosware/SoapySDRPlay3.git"
else
	HASH_COMMIT="c4bb9afd17fd6ff2da23317f1fc98cfff3806a1d"
	SRC_URI="https://github.com/pothosware/SoapySDRPlay3/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/SoapySDRPlay3-${HASH_COMMIT}"
	KEYWORDS="~amd64 ~arm ~riscv ~x86"
fi

LICENSE="MIT"
SLOT="0/${PV}"

RDEPEND="net-wireless/soapysdr"
DEPEND="${RDEPEND}"
