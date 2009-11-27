# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="This ebuild should NEVER be installed, ever, for any reason"

HOMEPAGE="http://www.pentoo.ch"

LICENSE="BSD"

SLOT="0"

KEYWORDS="x86 amd64"

DEPEND="app-arch/cpio[-nls]
	app-arch/tar[-nls]
	app-shells/bash[-nls]
	dev-libs/popt[-nls]
	>=dev-python/lxml-2.2.3
	sys-apps/acl[-nls]
	sys-apps/attr[-nls]
	sys-apps/coreutils[-nls]
	sys-apps/diffutils[-nls]
	sys-apps/findutils[-nls]
	sys-apps/gawk[-nls]
	sys-apps/grep[-nls]
	sys-apps/kbd[-nls]
	sys-apps/man[-nls]
	sys-apps/man-pages[-nls]
	sys-apps/net-tools[-nls]
	sys-apps/sed[-nls]
	sys-apps/shadow[-nls]
	sys-apps/texinfo[-nls]
	sys-apps/util-linux[-nls]
	sys-devel/bison[-nls]
	sys-devel/binutils[-nls]
	sys-devel/flex[-nls]
	sys-devel/gcc[-nls]
	sys-devel/make[-nls]
	sys-fs/e2fsprogs[-nls]
	sys-libs/cracklib[-nls]
	sys-libs/e2fsprogs-libs[-nls]
	sys-libs/glibc[-nls]
	sys-libs/pam[-nls]
	sys-libs/timezone-data[-nls]
	sys-process/psmisc[-nls]
	"
RDEPEND="${DEPEND}"
