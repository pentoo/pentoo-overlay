# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="WiFi-Pumpkin"

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1 multilib epatch

DESCRIPTION="Framework for Rogue Wi-Fi Access Point Attack"
HOMEPAGE="https://github.com/P0cL4bs/WiFi-Pumpkin"
SRC_URI="https://github.com/P0cL4bs/WiFi-Pumpkin/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"

#https://github.com/P0cL4bs/WiFi-Pumpkin/issues/484
#KEYWORDS="~amd64"

IUSE="plugins"

RDEPEND="${PYTHON_DEPS}
	net-wireless/hostapd[wpe]
	net-wireless/rfkill
	dev-python/twisted-web[${PYTHON_USEDEP}]
	net-analyzer/scapy[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/config[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/isc_dhcp_leases[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]
	dev-python/pcapy[${PYTHON_USEDEP}]
	dev-python/configparser[${PYTHON_USEDEP}]
	dev-python/netfilterqueue[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	>=dev-python/libarchive-c-2.1[${PYTHON_USEDEP}]
	>=dev-python/python-magic-0.4.8[${PYTHON_USEDEP}]
	dev-python/pefile[${PYTHON_USEDEP}]
	dev-python/capstone-python[${PYTHON_USEDEP}]
	dev-python/hyperframe[${PYTHON_USEDEP}]
	dev-python/hyper-h2[${PYTHON_USEDEP}]
	dev-python/scapy-http[${PYTHON_USEDEP}]
	dev-python/service_identity[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]

	plugins? ( net-dns/dnsmasq
		net-analyzer/driftnet
		net-analyzer/ettercap
	)"

#missing? backports.ssl_match_hostname

#FIXME: remove bundled plugins/

#There is a potential issue with deps due to original requirement:
#configparser==3.3.0r1

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	rm -r plugins/bin
	#do not check dependencies because you can't even spell it properly
	sed -i '/core.loaders.checker.depedences/d' wifi-pumpkin.py || die "sed failed"
	eapply_user
}

src_install() {
	insinto /usr/$(get_libdir)/${PN}
	doins -r *

	fperms +x /usr/$(get_libdir)/${PN}/${PN}.py
	dosym /usr/$(get_libdir)/${PN}/${PN}.py /usr/sbin/${PN}

	python_optimize "${D}"usr/$(get_libdir)/${PN}
}
