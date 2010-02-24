# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit subversion
KEYWORDS="-*"
DESCRIPTION="One ebuild to rule them all and in the darkness bind them"
HOMEPAGE="http://www.pentoo.ch"
ESVN_REPO_URI="https://www.pentoo.ch/svn/livecd/trunk/portage/"
SLOT="0"
LICENSE="GPL"
IUSE="livecd"

DEPEND=""

RDEPEND=""

pkg_setup() {
	#We clean up old mistakes here, don't add as a blocker
	grep -v 'x11-base/xorg-x11' /var/lib/portage/world > /var/lib/portage/world.cleansed
	local grepret=$?
	[ ${grepret} -ge 2 ] && [ -f ${ROOT}/var/lib/portage/world ] && die "Tried to grep the world file and got an error."
	[ ${grepret} == 0 ] && einfo "x11-base/xorg-x11 has been purged from world. It's a good thing."
	[ ${grepret} == 1 ] && einfo "x11-base/xorg-x11 was found not in the world file. It's a good thing."
	mv /var/lib/portage/world.cleansed /var/lib/portage/world || die "Fixing world failed"
}

src_install() {
	if ! use livecd; then
		insinto /etc/portage/
		doins -r "${S}"/* || die "/etc/portage failed!"
	fi
}

pkg_postinst() {
	if [ ! -e "${ROOT}"/etc/portage/package.keywords ]
		if [ -e "${ROOT}"/etc/portage/package.keywords ]
	if [ ! -e "${ROOT}"/etc/portage/package.keywords/user-keywords ]; then
		cp "${FILESDIR}"/user-keywords "${ROOT}"/etc/portage/package.keywords/user-keywords || die "Copy failed, blame Zero"
	fi
}

#pseudo code for checks

# if exist /etc/portage/example
	# if exist /etc/portage/example is file then copy to $T and put in new dir format
		# elif exist /etc/portage/example is dir
			# if ! exist /etc/portage/example/user-example then go for it
		# else break?
#else go for it
