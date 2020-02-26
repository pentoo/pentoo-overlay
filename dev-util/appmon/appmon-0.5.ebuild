# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# TODO: add py3.* support
# * https://github.com/dpnishant/appmon/issues/86
PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

DESCRIPTION="Monitoring and tampering API calls of MacOS and iOS/Android apps"
HOMEPAGE="https://dpnishant.github.io/appmon/"
SRC_URI="https://github.com/dpnishant/appmon/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-util/frida-tools[${PYTHON_MULTI_USEDEP}]
		dev-python/argparse[${PYTHON_MULTI_USEDEP}]
		dev-python/flask[${PYTHON_MULTI_USEDEP}]
		dev-python/termcolor[${PYTHON_MULTI_USEDEP}]
		dev-python/dataset[${PYTHON_MULTI_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_MULTI_USEDEP}]
		dev-python/alembic[${PYTHON_MULTI_USEDEP}]
		dev-python/htmlentities[${PYTHON_MULTI_USEDEP}]
	')"

DEPEND="${RDEPEND}"

src_install(){
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}/*.py

	newbin - appmon <<-EOF
#!/bin/sh
cd /usr/lib/appmon
${EPYTHON} ./appmon.py
EOF

	newbin - appmon_viewreport <<-EOF
#!/bin/sh
cd /usr/lib/appmon
${EPYTHON} ./viewreport.py
EOF

}
