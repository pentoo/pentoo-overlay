# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit subversion
KEYWORDS="-*"
DESCRIPTION="I rule your /etc/portage/* (this is the darkness binding part)"
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

	for i in keywords use mask unmask; do
		if [ ! -e "${ROOT}"/etc/portage/package.$i/user-$i ]; then
			if [ -e "${ROOT}"/etc/portage/package.$i ]; then
				if [ -f "${ROOT}"/etc/portage/package.$i ]; then 
					cp "${ROOT}"/etc/portage/package.$i "${T}"/user-$i
				elif [ -d "${ROOT}"/etc/portage/package.$i ]; then
					cp "${FILESDIR}"/user- "${D}"/etc/portage/package.$i/user-$i || die "Copy failed, blame Zero"
				else
					die "Something went wrong, /etc/portage/package.$i exists but is not file or directory"
				fi
			else
				dodir "${D}"/etc/portage/package.$i
				cp "${FILESDIR}"/user- "${D}"/etc/portage/package.$i/user-$i || die "Copy failed, blame Zero"
			fi
		fi
	done
}

pkg_preinst() {
	for i in keywords use mask unmask; do
		if [ -f "${T}"/user-$i ]; then
			rm -f "${ROOT}"/etc/portage/package.$i
			cp "${T}"/user-$i /etc/portage/package.$i/user-$i
			echo "/etc/portage/package.$i has been moved to /etc/portage/package.$i/user-$i"
		fi
	done
}
