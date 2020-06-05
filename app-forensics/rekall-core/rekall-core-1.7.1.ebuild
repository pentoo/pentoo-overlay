# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit eutils distutils-r1

DESCRIPTION="Rekall Memory Forensic Framework"
HOMEPAGE="http://www.rekall-forensic.com/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/google/rekall"
else
	HASH_COMMIT="v${PV}"
	SRC_URI="https://github.com/google/rekall/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~x86"

# Commented out KEYWORDS because this ebuild installs files to /usr/resources,
# which is dirty, and because some deps are borked

RDEPEND="${DEPEND}"
DEPEND="
	>=app-forensics/yara-4.0.1[${PYTHON_USEDEP}]
	>=dev-python/acora-2.0[${PYTHON_USEDEP}]
	>=dev-python/arrow-0.10.0[${PYTHON_USEDEP}]
	>=dev-python/artifacts-20200515[${PYTHON_USEDEP}]
	>=dev-python/capstone-3.0.5[${PYTHON_USEDEP}]
	>=dev-python/dotty-1.5[${PYTHON_USEDEP}]
	>=dev-python/intervaltree-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/psutil-4.0[${PYTHON_USEDEP}]
	>=dev-python/pyaff4-0.27[${PYTHON_USEDEP}]
	>=dev-python/pyelftools-0.23[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.1.5[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.5.3[${PYTHON_USEDEP}]
	>=dev-python/pytz-4.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.11[${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-1.4.4[${PYTHON_USEDEP}]
"

#FIXME:
#    'PyYAML',
#    'acora==2.1',
#    'arrow==0.10.0',
#    'artifacts==20170909',
#    'future==0.16.0',
#    'intervaltree==2.1.0',
#    'ipaddr==2.2.0',
#    'parsedatetime==2.4',
#    "psutil >= 5.0, < 6.0",
#    'pyaff4 ==0.26.post6',
#    'pycryptodome==3.4.7',
#    'pyelftools==0.24',
#    'pyparsing==2.1.5',
#    'python-dateutil==2.6.1',
#    'pytsk3==20170802',
#    'pytz==2017.3',
#    'rekall-capstone==3.0.5.post2',
#    "rekall-efilter >= 1.6, < 1.7",
#    'pypykatz==0.0.8;python_version>="3.5"',

# Should match exactly the version of this package.
#    'rekall-lib',
#    'rekall-yara==3.6.3.1',

S="${WORKDIR}/rekall-${PV}/rekall-core"

#src_prepare() {
	#add "share" prefix for resources"
#	sed -i 's|result.append((directory|result.append(("share/"+directory|' setup.py || die "Sed failed!"
#	distutils-r1_src_prepare
#}
