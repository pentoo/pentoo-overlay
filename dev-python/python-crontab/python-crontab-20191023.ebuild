# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Crontab module for accessing system crontabs"
HOMEPAGE="https://gitlab.com/doctormo/python-crontab"

if [[ ${PV} = *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/doctormo/python-crontab.git"
else
	HASH_COMMIT="ba23056ddf1a00ecfd14b0a31c2e0cdad132f8d0"
	SRC_URI="https://gitlab.com/doctormo/python-crontab/repository/${HASH_COMMIT}/archive.tar.bz2 -> ${P}.tar.bz2"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${PN}-${HASH_COMMIT}-${HASH_COMMIT}"
