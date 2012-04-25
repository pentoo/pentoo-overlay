# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit subversion
KEYWORDS="~amd64 ~arm ~x86"
DESCRIPTION="I rule your /etc/portage/* (this is the darkness binding part)"
HOMEPAGE="http://www.pentoo.ch"
ESVN_REPO_URI="https://pentoo.googlecode.com/svn/livecd/trunk/portage/"
SLOT="0"
LICENSE="GPL"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	insinto /etc/portage/
	doins -r "${S}"/* || die "/etc/portage failed!"

	for i in keywords use mask unmask; do
		if [ ! -e "${EROOT}"/etc/portage/package.$i/user-$i ]; then
			if [ -e "${EROOT}"/etc/portage/package.$i ]; then
				if [ -f "${EROOT}"/etc/portage/package.$i ]; then 
					cp "${EROOT}"/etc/portage/package.$i "${T}"/user-$i
				elif [ -d "${EROOT}"/etc/portage/package.$i ]; then
					cp "${FILESDIR}"/user- "${ED}"/etc/portage/package.$i/user-$i || die "Copy failed, blame Zero"
				else
					die "Something went wrong, /etc/portage/package.$i exists but is not file or directory"
				fi
			else
				dodir /etc/portage/package.$i
				cp "${FILESDIR}"/user- "${ED}"/etc/portage/package.$i/user-$i || die "Copy failed, blame Zero"
			fi
		fi
	done

	#/etc/portage/postsync.d
	exeinto /etc/portage/postsync.d
	doexe "${FILESDIR}"/pentoo-etc-portage || die "${EROOT}/etc/portage/postsync.d failure"
}

pkg_preinst() {
	for i in keywords use mask unmask; do
		if [ -f "${T}"/user-$i ]; then
			rm -f "${EROOT}"/etc/portage/package.$i
			mkdir "${EROOT}"/etc/portage/package.$i
			cp "${T}"/user-$i ${EROOT}/etc/portage/package.$i/user-$i
			echo "${EROOT}/etc/portage/package.$i has been moved to /etc/portage/package.$i/user-$i"
		fi
	done
}

pkg_postinst() {
	ewarn "You very much likely need to run etc-update or dispatch-conf right now."
	ewarn "No, seriously, do it now."
}
