# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x

EAPI="2"
inherit subversion
KEYWORDS="~x86 ~amd64"
DESCRIPTION="One ebuild to rule them all and in the darkness bind them"
HOMEPAGE="http://www.pentoo.ch"
ESVN_REPO_URI="https://www.pentoo.ch/svn/livecd/trunk/portage/"
SLOT="0"
LICENSE="GPL"
IUSE="livecd dwm enlightenment kde"

RDEPEND="!x11-base/xorg-x11
	sys-apps/openrc[pentoo]
	dwm? ( x11-wm/dwm )
	enlightenment? ( x11-wm/enlightenment )
	kde? ( kde-base/kde-meta )"
DEPEND="${RDEPEND}"

pkg_setup() {
	#We clean up old mistakes here
	grep -v 'x11-base/x11-xorg' /var/lib/portage/world > /var/lib/portage/world.cleansed
	mv /var/lib/portage/world.cleansed /var/lib/portage/world
}

src_install() {
	if ! use livecd; then
		dodir /etc/
		dodir /etc/portage/
		cp -R "${S}/" "${D}/etc/portage/" || die "Install failed!"
	fi
}

pkg_postinstall() {
	if [ ! -e "${ROOT}"/etc/portage/package.keywords/user-keywords ]; then
		cp "${FILESDIR}"/user-keywords "${ROOT}"/etc/portage/package.keywords/user-keywords || die "Copy failed, blame Zero"
	fi

	elog "This ebuild is a meta ebuild to handle all the pentoo specific things which"
	elog "we can't figure out how to handle cleanly.  This will allow us our very own"
	elog "meta-package which can be used to make sure the installed users can be"
	elog "updated when we make fairly major changes.  This may not handle everything,"
	elog "but it is a start..."
}
