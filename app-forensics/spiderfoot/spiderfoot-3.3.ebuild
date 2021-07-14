# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
PYTHON_REQ_USE="sqlite,ssl,readline"

inherit eutils python-single-r1

DESCRIPTION="The most complete OSINT collection and reconnaissance tool"
HOMEPAGE="https://www.spiderfoot.net"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/smicallef/spiderfoot"
else
	SRC_URI="https://github.com/smicallef/spiderfoot/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	acct-group/spiderfoot
	acct-user/spiderfoot
	$(python_gen_cond_dep '
		>=dev-python/adblockparser-0.7[${PYTHON_MULTI_USEDEP}]
		>=dev-python/dnspython-1.16.0[${PYTHON_MULTI_USEDEP}]
		>=dev-python/exifread-2.1.2[${PYTHON_MULTI_USEDEP}]
		>=dev-python/cherrypy-18.0[${PYTHON_MULTI_USEDEP}]
		dev-python/mako[${PYTHON_MULTI_USEDEP}]
		dev-python/beautifulsoup:4[${PYTHON_MULTI_USEDEP}]
		dev-python/lxml[${PYTHON_MULTI_USEDEP}]
		>=dev-python/netaddr-0.7.18[${PYTHON_MULTI_USEDEP}]
		>=dev-python/PySocks-1.7.1[${PYTHON_MULTI_USEDEP}]
		dev-python/requests[${PYTHON_MULTI_USEDEP}]
		~dev-python/ipwhois-1.0.0[${PYTHON_MULTI_USEDEP}]
		>=dev-python/ipaddr-2.2.0[${PYTHON_MULTI_USEDEP}]
		dev-python/phonenumbers[${PYTHON_MULTI_USEDEP}]
		dev-python/pygexf[${PYTHON_MULTI_USEDEP}]
		dev-python/PyPDF2[${PYTHON_MULTI_USEDEP}]
		>=net-libs/stem-1.7.1[${PYTHON_MULTI_USEDEP}]
		dev-python/python-whois[${PYTHON_MULTI_USEDEP}]
		dev-python/python-secure[${PYTHON_MULTI_USEDEP}]
		dev-python/pyopenssl[${PYTHON_MULTI_USEDEP}]
		dev-python/python-docx[${PYTHON_MULTI_USEDEP}]
		dev-python/python-pptx[${PYTHON_MULTI_USEDEP}]
		dev-python/networkx[${PYTHON_MULTI_USEDEP}]
		dev-python/cryptography[${PYTHON_MULTI_USEDEP}]
		dev-python/publicsuffixlist[${PYTHON_MULTI_USEDEP}]
	')"

#https://github.com/smicallef/spiderfoot/issues/1176
PATCHES=(
#	"${FILESDIR}/${PN}-3.0_fix_module_bug_sfp_hackertarget.patch"
	"${FILESDIR}/${P}_add_support_user_homedir.patch"
)

src_prepare() {
	default
	python_fix_shebang "${S}"
}

src_install() {
	insinto /usr/share/${PN}
	doins -r dicts/ dyn/ modules/ static/ *.py

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
