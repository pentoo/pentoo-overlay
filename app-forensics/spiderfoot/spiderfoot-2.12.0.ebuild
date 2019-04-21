# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite,ssl,readline"

inherit eutils python-single-r1 user

DESCRIPTION="The most complete OSINT collection and reconnaissance tool"
HOMEPAGE="https://www.spiderfoot.net"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/smicallef/spiderfoot"
else
	SRC_URI="https://github.com/smicallef/spiderfoot/archive/v${PV}-final.tar.gz -> ${P}.tar.gz"
	# >=cherrypy-17.4.1 — is not support "x86" (ebuild)
	KEYWORDS="~amd64 ~arm64"
	S="${WORKDIR}/${P}-final"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	>=dev-python/cherrypy-17.4.1[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/m2crypto[${PYTHON_USEDEP}]
	dev-python/mako[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.18[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/ipaddr-2.2.0[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/phonenumbers[${PYTHON_USEDEP}]
	dev-python/pygexf[${PYTHON_USEDEP}]
	dev-python/PyPDF2[${PYTHON_USEDEP}]
	net-libs/stem[${PYTHON_USEDEP}]"

pkg_setup() {
	python-single-r1_pkg_setup

	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
}

src_prepare() {
	python_fix_shebang "${S}"

	# run it without fucking root
	eapply "${FILESDIR}"/${P}_add_support_user_homedir.patch
	eapply_user
}

src_install() {
	# you need check distro files and update this array before bump it
	local dist_files=(
		"dyn"
		"ext"
		"modules"
		"static"
		*.py
	)

	insinto /usr/share/${PN}
	for x in ${dist_files[@]}; do
		doins -r ${x}
	done

	for x in sf sfcli; do
		make_wrapper "${x}" \
			"python2 /usr/share/${PN}/${x}.py" \
			"/usr/share/${PN}/"
	done

	dosym ./sf /usr/bin/${PN}
	dosym ./sfcli /usr/bin/${PN}-cli

	keepdir /var/lib/${PN}
	fowners ${PN}:${PN} /var/lib/${PN}

	newinitd "${FILESDIR}"/spiderfoot-daemon.initd spiderfoot-daemon
	newconfd "${FILESDIR}"/spiderfoot-daemon.confd spiderfoot-daemon

	dodoc README.md Dockerfile

	python_optimize "${D}"/usr/share/${PN}
}

pkg_postinst() {
	elog "\nJust run:"
	elog "    ~# rc-service spiderfoot-daemon start"
	elog "and open in browser http://127.0.0.1:5001\n"

	elog "See documentation: https://www.spiderfoot.net/documentation/\n"
}
