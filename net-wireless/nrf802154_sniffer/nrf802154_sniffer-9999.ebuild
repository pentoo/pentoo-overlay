# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
inherit python-r1

DESCRIPTION="nRF-based 802.15.4 sniffer"
HOMEPAGE="https://github.com/NordicSemiconductor/nRF-Sniffer-for-802.15.4"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/NordicSemiconductor/nRF-Sniffer-for-802.15.4.git"
else
	COMMIT="2b76efe20d4bc1938803a90c60ea29db59bc1069"
	SRC_URI="https://github.com/NordicSemiconductor/nRF-Sniffer-for-802.15.4/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 arm arm64 x86"
	S="${WORKDIR}/nRF-Sniffer-for-802.15.4-${COMMIT}"
fi

LICENSE="Nordic-5"
SLOT="0"

DEPEND="net-analyzer/wireshark
		${PYTHON_DEPS}"
RDEPEND="${DEPEND}
		$(python_gen_any_dep 'dev-python/pyserial[${PYTHON_USEDEP}]')"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_install() {
	insinto /usr/share/${PN}
	doins nrf802154_sniffer/nrf802154_sniffer*.hex

	exeinto "/usr/$(get_libdir)/wireshark/extcap"
	doexe nrf802154_sniffer/nrf802154_sniffer.py
}
