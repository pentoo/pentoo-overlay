# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit subversion
KEYWORDS="~x86 ~amd64"
DESCRIPTION="One ebuild to rule them all and in the darkness bind them"
HOMEPAGE="http://www.pentoo.ch"
ESVN_REPO_URI="https://www.pentoo.ch/svn/livecd/trunk/portage/"
SLOT="0"
LICENSE="GPL"
IUSE="dwm +enlightenment kde livecd xfce"

#System apps
RDEPEND="sys-apps/openrc[pentoo]
	dev-util/lafilefixer
	app-arch/sharutils
	app-crypt/gnupg
	sys-apps/hdparm"

#window makers
RDEPEND="${RDEPEND}
	dwm? ( x11-wm/dwm )
	enlightenment? ( x11-wm/enlightenment )
	kde? ( kde-base/kde-meta )
	xfce? ( xfce-base/xfce4-meta )"

DEPEND=""

pkg_setup() {
	#We clean up old mistakes here, don't add as a blocker
	grep -v 'x11-base/xorg-x11' /var/lib/portage/world > /var/lib/portage/world.cleansed
	local grepret=$?
	[ ${grepret} -ge 2 ] && [ -f ${ROOT}/var/lib/portage/world ] && die "Tried to grep the world file and got an error."
	[ ${grepret} == 0 ] && einfo "x11-base/xorg-x11 has been purged from world. It's a good thing."
	[ ${grepret} == 1 ] && einfo "x11-base/xorg-x11 was found not in the world file. It's a good thing."
	mv /var/lib/portage/world.cleansed /var/lib/portage/world || die "Fixing world failed"

	#pam_pwdb and pam_console are no longer supported
	grep -v pam_console "${ROOT}"/etc/pam.d/entrance > "${T}"/entrance
	local grepret=$?
	[ ${grepret} -ge 2 ] && [ -f "${ROOT}"/etc/pam.d/entrance ] && die "Tried to grep the pam files and got an error."
	[ ${grepret} == 0 ] && einfo "pam_console has been purged from /etc/pam.d/entrance. It's a good thing."
	[ ${grepret} == 1 ] && einfo "pam_console was not found in /etc/pam.d/entrance. It's a good thing"
	mv "${T}"/entrance "${ROOT}"/etc/pam.d/entrance
	grep pam_console "${ROOT}/etc/pam.d/*"
	local grepret=$?
        [ ${grepret} == 0 ] && die "pam_console still exists in /etc/pam.d/ and is no longer supported. Please remove all instances of it."
        [ ${grepret} == 1 ] && einfo "pam_console no longer exists in /etc/pam.d. It's a good thing."
	grep pam_pwdb "${ROOT}/etc/pam.d/*"
	local grepret=$?
        [ ${grepret} == 0 ] && die "pam_pwdb still exists in /etc/pam.d/ and is no longer supported. Please remove all instances of it."
        [ ${grepret} == 1 ] && einfo "pam_pwdb no longer exists in /etc/pam.d. It's a good thing."

}

src_install() {
	if ! use livecd; then
                insinto /etc/portage/
                doins -r "${S}"/* || die "/etc/portage failed!"
	fi

	##here is where we merge in things from root_overlay which make sense
	exeinto /root
	newexe "${FILESDIR}"/b43-commercial-${PV} b43-commercial || die "b43-commercial failed"
	insinto /root
	newins "${FILESDIR}"/motd-${PV} motd || die "motd failed"
	#/usr/bin
	newbin "${FILESDIR}"/dokeybindings-${PV} dokeybindings || die "dokeybindings failed"
	#/usr/sbin
	newsbin "${FILESDIR}"/flushchanges-${PV} flushchanges || die "flushchanges failed"
	newsbin "${FILESDIR}"/makemo-${PV} makemo || "makemo failed"
	insinto /etc
	newins "${FILESDIR}"/pentoo-release-2010.0-rc1 pentoo-release
}

pkg_postinst() {
	if [ ! -e "${ROOT}"/etc/portage/package.keywords/user-keywords ]; then
		cp "${FILESDIR}"/user-keywords "${ROOT}"/etc/portage/package.keywords/user-keywords || die "Copy failed, blame Zero"
	fi

	elog "This ebuild is a meta ebuild to handle all the pentoo specific things which"
	elog "we can't figure out how to handle cleanly.  This will allow us our very own"
	elog "meta-package which can be used to make sure the installed users can be"
	elog "updated when we make fairly major changes.  This may not handle everything,"
	elog "but it is a start..."

	ewarn "Significant changes have been made to your system, you must type 'etc-update'.
	ewarn "This command will help you merge the changed configuration files onto your system."
	epause "Seriously, stop what you are doing now and run 'etc-update'
}
