# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit git-2 udev distutils-r1 multilib

DESCRIPTION="command line rfid interface"
HOMEPAGE="https://github.com/ApertureLabsLtd/RFIDler"
EGIT_REPO_URI="https://github.com/ApertureLabsLtd/RFIDler.git"
EGIT_COMMIT="b30180f973491813f22e2fe910f94e9e2a480a91"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="udev"

DEPEND=""
RDEPEND="dev-python/pyserial
	dev-python/matplotlib"

python_compile(){
	cd python
	distutils-r1_python_compile
}

python_install(){
	cd python
	esetup.py install \
		--root="${D}" \
		--prefix="${EPREFIX}/usr"
}

src_install() {
	python_install
	#install udev rules
	udev_dorules "${S}/linux-support/71-rfidler-lf-cdc-blacklist.rules"
}

pkg_postinst() {
	udev_reload
	einfo
	einfo "Depends on your hardware, you might have the following new devices:"
	einfo "/dev/RFIDlerBL"
	einfo "/dev/RFIDler"
	einfo "/dev/ttyACM0 (here might be a bug in the provided udev rule)"
}
