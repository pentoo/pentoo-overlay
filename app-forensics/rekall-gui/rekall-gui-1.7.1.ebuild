# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
    inherit git-r3
	EGIT_REPO_URI="https://github.com/google/rekall.git"
	EGIT_CHECKOUT_DIR="${WORKDIR}/rekall"
	S="${WORKDIR}/rekall/${PN}"
else
    HASH_COMMIT="v${PV}"
    SRC_URI="https://github.com/google/rekall/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/rekall-${PV}"
fi

DESCRIPTION="Rekall Memory Forensic Framework"
HOMEPAGE="http://www.rekall-forensic.com/"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64"  # WIP

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	app-forensics/rekall-core"
