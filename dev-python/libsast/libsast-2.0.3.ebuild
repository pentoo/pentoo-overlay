# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A generic SAST core built on top of semgrep and regex"
HOMEPAGE="https://github.com/ajinabraham/libsast/"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/requests-2.27.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/semgrep-0.104.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare(){
	# https://python-poetry.org/docs/dependency-specification/#using-environment-markers
	# Invalid PEP 440 version: '>=2.0.3'
	# sed -i "s|version = \"|version = \">=|g" pyproject.toml
	sed -i '/^semgrep = {version/d' pyproject.toml
	eapply_user
}
