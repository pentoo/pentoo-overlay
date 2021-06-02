# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit eutils python-single-r1

DESCRIPTION="A GDB Enhanced Features for exploit devs & reversers"
HOMEPAGE="https://github.com/hugsy/gef"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hugsy/gef"
else
	SRC_URI="https://github.com/hugsy/gef/archive/${PV}.tar.gz -> ${P}.tar.gz"
	#dev-libs/capstone is not stable yet
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc"

RDEPEND="
	sys-devel/gdb[python,${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
	app-exploits/ropper[${PYTHON_MULTI_USEDEP}]
	dev-libs/capstone[python,${PYTHON_MULTI_USEDEP}]
	dev-libs/keystone[python,${PYTHON_MULTI_USEDEP}]
	dev-python/pylint[${PYTHON_MULTI_USEDEP}]
	dev-util/unicorn[python,unicorn_targets_x86(+)]
	')"

BDEPEND="doc? ( dev-python/mkdocs )"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_compile() {
	:
}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r *.py

	python_optimize "${D}/usr/share/${PN}"

	cat > "${D}/usr/share/${PN}/init-gef" <<-_EOF_ || die
	echo For enabling put the 'init-gef' command!\n
	define init-gef
	source /usr/share/${PN}/gef.py
	end
	document init-gef
	Initializes Gef
	end
	_EOF_

	make_wrapper "gdb-gef" \
	"gdb -x /usr/share/${PN}/init-gef"

	if use doc; then
		mkdocs build -d html || die
		dodoc -r html/
	fi

	dodoc README.md
}

pkg_postinst() {
	einfo "\nUsage:"
	einfo "    ~$ alias gdb-gef='gdb-gef -ex init-gef'"
	einfo "    ~$ gdb-gef <program>\n"
}
