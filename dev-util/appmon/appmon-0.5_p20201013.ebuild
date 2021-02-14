# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit python-single-r1

HASH_COMMIT="974418b80e2a3d49278b3acb2c86651894260dda"

DESCRIPTION="Monitoring and tampering API calls of MacOS and iOS/Android apps"
HOMEPAGE="https://dpnishant.github.io/appmon/"
SRC_URI="https://github.com/dpnishant/appmon/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/alembic[${PYTHON_MULTI_USEDEP}]
		dev-python/banal[${PYTHON_MULTI_USEDEP}]
		dev-python/chardet[${PYTHON_MULTI_USEDEP}]
		dev-python/click[${PYTHON_MULTI_USEDEP}]
		dev-python/dataset[${PYTHON_MULTI_USEDEP}]
		dev-python/flask[${PYTHON_MULTI_USEDEP}]
		dev-util/frida-tools[${PYTHON_MULTI_USEDEP}]
		dev-python/htmlentities[${PYTHON_MULTI_USEDEP}]
		dev-python/itsdangerous[${PYTHON_MULTI_USEDEP}]
		dev-python/jinja[${PYTHON_MULTI_USEDEP}]
		dev-python/mako[${PYTHON_MULTI_USEDEP}]
		dev-python/markupsafe[${PYTHON_MULTI_USEDEP}]
		dev-python/normality[${PYTHON_MULTI_USEDEP}]
		dev-python/python-dateutil[${PYTHON_MULTI_USEDEP}]
		dev-python/python-editor[${PYTHON_MULTI_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_MULTI_USEDEP}]
		dev-python/termcolor[${PYTHON_MULTI_USEDEP}]
		dev-python/werkzeug[${PYTHON_MULTI_USEDEP}]
	')"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S=${WORKDIR}/${PN}-${HASH_COMMIT}

#https://github.com/dpnishant/appmon/issues/86
#PATCHES=( "${FILESDIR}/104.patch" )

src_install(){
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}/*.py

	newbin - appmon <<-EOF
#!/bin/sh
cd /usr/$(get_libdir)/appmon
${EPYTHON} ./appmon.py
EOF

	newbin - appmon_viewreport <<-EOF
#!/bin/sh
cd /usr/$(get_libdir)/appmon
${EPYTHON} ./viewreport.py
EOF

}
