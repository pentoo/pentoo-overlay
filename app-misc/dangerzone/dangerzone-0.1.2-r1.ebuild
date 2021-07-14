# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit eutils distutils-r1 xdg-utils

DESCRIPTION="Take potentially dangerous PDFs or images and convert them to a safe PDF"
HOMEPAGE="https://github.com/firstlookmedia/dangerzone"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/firstlookmedia/dangerzone"
else
	SRC_URI="https://github.com/firstlookmedia/dangerzone/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="policykit systemd"

DEPEND="${PYTHON_DEPS}
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/PyQt5[gui,widgets,${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	app-emulation/docker
	policykit? ( sys-auth/polkit )"

src_prepare() {
	default

	if ! use systemd; then
		cat > share/enable_docker_service.sh <<-_EOF_ || die
			#!/bin/sh
			/sbin/rc-service docker start --ifstopped
		_EOF_
	else
		cat > share/enable_docker_service.sh <<-_EOF_ || die
			#!/bin/sh
			/bin/systemctl restart docker.service
		_EOF_
	fi
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
