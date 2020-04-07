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
	S="${WORKDIR}/${P}/${PN}"
else
	SRC_URI="https://github.com/google/rekall"
	S="${WORKDIR}/${P}/${PN}"
fi

LICENSE="GPL-2"
SLOT="0"
# Removed keyword because this package installs incorrectly (see below).
KEYWORDS=""

DEPEND="${PYTHON_DEPS}"

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

RDEPEND="${DEPEND}"

S="${WORKDIR}/rekall-core-9999/rekall-core"

src_prepare() {
	#add "share" prefix for resources"
	sed -i 's|result.append((directory|result.append(("share/"+directory|' setup.py || die "Sed failed!"
	distutils-r1_src_prepare
}
