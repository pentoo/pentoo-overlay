# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A Python SDK for integrating with the Dropbox API v2."
HOMEPAGE="https://github.com/dropbox/dropbox-sdk-python"
SRC_URI="https://github.com/dropbox/${PN}-python/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-python-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

# some tests can be done to see if we can use a more recent version of stone depedency
RDEPEND="
	>=dev-python/requests-2.16.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.12.0[${PYTHON_USEDEP}]
	<dev-python/stone-3.3.3[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/mock-5.2.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-mock-3.14.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs dev-python/sphinx-rtd-theme
distutils_enable_tests pytest

python_prepare_all() {
	# deprecated
	sed -e '/setup_requires=setup_requires/d' -i setup.py
	sed -e '/tests_require=test_reqs/d' -i setup.py
	distutils-r1_python_prepare_all
}

# these tests are only online with authentification
EPYTEST_DESELECT=(
	'test/integration/test_dropbox.py::TestDropbox::test_multi_auth'
	'test/integration/test_dropbox.py::TestDropbox::test_refresh'
	'test/integration/test_dropbox.py::TestDropbox::test_app_auth'
	'test/integration/test_dropbox.py::TestDropbox::test_downscope'
	'test/integration/test_dropbox.py::TestDropbox::test_rpc'
	'test/integration/test_dropbox.py::TestDropbox::test_upload_download'
	'test/integration/test_dropbox.py::TestDropbox::test_bad_upload_types'
	'test/integration/test_dropbox.py::TestDropbox::test_clone_when_user_linked'
	'test/integration/test_dropbox.py::TestDropbox::test_with_path_root_constructor'
	'test/integration/test_dropbox.py::TestDropbox::test_path_root'
	'test/integration/test_dropbox.py::TestDropbox::test_path_root_err'
	'test/integration/test_dropbox.py::TestDropbox::test_versioned_route'
	'test/integration/test_dropbox.py::TestDropboxTeam::test_team'
	'test/integration/test_dropbox.py::TestDropboxTeam::test_as_user'
	'test/integration/test_dropbox.py::TestDropboxTeam::test_as_admin'
	'test/integration/test_dropbox.py::TestDropboxTeam::test_clone_when_team_linked'
)
