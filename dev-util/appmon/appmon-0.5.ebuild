# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1
#inherit python-r1

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="https://github.com/dpnishant/appmon/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-util/frida-tools[${PYTHON_USEDEP}]
	dev-python/argparse[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/dataset[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/alembic[${PYTHON_USEDEP}]
	dev-python/htmlentities[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

src_install(){
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}/*.py

	newbin - appmon <<-EOF
#!/bin/sh
cd /usr/lib/appmon
python2 ./appmon.py
EOF

	newbin - appmon_viewreport <<-EOF
#!/bin/sh
cd /usr/lib/appmon
python2 ./viewreport.py
EOF

}
