# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

SSG_PRODUCTS=(
	+chromium +debian8 eap6 example +fedora +firefox fuse6
	jre ocp3 ol7 ol8 +opensuse rhel6 rhel7 rhel8 rhosp13
	rhv4 sle11 sle12 ubuntu1404 +ubuntu1604 +ubuntu1804
	wrlinux8 wrlinux1019
)

inherit cmake python-single-r1

DESCRIPTION="Security compliance content in SCAP, Bash, Ansible, and other formats"
HOMEPAGE="https://www.open-scap.org/security-policies/scap-security-guide"
SRC_URI="https://github.com/ComplianceAsCode/content/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="${SSG_PRODUCTS[*]} centos +jinja2 shellcheck scientific-linux test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
	shellcheck? ( test )"

DEPEND="${PYTHON_DEPS}
	app-forensics/openscap
	dev-libs/expat
	dev-libs/libxslt
	dev-libs/libxml2:2
	$(python_gen_cond_dep '
		app-admin/ansible[${PYTHON_MULTI_USEDEP}]
		app-admin/ansible-lint[${PYTHON_MULTI_USEDEP}]
		dev-python/json2html[${PYTHON_MULTI_USEDEP}]
		dev-python/pyyaml[${PYTHON_MULTI_USEDEP}]
		dev-python/yamllint[${PYTHON_MULTI_USEDEP}]
	')
	jinja2? ( $(python_gen_cond_dep 'dev-python/jinja[${PYTHON_MULTI_USEDEP}]') )
	test? (
		$(python_gen_cond_dep 'dev-python/pytest[${PYTHON_MULTI_USEDEP}]')
		shellcheck? (
			|| ( dev-util/shellcheck-bin dev-util/shellcheck )
		)
	)"

S="${WORKDIR}/content-${PV}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	find "${S}" -name "*.py" | while read x; do
		sed -i -e "/^#!/s/python\(.*\)/python/" "$x" || die
	done

	python_fix_shebang -q "${S}"

	cmake_src_prepare
}

src_configure() {
	local product
	local mycmakeargs=(
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DCMAKE_INSTALL_DOCDIR="/usr/share/doc/${PF}"
		-DSSG_SVG_IN_XCCDF_ENABLED="yes"
		-DSSG_SEPARATE_SCAP_FILES_ENABLED="yes"
		-DSSG_JINJA2_CACHE_ENABLED="$(usex jinja2)"
		-DSSG_JINJA2_CACHE_DIR="${T}/jinja2_cache"
		-DSSG_CENTOS_DERIVATIVES_ENABLED="$(usex centos)"
		-DSSG_SCIENTIFIC_LINUX_DERIVATIVES_ENABLED="$(usex scientific-linux)"
		-DENABLE_PYTHON_COVERAGE="$(usex test)"
		-DSSG_SHELLCHECK_BASH_FIXES_VALIDATION_ENABLED="$(usex shellcheck)"
		-DSSG_LINKCHECKER_VALIDATION_ENABLED="no" # network is required
	)

	for x in ${SSG_PRODUCTS[@]}; do
		product="${x//[[:punct:]]/}"
		mycmakeargs+=( "-DSSG_PRODUCT_${product^^}=$(usex ${product})" )
	done

	# support building only in ./build directory
	# do not remove it without testing
	BUILD_DIR="${S}/build"

	cmake_src_configure
}
