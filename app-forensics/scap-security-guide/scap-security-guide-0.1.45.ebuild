# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6} )

SSG_PRODUCTS=(
	+chromium +debian8 eap6 example +fedora +firefox fuse6
	jre ocp3 ol7 ol8 +opensuse rhel6 rhel7 rhel8 rhosp13
	rhv4 sle11 sle12 ubuntu1404 +ubuntu1604 +ubuntu1804
	wrlinux8 wrlinux1019
)

inherit cmake-utils python-r1

DESCRIPTION="Security compliance content in SCAP, Bash, Ansible, and other formats"
HOMEPAGE="https://www.open-scap.org/security-policies/scap-security-guide"

SRC_URI="https://github.com/ComplianceAsCode/content/archive/v${PV}.tar.gz -> ${P}.tar.gz"
#	ol8? ( https://linux.oracle.com/security/oval/com.oracle.elsa-all.xml.bz2 -> ${P}_com.oracle.elsa-all.xml.bz2 )
#	ol7? ( https://linux.oracle.com/security/oval/com.oracle.elsa-all.xml.bz2 -> ${P}_com.oracle.elsa-all.xml.bz2 )
#	ubuntu1604? ( https://people.canonical.com/~ubuntu-security/oval/com.ubuntu.xenial.cve.oval.xml.bz2 -> ${P}_com.ubuntu.xenial.cve.oval.xml.bz2 )
#	ubuntu1404? ( https://people.canonical.com/~ubuntu-security/oval/com.ubuntu.trusty.cve.oval.xml.bz2 -> ${P}_com.ubuntu.trusty.cve.oval.xml.bz2 )
#	rhel8? ( https://www.redhat.com/security/data/oval/com.redhat.rhsa-RHEL8.xml.bz2 -> ${P}_com.redhat.rhsa-RHEL8.xml.bz2 )
#	rhel7? ( https://www.redhat.com/security/data/oval/com.redhat.rhsa-RHEL7.xml.bz2 -> ${P}_com.redhat.rhsa-RHEL7.xml.bz2 )
#	rhel6? ( https://www.redhat.com/security/data/oval/com.redhat.rhsa-RHEL6.xml.bz2 -> ${P}_com.redhat.rhsa-RHEL6.xml.bz2 )"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT=0
IUSE="${SSG_PRODUCTS[*]} centos jinja2 linkchecker shellcheck scientific-linux test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND=""
DEPEND="${PYTHON_DEPS}
	app-forensics/openscap
	dev-libs/expat
	dev-libs/libxslt
	dev-libs/libxml2:2=
	app-admin/ansible[${PYTHON_USEDEP}]
	app-admin/ansible-lint[${PYTHON_USEDEP}]
	dev-python/json2html[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/yamllint[${PYTHON_USEDEP}]
	jinja2? ( dev-python/jinja[${PYTHON_USEDEP}] )
	linkchecker? ( net-analyzer/linkchecker )
	shellcheck? (
		|| (
			dev-util/shellcheck-bin
			dev-util/shellcheck
		)
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
	)"

S="${WORKDIR}"/content-${PV}
BUILD_DIR="${S}/build"

#src_unpack() {
#	local oval_db p
#
#	default
#
#	find "${WORKDIR}" -maxdepth 1 -name "${P}_*.xml" | while read p; do
#		oval_db=$(basename ${p})
#		elog "Vendoring: ${oval_db}"
#		mv "${p}" "${S}/${oval_db#${P}_}" || die
#	done
#}

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local product
	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR="/usr/share/doc/${P}"
		-DSSG_JINJA2_CACHE_DIR="${T}/jinja2_cache"
		-DSSG_SVG_IN_XCCDF_ENABLED='TRUE'
		-DSSG_SEPARATE_SCAP_FILES_ENABLED='TRUE'

		$(usex jinja2 \
			"-DSSG_JINJA2_CACHE_ENABLED='TRUE'" \
			"-DSSG_JINJA2_CACHE_ENABLED='FALSE'")
		$(usex centos \
			"-DSSG_CENTOS_DERIVATIVES_ENABLED='TRUE'" \
			"-DSSG_CENTOS_DERIVATIVES_ENABLED='FALSE'")
		$(usex scientific-linux \
			"-DSSG_SCIENTIFIC_LINUX_DERIVATIVES_ENABLED='TRUE'" \
			"-DSSG_SCIENTIFIC_LINUX_DERIVATIVES_ENABLED='FALSE'")
		$(usex test \
			"-DENABLE_PYTHON_COVERAGE='ON'" \
			"-DENABLE_PYTHON_COVERAGE='OFF'")
		$(usex linkchecker \
			"-DSSG_LINKCHECKER_VALIDATION_ENABLED='TRUE'" \
			"-DSSG_LINKCHECKER_VALIDATION_ENABLED='FALSE'")
		$(usex shellcheck \
			"-DSSG_SHELLCHECK_BASH_FIXES_VALIDATION_ENABLED='TRUE'" \
			"-DSSG_SHELLCHECK_BASH_FIXES_VALIDATION_ENABLED='FALSE'")
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

src_test() {
	cmake-utils_src_test
}
