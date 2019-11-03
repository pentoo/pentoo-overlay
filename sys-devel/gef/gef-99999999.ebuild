# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit eutils python-single-r1

DESCRIPTION="A GDB Enhanced Features for exploit devs & reversers"
HOMEPAGE="https://github.com/hugsy/gef"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hugsy/gef"
else
	HASH_COMMIT="7b773361b356065c2ea851d8893d2f24894d8b85" # 20190408

	SRC_URI="https://github.com/hugsy/gef/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"

	# TODO: unmask this version after resolving issues
	# see more:
	# * https://github.com/gentoo/gentoo/pull/11828
	# * https://bugs.gentoo.org/652440
	#KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc"

RDEPEND="
	dev-libs/capstone-bindings[python,${PYTHON_USEDEP}]
	dev-libs/keystone[python,${PYTHON_USEDEP}]
	dev-python/pylint[${PYTHON_USEDEP}]
	dev-util/unicorn[python,unicorn_targets_x86(+),${PYTHON_USEDEP}]
	sys-devel/ropper[${PYTHON_USEDEP}]
	sys-devel/gdb[python]"

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

	dodoc README.md Dockerfile
}

pkg_postinst() {
	einfo "\nUsage:"
	einfo "    ~$ alias gdb-gef='gdb-gef -ex init-gef'"
	einfo "    ~$ gdb-gef <program>\n"
}
