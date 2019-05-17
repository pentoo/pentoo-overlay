# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6} )

inherit eutils python-single-r1

DESCRIPTION="Online hash checker for Virustotal and other services"
HOMEPAGE="https://github.com/Neo23x0/munin"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Neo23x0/munin"
else
	SRC_URI="https://github.com/Neo23x0/munin/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~mips ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	>=dev-python/colorama-0.3.9[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	>=dev-python/selenium-3.9.0[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pymisp[${PYTHON_USEDEP}]
	dev-python/ipy[${PYTHON_USEDEP}]"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	# Update warning messages
	sed -e "s: munin.ini : /etc/${PN}/munin.ini :" \
		-i *.py || die "sed filed!"

	python_fix_shebang "${S}"
	eapply_user
}

src_install() {
	insinto /usr/share/${PN}
	for x in lib *.py; do
		doins -r ${x}
	done

	# The Gentoo repo have more packages using same name
	for x in munin-checker munin-checker-host; do
		make_wrapper "${x}" \
			"python3 /usr/share/${PN}/${x//-checker/}.py -i /etc/${PN}/${PN}.ini"
	done

	insinto /etc/${PN}
	doins ${PN}.ini

	dodoc README.md

	python_optimize "${D}"/usr/share/${PN}
}
