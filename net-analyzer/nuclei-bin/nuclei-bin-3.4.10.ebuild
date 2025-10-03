# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="High-performance vulnerability based on YAML templates"
HOMEPAGE="https://github.com/projectdiscovery/nuclei"

SRC_URI="amd64? ( https://github.com/projectdiscovery/nuclei/releases/download/v${PV}/nuclei_${PV}_linux_amd64.zip )
	arm? ( https://github.com/projectdiscovery/nuclei/releases/download/v${PV}/nuclei_${PV}_linux_arm.zip )
	arm64? ( https://github.com/projectdiscovery/nuclei/releases/download/v${PV}/nuclei_${PV}_linux_arm64.zip )"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

BDEPEND="app-arch/unzip"

QA_PREBUILD="*"

src_install() {
	newbin "nuclei" "${PN}"
}
