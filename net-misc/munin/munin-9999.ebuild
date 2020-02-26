# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# TODO: add py3.* support
PYTHON_COMPAT=( python3_6 )

inherit eutils python-single-r1

DESCRIPTION="Online hash checker for Virustotal and other services"
HOMEPAGE="https://github.com/Neo23x0/munin"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Neo23x0/munin"
else
	SRC_URI="https://github.com/Neo23x0/munin/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~mips ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	$(python_gen_cond_dep '
		>=dev-python/colorama-0.3.9[${PYTHON_MULTI_USEDEP}]
		dev-python/future[${PYTHON_MULTI_USEDEP}]
		>=dev-python/selenium-3.9.0[${PYTHON_MULTI_USEDEP}]
		dev-python/beautifulsoup:4[${PYTHON_MULTI_USEDEP}]
		dev-python/requests[${PYTHON_MULTI_USEDEP}]
		dev-python/pymisp[${PYTHON_MULTI_USEDEP}]
		dev-python/ipy[${PYTHON_MULTI_USEDEP}]
		dev-python/pycurl[${PYTHON_MULTI_USEDEP}]
		dev-python/flask[${PYTHON_MULTI_USEDEP}]
		dev-python/flask-caching[${PYTHON_MULTI_USEDEP}]
		dev-python/dnspython[${PYTHON_MULTI_USEDEP}]
	')"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	# Update warning messages
	sed -e "s: munin.ini : /etc/${PN}/munin.ini :" \
		-i *.py || die "sed filed!"

	python_fix_shebang "${S}"
	default
}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r lib *.py
	python_optimize "${D}/usr/share/${PN}"

	for x in munin-checker munin-checker-host; do
		make_wrapper "${x}" \
			"${EPYTHON} /usr/share/${PN}/${x//-checker/}.py -i /etc/${PN}/${PN}.ini"
	done

	insinto "/etc/${PN}"
	doins ${PN}.ini

	dodoc README.md munin-*demo.txt
}
