# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-3.4.50.ebuild,v 1.1 2014/06/23 23:56:51 robbat2 Exp $

# genkernel-9999        -> latest Git branch "master"
# genkernel-VERSION     -> normal genkernel release

EAPI="3"

VERSION_BUSYBOX='1.21.0'
VERSION_DMRAID='1.0.0.rc16-3'
VERSION_MDADM='3.1.5'
VERSION_FUSE='2.8.6'
VERSION_ISCSI='2.0-872'
VERSION_LVM='2.02.88'
VERSION_UNIONFS_FUSE='0.24'
VERSION_GPG='1.4.11'

RH_HOME="ftp://sources.redhat.com/pub"
DM_HOME="http://people.redhat.com/~heinzm/sw/dmraid/src"
BB_HOME="http://www.busybox.net/downloads"

COMMON_URI="${DM_HOME}/dmraid-${VERSION_DMRAID}.tar.bz2
		${DM_HOME}/old/dmraid-${VERSION_DMRAID}.tar.bz2
		mirror://kernel/linux/utils/raid/mdadm/mdadm-${VERSION_MDADM}.tar.bz2
		${RH_HOME}/lvm2/LVM2.${VERSION_LVM}.tgz
		${RH_HOME}/lvm2/old/LVM2.${VERSION_LVM}.tgz
		${BB_HOME}/busybox-${VERSION_BUSYBOX}.tar.bz2
		http://www.open-iscsi.org/bits/open-iscsi-${VERSION_ISCSI}.tar.gz
		mirror://sourceforge/fuse/fuse-${VERSION_FUSE}.tar.gz
		http://podgorny.cz/unionfs-fuse/releases/unionfs-fuse-${VERSION_UNIONFS_FUSE}.tar.bz2
		mirror://gnupg/gnupg/gnupg-${VERSION_GPG}.tar.bz2"

EGIT_REPO_URI="https://anongit.gentoo.org/git/proj/${PN}.git"
EGIT_BRANCH="aufs"
inherit git-r3 bash-completion-r1 eutils
SRC_URI="${COMMON_URI}"
KEYWORDS="amd64 x86"

DESCRIPTION="Gentoo automatic kernel building scripts"
HOMEPAGE="http://www.gentoo.org"

LICENSE="GPL-2"
SLOT="0"
RESTRICT=""
IUSE="crypt cryptsetup ibm selinux"  # Keep 'crypt' in to keep 'use crypt' below working!

DEPEND="sys-fs/e2fsprogs
	selinux? ( sys-libs/libselinux )"
RDEPEND="${DEPEND}
		cryptsetup? ( sys-fs/cryptsetup )
		app-arch/cpio
		>=app-misc/pax-utils-0.2.1
		!<sys-apps/openrc-0.9.9"
# pax-utils is used for lddtree

DEPEND="${DEPEND} app-text/asciidoc"

src_prepare() {
	use selinux && sed -i 's/###//g' "${S}"/gen_compile.sh

	# Update software.sh
	sed -i \
		-e "s:VERSION_BUSYBOX:$VERSION_BUSYBOX:" \
		-e "s:VERSION_MDADM:$VERSION_MDADM:" \
		-e "s:VERSION_DMRAID:$VERSION_DMRAID:" \
		-e "s:VERSION_FUSE:$VERSION_FUSE:" \
		-e "s:VERSION_ISCSI:$VERSION_ISCSI:" \
		-e "s:VERSION_LVM:$VERSION_LVM:" \
		-e "s:VERSION_UNIONFS_FUSE:$VERSION_UNIONFS_FUSE:" \
		-e "s:VERSION_GPG:$VERSION_GPG:" \
		"${S}"/defaults/software.sh \
		|| die "Could not adjust versions"

	epatch "${FILESDIR}"/verify.patch
	epatch_user
}

#src_compile() {
#	if [[ ${PV} == 9999* ]]; then
#		emake || die
#	fi
#}

src_install() {
	insinto /etc
	doins "${S}"/genkernel.conf || die "doins genkernel.conf"

	doman genkernel.8 || die "doman"
	dodoc AUTHORS README TODO || die "dodoc"

	dobin genkernel || die "dobin genkernel"

	rm -f genkernel genkernel.8 AUTHORS ChangeLog README TODO genkernel.conf

	insinto /usr/share/genkernel
	doins -r "${S}"/* || die "doins"
	use ibm && cp "${S}"/ppc64/kernel-2.6-pSeries "${S}"/ppc64/kernel-2.6 || \
		cp "${S}"/arch/ppc64/kernel-2.6.g5 "${S}"/arch/ppc64/kernel-2.6

	# Copy files to /var/cache/genkernel/src
	GKDISTDIR=/usr/share/genkernel/distfiles/
	elog "Copying files to ${GKDISTDIR}..."
	insinto $GKDISTDIR
	doins "${DISTDIR}"/mdadm-${VERSION_MDADM}.tar.bz2
	doins "${DISTDIR}"/dmraid-${VERSION_DMRAID}.tar.bz2
	doins "${DISTDIR}"/LVM2.${VERSION_LVM}.tgz
	doins "${DISTDIR}"/busybox-${VERSION_BUSYBOX}.tar.bz2
	doins "${DISTDIR}"/fuse-${VERSION_FUSE}.tar.gz
	doins "${DISTDIR}"/unionfs-fuse-${VERSION_UNIONFS_FUSE}.tar.bz2
	doins "${DISTDIR}"/gnupg-${VERSION_GPG}.tar.bz2
	doins "${DISTDIR}"/open-iscsi-${VERSION_ISCSI}.tar.gz

	newbashcomp "${FILESDIR}"/genkernel.bash "${PN}"
	insinto /etc
	doins "${FILESDIR}"/initramfs.mounts
}

pkg_postinst() {
	echo
	elog 'Documentation is available in the genkernel manual page'
	elog 'as well as the following URL:'
	echo
	elog 'http://www.gentoo.org/doc/en/genkernel.xml'
	echo
	ewarn "This package is known to not work with reiser4.  If you are running"
	ewarn "reiser4 and have a problem, do not file a bug.  We know it does not"
	ewarn "work and we don't plan on fixing it since reiser4 is the one that is"
	ewarn "broken in this regard.  Try using a sane filesystem like ext3 or"
	ewarn "even reiser3."
	echo
	ewarn "The LUKS support has changed from versions prior to 3.4.4.  Now,"
	ewarn "you use crypt_root=/dev/blah instead of real_root=luks:/dev/blah."
	echo
	if use crypt && ! use cryptsetup ; then
		ewarn "Local use flag 'crypt' has been renamed to 'cryptsetup' (bug #414523)."
		ewarn "Please set flag 'cryptsetup' for this very package if you would like"
		ewarn "to have genkernel create an initramfs with LUKS support."
		ewarn "Sorry for the inconvenience."
		echo
	fi
}
