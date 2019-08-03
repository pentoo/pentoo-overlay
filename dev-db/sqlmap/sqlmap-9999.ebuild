# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit eutils bash-completion-r1 python-single-r1

DESCRIPTION="Automatic SQL injection and database takeover tool"
HOMEPAGE="https://github.com/sqlmapproject/sqlmap"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sqlmapproject/sqlmap"
else
	SRC_URI="https://github.com/sqlmapproject/sqlmap/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT=0
IUSE="doc"

DEPEND="${PYTHON_DEPS}"
RDEPEND=""

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	if [[ ${PV} == *9999 ]]; then
		# fix broken tarball
		find ./ -name .git | xargs rm -rf || die

		# Don't forget to disable the revision check since we removed the SVN files
		sed \
			-e 's/= getRevisionNumber()/= "Unknown revision"/' \
			-i lib/core/settings.py || die 'sed failed!'
	fi

	mv doc/ "${T}"/doc || die
	#python_fix_shebang "${S}"

	default
}

src_install () {
	dodoc -r \
		README.md \
		$(use doc && echo "${T}/doc/*")

	dodir "/usr/share/${PN}/"
	cp -R * "${D}/usr/share/${PN}/" || die
	python_optimize "${D}/usr/share/${PN}"

	make_wrapper $PN \
		"python3 /usr/share/${PN}/sqlmap.py"

	newbashcomp "${FILESDIR}"/sqlmap.bash-completion sqlmap
}
