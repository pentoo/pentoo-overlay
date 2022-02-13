# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit eutils python-single-r1

DESCRIPTION="Online hash checker for Virustotal and other services"
HOMEPAGE="https://github.com/Neo23x0/munin"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Neo23x0/munin"
else
	SRC_URI="https://github.com/Neo23x0/munin/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~arm64 x86"
fi

LICENSE="Apache-2.0"
SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	$(python_gen_cond_dep '
		>=dev-python/colorama-0.3.9[${PYTHON_USEDEP}]
		>=dev-python/future-0.16.0[${PYTHON_USEDEP}]
		>=dev-python/requests-2.20.0[${PYTHON_USEDEP}]
		>=dev-python/pymisp-2.4.123[${PYTHON_USEDEP}]
		>=dev-python/flask-1.0[${PYTHON_USEDEP}]
		dev-python/flask-caching[${PYTHON_USEDEP}]
		dev-python/cfscrape[${PYTHON_USEDEP}]
		dev-python/pyzipper[${PYTHON_USEDEP}]

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
