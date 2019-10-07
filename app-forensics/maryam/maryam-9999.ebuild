# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="ssl,threads"

inherit eutils python-single-r1

DESCRIPTION="A full-featured open-source intelligence (OSINT) framework"
HOMEPAGE="https://github.com/saeeddhqan/Maryam"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/saeeddhqan/Maryam"
else
	HASH_COMMIT="bc8ff2418c57be368c56b8024326cdda94430b48" # 20191004
	SRC_URI="https://github.com/saeeddhqan/Maryam/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"

	S="${WORKDIR}/Maryam-${HASH_COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/lxml[${PYTHON_USEDEP}]"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	sed -e "s/^__version__ = \"\(.*\)\"/__version__ = \"${PV}\"/" \
		-i core/base.py || die

	python_fix_shebang "${S}"
	default
}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r core/ data/ modules/ maryam

	make_wrapper $PN \
		"python2 /usr/share/${PN}/maryam" \
		"/usr/share/${PN}"

	dodoc README.md

	python_optimize "${D}/usr/share/${PN}"
}

pkg_postinst() {
	einfo "\nSee documentation: https://github.com/saeeddhqan/maryam/wiki/"
	einfo "Examples: https://github.com/saeeddhqan/Maryam/wiki/modules\n"
}
