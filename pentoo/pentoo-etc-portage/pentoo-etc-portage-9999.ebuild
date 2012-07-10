# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
KEYWORDS="~amd64 ~arm ~x86"
DESCRIPTION="I rule your /etc/portage/* (this is the darkness binding part)"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE=""

DEPEND=">=app-admin/eselect-1.3.1
	>=sys-apps/portage-2.1.10.65"
RDEPEND=""

src_install() {
	if $(eselect profile show | grep -iq pentoo) ; then
		echo "You are running a Pentoo profile and should 'emerge -C pentoo-etc-portage'"
	else
		#insinto /etc/portage/
		#doins -r "${S}"/* || die "/etc/portage failed!"

		#/etc/portage/postsync.d
		#exeinto /etc/portage/postsync.d
		#doexe "${FILESDIR}"/pentoo-etc-portage || die "${EROOT}/etc/portage/postsync.d failure"
		echo "Bad, evil, naughty, Zoot!"
	fi
}

pkg_postinst() {
	if $(eselect profile show | grep -iq pentoo) ; then
		ewarn "You are running a pentoo profile and should 'emerge -C pentoo-etc-portage'"
		ewarn "No, seriously, do it now."
	else
		eerror "You are not running a pentoo profile.  If you wish for desired versions of"
		eerror "packages to be installed with desired use flags and generally simplified"
		eerror "usage you MUST switch to a pentoo profile *NOW*"
		eerror ""
		eerror "To do this type 'eselect profile list' and pick a profile that starts with"
		eerror "pentoo:"
		eerror "example: pentoo:pentoo/default/linux/amd64"
		eerror ""
		eerror "If no pentoo profile is available and you want to use one please report"
		eerror "to our bug tracker at https://code.google.com/p/pentoo/issues/list"
	fi
}
