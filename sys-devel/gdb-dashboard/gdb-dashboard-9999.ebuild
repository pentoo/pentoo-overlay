# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit eutils python-single-r1

DESCRIPTION="Modular visual interface for GDB in Python"
HOMEPAGE="https://github.com/cyrus-and/gdb-dashboard"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cyrus-and/gdb-dashboard"
else
	SRC_URI="https://github.com/cyrus-and/gdb-dashboard/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	$(python_gen_cond_dep 'dev-python/pygments[${PYTHON_MULTI_USEDEP}]')
	sys-devel/gdb[python]"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	insinto "/usr/share/${PN}"
	newins .gdbinit gdbinit

	cat > "${D}/usr/share/${PN}/${PN}" <<-_EOF_ || die
		# Use this commad for installing:
		# gdb -x /usr/share/${PN}/${PN} <program>

		source /usr/share/${PN}/gdbinit
	_EOF_

	make_wrapper $PN \
		"gdb -x /usr/share/${PN}/${PN}"

	dodoc README.md
}

pkg_postinst() {
	einfo "\nFor using put the command:"
	einfo "    gdb -x /usr/share/${PN}/${PN} <program>"
	einfo "or"
	einfo "    ${PN} <program>\n"
}
