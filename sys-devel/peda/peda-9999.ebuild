# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit eutils python-single-r1

DESCRIPTION="Python Exploit Development Assistance for GDB"
HOMEPAGE="https://github.com/longld/peda"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/longld/peda"
else
	SRC_URI="https://github.com/longld/peda/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="CC-BY-NC-SA-3.0"
SLOT="0"

RDEPEND="
	$(python_gen_cond_dep 'dev-python/six[${PYTHON_MULTI_USEDEP}]')
	sys-devel/gdb[python]"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r lib/ *.py

	python_optimize "${D}/usr/share/${PN}"

	cat > "${D}/usr/share/${PN}/gdb_peda" <<-_EOF_ || die
		# Use this commad for installing:
		# gdb -x /usr/share/${PN}/gdb_peda <program>

		source /usr/share/${PN}/peda.py
	_EOF_

	make_wrapper "gdb-peda" \
		"gdb -x /usr/share/${PN}/gdb_peda"

	dodoc README{,.md}
}

pkg_postinst() {
	einfo "\nFor using put the command:"
	einfo "    gdb -x /usr/share/${PN}/gdb_peda <program>"
	einfo "or"
	einfo "    gdb-peda <program>\n"
}
