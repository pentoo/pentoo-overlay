# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-3.4.16.ebuild,v 1.7 2011/10/03 19:47:58 josejx Exp $

# genkernel-9999        -> latest Git branch "master"
# genkernel-VERSION     -> normal genkernel release

VERSION_BUSYBOX='1.19.3'
VERSION_DMAP='1.02.22'
VERSION_DMRAID='1.0.0.rc14'
VERSION_MDADM='3.1.4'
VERSION_E2FSPROGS='1.41.14'
VERSION_FUSE='2.7.4'
VERSION_ISCSI='2.0-872'
VERSION_LVM='2.02.74'
VERSION_UNIONFS_FUSE='0.22'
VERSION_GPG='1.4.11'

MY_HOME="http://wolf31o2.org"
RH_HOME="ftp://sources.redhat.com/pub"
DM_HOME="http://people.redhat.com/~heinzm/sw/dmraid/src"
BB_HOME="http://www.busybox.net/downloads"

COMMON_URI="${DM_HOME}/dmraid-${VERSION_DMRAID}.tar.bz2
		${DM_HOME}/old/dmraid-${VERSION_DMRAID}.tar.bz2
		mirror://kernel/linux/utils/raid/mdadm/mdadm-${VERSION_MDADM}.tar.bz2
		${RH_HOME}/lvm2/LVM2.${VERSION_LVM}.tgz
		${RH_HOME}/lvm2/old/LVM2.${VERSION_LVM}.tgz
		${RH_HOME}/dm/device-mapper.${VERSION_DMAP}.tgz
		${RH_HOME}/dm/old/device-mapper.${VERSION_DMAP}.tgz
		${BB_HOME}/busybox-${VERSION_BUSYBOX}.tar.bz2
		mirror://kernel/linux/kernel/people/mnc/open-iscsi/releases/open-iscsi-${VERSION_ISCSI}.tar.gz
		mirror://sourceforge/e2fsprogs/e2fsprogs-${VERSION_E2FSPROGS}.tar.gz
		mirror://sourceforge/fuse/fuse-${VERSION_FUSE}.tar.gz
		http://podgorny.cz/unionfs-fuse/releases/unionfs-fuse-${VERSION_UNIONFS_FUSE}.tar.bz2
		mirror://gnupg/gnupg/gnupg-${VERSION_GPG}.tar.bz2"


if [[ ${PV} == 9999* ]]
then
	[[ ${PV} == 9999.* ]] && ESVN_UPDATE_CMD="svn up -r ${PV/9999./}"
	ESVN_REPO_URI="https://pentoo.googlecode.com/svn/genkernel/trunk"
	inherit subversion bash-completion eutils
	S=${WORKDIR}/trunk
	SRC_URI="${COMMON_URI}"
else
	inherit bash-completion eutils
	SRC_URI="${MY_HOME}/genkernel/${P}.tar.bz2
		${COMMON_URI}"
fi

DESCRIPTION="Gentoo automatic kernel building scripts with pentoo patches"
HOMEPAGE="http://trac.pentoo.ch/wiki/Genkernel"

LICENSE="GPL-2"
SLOT="0"
RESTRICT=""
IUSE="ibm selinux"
KEYWORDS="-*"

DEPEND="sys-fs/e2fsprogs
	selinux? ( sys-libs/libselinux )"
RDEPEND="${DEPEND} app-arch/cpio"

if [[ ${PV} == 9999* ]]; then
	DEPEND="${DEPEND} app-text/asciidoc"
fi

src_unpack() {
	if [[ ${PV} == 9999* ]] ; then
		subversion_src_unpack
	else
		unpack ${P}.tar.bz2
	fi
	use selinux && sed -i 's/###//g' "${S}"/gen_compile.sh
}

src_compile() {
	if [[ ${PV} == 9999* ]]; then
		emake || die
	fi
}

src_install() {
	# This block updates genkernel.conf
	sed \
		-e "s:VERSION_BUSYBOX:$VERSION_BUSYBOX:" \
		-e "s:VERSION_DMAP:$VERSION_DMAP:" \
		-e "s:VERSION_MDADM:$VERSION_MDADM:" \
		-e "s:VERSION_DMRAID:$VERSION_DMRAID:" \
		-e "s:VERSION_E2FSPROGS:$VERSION_E2FSPROGS:" \
		-e "s:VERSION_FUSE:$VERSION_FUSE:" \
		-e "s:VERSION_ISCSI:$VERSION_ISCSI:" \
		-e "s:VERSION_LVM:$VERSION_LVM:" \
		-e "s:VERSION_UNIONFS_FUSE:$VERSION_UNIONFS_FUSE:" \
		-e "s:VERSION_GPG:$VERSION_GPG:" \
		"${S}"/genkernel.conf > "${T}"/genkernel.conf \
		|| die "Could not adjust versions"
	insinto /etc
	doins "${T}"/genkernel.conf || die "doins genkernel.conf"

	doman genkernel.8 || die "doman"
	dodoc AUTHORS ChangeLog README TODO || die "dodoc"

	dobin genkernel || die "dobin genkernel"

	rm -f genkernel genkernel.8 AUTHORS ChangeLog README TODO genkernel.conf

	insinto /usr/share/genkernel
	doins -r "${S}"/* || die "doins"
	use ibm && cp "${S}"/ppc64/kernel-2.6-pSeries "${S}"/ppc64/kernel-2.6 || \
		cp "${S}"/arch/ppc64/kernel-2.6.g5 "${S}"/arch/ppc64/kernel-2.6

	# Copy files to /var/cache/genkernel/src
	elog "Copying files to /var/cache/genkernel/src..."
	mkdir -p "${D}"/var/cache/genkernel/src
	cp -f \
		"${DISTDIR}"/mdadm-${VERSION_MDADM}.tar.bz2 \
		"${DISTDIR}"/dmraid-${VERSION_DMRAID}.tar.bz2 \
		"${DISTDIR}"/LVM2.${VERSION_LVM}.tgz \
		"${DISTDIR}"/device-mapper.${VERSION_DMAP}.tgz \
		"${DISTDIR}"/e2fsprogs-${VERSION_E2FSPROGS}.tar.gz \
		"${DISTDIR}"/busybox-${VERSION_BUSYBOX}.tar.bz2 \
		"${DISTDIR}"/fuse-${VERSION_FUSE}.tar.gz \
		"${DISTDIR}"/unionfs-fuse-${VERSION_UNIONFS_FUSE}.tar.bz2 \
		"${DISTDIR}"/gnupg-${VERSION_GPG}.tar.bz2 \
		"${DISTDIR}"/open-iscsi-${VERSION_ISCSI}.tar.gz \
		"${D}"/var/cache/genkernel/src || die "Copying distfiles..."

	dobashcompletion "${FILESDIR}"/genkernel.bash
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

	bash-completion_pkg_postinst
}
