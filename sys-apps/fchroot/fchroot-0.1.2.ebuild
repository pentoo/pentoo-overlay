# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 eutils

DESCRIPTION="Funtoo's franken-chroot tool"
HOMEPAGE="https://pypi.org/project/fchroot/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

RDEPEND=""
DEPEND="${RDEPEND}"

#FIXME:
#QEMU_USER_TARGETS="aarch64 arm"
#app-emulation/qemu[qemu_targets_aarch64(+)]
#app-emulation/qemu static-user
#dev-libs/glib static-libs
#sys-apps/attr static-libs
#sys-libs/zlib static-libs
#dev-libs/libpcre static-libs
