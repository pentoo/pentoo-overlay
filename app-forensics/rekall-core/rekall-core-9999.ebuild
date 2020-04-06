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
RDEPEND="${DEPEND}"

src_prepare() {
	# WIP. This doens't work yet, but somethings needs to be fixed so that the
	# package doesn't install its 'resources' dir to '/usr/resources'.
	sed -i "s|^    data_files.*|    package_data={ 'rekall': ['../resources/**'] },|" setup.py || die "Sed failed!"
	distutils-r1_src_prepare
}
