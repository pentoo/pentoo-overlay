# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Modern, high-performance vulnerability scanner that leverages simple YAML-based templates"
HOMEPAGE="https://github.com/projectdiscovery/nuclei"

SRC_URI="amd64? ( fetch+https://github.com/projectdiscovery/nuclei/releases/download/v${PV}/nuclei_${PV}_linux_amd64.zip )
	arm? ( fetch+https://github.com/projectdiscovery/nuclei/releases/download/v${PV}/nuclei_${PV}_linux_arm.zip )
	arm64? ( fetch+https://github.com/projectdiscovery/nuclei/releases/download/v${PV}/nuclei_${PV}_linux_arm64.zip )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

S="${WORKDIR}"

QA_PREBUILD="*"

src_install() {
	newbin "nuclei" "${PN}"
}

