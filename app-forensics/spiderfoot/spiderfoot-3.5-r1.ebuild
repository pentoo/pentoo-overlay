# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
PYTHON_REQ_USE="sqlite,ssl,readline"

inherit eutils python-single-r1

DESCRIPTION="The most complete OSINT collection and reconnaissance tool"
HOMEPAGE="https://www.spiderfoot.net"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/smicallef/spiderfoot"
else
	SRC_URI="https://github.com/smicallef/spiderfoot/archive/v${PV}.tar.gz -> ${P}.tar.gz"
#	https://github.com/smicallef/spiderfoot/issues/1602
#	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="${PYTHON_DEPS}"

RDEPEND="${DEPEND}
	acct-group/spiderfoot
	acct-user/spiderfoot
	$(python_gen_cond_dep '
		>=dev-python/adblockparser-0.7[${PYTHON_USEDEP}]
		>=dev-python/dnspython-2.1.0[${PYTHON_USEDEP}]
		>=dev-python/exifread-2.3.2[${PYTHON_USEDEP}]
		>=dev-python/cherrypy-18.6.1[${PYTHON_USEDEP}]
		>=dev-python/cherrypy-cors-1.6[${PYTHON_USEDEP}]
		>=dev-python/mako-1.1.5[${PYTHON_USEDEP}]
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		>=dev-python/netaddr-0.8.0[${PYTHON_USEDEP}]
		>=dev-python/PySocks-1.7.1[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		>=dev-python/ipwhois-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/ipaddr-2.2.0[${PYTHON_USEDEP}]
		dev-python/phonenumbers[${PYTHON_USEDEP}]
		dev-python/pygexf[${PYTHON_USEDEP}]
		dev-python/PyPDF2[${PYTHON_USEDEP}]
		>=dev-python/python-whois-0.7.3[${PYTHON_USEDEP}]
		>=dev-python/secure-0.3.0[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-python/python-docx[${PYTHON_USEDEP}]
		dev-python/python-pptx[${PYTHON_USEDEP}]
		dev-python/networkx[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/publicsuffixlist[${PYTHON_USEDEP}]
		dev-python/openpyxl[${PYTHON_USEDEP}]
	')"

#https://github.com/smicallef/spiderfoot/issues/1176
#PATCHES=(
#	"${FILESDIR}/${PN}-3.0_fix_module_bug_sfp_hackertarget.patch"
#	"${FILESDIR}/${P}_add_support_user_homedir.patch"
#)

src_prepare() {
	default
	python_fix_shebang "${S}"
}

src_install() {
	insinto /usr/share/${PN}
	doins -r modules/ spiderfoot/ *.py

	for x in sf sfcli; do
		make_wrapper $x \
			"${EPYTHON} /usr/share/${PN}/${x}.py" \
			"/usr/share/${PN}/"
	done

	dosym ./sf /usr/bin/${PN}
	dosym ./sfcli /usr/bin/${PN}-cli

	keepdir /var/lib/${PN}
	fowners ${PN}:${PN} /var/lib/${PN}

	newinitd "${FILESDIR}"/spiderfoot-daemon.initd-r1 spiderfoot-daemon
	newconfd "${FILESDIR}"/spiderfoot-daemon.confd-r1 spiderfoot-daemon

	dodoc *.md Dockerfile

	python_optimize "${D}"/usr/share/${PN}
}

pkg_postinst() {
	elog "\nJust run:"
	elog "    ~# rc-service spiderfoot-daemon start"
	elog "and open in browser http://127.0.0.1:5001\n"

	elog "See documentation: https://www.spiderfoot.net/documentation/\n"
}
