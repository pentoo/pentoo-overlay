# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Implementation of the psycopg2 module using cffi. Compatible with Psycopg 2.5."
HOMEPAGE="https://github.com/chtd/psycopg2cffi"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

# postgresql (pg_config) is required to compile, https://github.com/pentoo/pentoo-overlay/issues/837
DEPEND="dev-db/postgresql"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
