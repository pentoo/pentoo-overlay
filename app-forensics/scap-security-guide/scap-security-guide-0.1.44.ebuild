# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_BUILD_TYPE="Release"
PYTHON_COMPAT=( python3_{5,6} )

SSG_PRODUCTS=(
	+chromium +debian8 eap6 example +fedora +firefox fuse6
	jre ocp3 ol7 ol8 +opensuse rhel6 rhel7 rhel8 rhosp13
	rhv4 sle11 sle12 ubuntu1404 ubuntu1604 +ubuntu1804
	+wrlinux
)

inherit cmake-utils python-r1

DESCRIPTION="Security compliance content in SCAP, Bash, Ansible, and other formats"
HOMEPAGE="https://www.open-scap.org/security-policies/scap-security-guide"
SRC_URI="https://github.com/ComplianceAsCode/content/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="BSD"
SLOT=0

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
IUSE="${SSG_PRODUCTS[*]} centos scientific-linux"

S="${WORKDIR}"/content-${PV}

# In-source builds are not supported! Use out of source builds
BUILD_DIR="${S}/build"

RDEPEND=""
DEPEND="${PYTHON_DEPS}
	app-forensics/openscap
	dev-libs/expat
	dev-libs/libxslt
	dev-libs/libxml2:2=
	app-admin/ansible[${PYTHON_USEDEP}]
	app-admin/ansible-lint[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local product
	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR="/usr/share/doc/${P}"
		-DSSG_SEPARATE_SCAP_FILES_ENABLED='TRUE'
		-DSSG_JINJA2_CACHE_ENABLED='TRUE'

		# Please report if you realy need this
		-DSSG_LINKCHECKER_VALIDATION_ENABLED='FALSE'
		-DSSG_SHELLCHECK_BASH_FIXES_VALIDATION_ENABLED='FALSE'

		$(usex centos \
			"-DSSG_CENTOS_DERIVATIVES_ENABLED='TRUE'" \
			"-DSSG_CENTOS_DERIVATIVES_ENABLED='FALSE'")
		$(usex scientific-linux \
			"-DSSG_SCIENTIFIC_LINUX_DERIVATIVES_ENABLED='TRUE'" \
			"-DSSG_SCIENTIFIC_LINUX_DERIVATIVES_ENABLED='FALSE'")
	)

	for x in ${SSG_PRODUCTS[@]}; do
		product="${x//[[:punct:]]/}"
		mycmakeargs+=(
			$(usex $product \
				"-DSSG_PRODUCT_${product^^}='TRUE'" \
				"-DSSG_PRODUCT_${product^^}='FALSE'")
		)
	done

	cmake-utils_src_configure
}
