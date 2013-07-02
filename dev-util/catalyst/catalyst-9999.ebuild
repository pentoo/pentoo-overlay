# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/catalyst/catalyst-9999.ebuild,v 1.28 2013/04/13 07:04:57 mattst88 Exp $

# catalyst-9999         -> latest Git
# catalyst-2.9999       -> catalyst_2 branch from Git
# catalyst-3.9999       -> catalyst_3 branch from Git
# catalyst-VER          -> normal catalyst release

EAPI=3
PYTHON_DEPEND="2"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/catalyst.git"
	inherit git-2
	SRC_URI=""
	S="${WORKDIR}/${PN}"
	KEYWORDS=""

	case ${PV} in
		2.9999) EGIT_BRANCH="catalyst_2" ;;
		3.9999) EGIT_BRANCH="catalyst_3" ;;
	esac
else
	SRC_URI="mirror://gentoo/${P}.tar.bz2
		http://dev.gentoo.org/~jmbsvicetto/distfiles/${P}.tar.bz2"
	KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
fi
inherit eutils multilib python

DESCRIPTION="release metatool used for creating releases based on Gentoo Linux"
HOMEPAGE="http://www.gentoo.org/proj/en/releng/catalyst/"

LICENSE="GPL-2"
SLOT="0"
RESTRICT=""
IUSE="ccache kernel_linux"

DEPEND="app-text/asciidoc"
RDEPEND="app-arch/lbzip2
	app-crypt/shash
	virtual/cdrtools
	x86? ( >=sys-boot/syslinux-3.72 )
	amd64? ( >=sys-boot/syslinux-3.72 )
	ccache? ( dev-util/ccache )
	ia64? ( sys-fs/dosfstools )
	kernel_linux? ( app-misc/zisofs-tools >=sys-fs/squashfs-tools-2.1 )"

pkg_setup() {
	if use ccache ; then
		einfo "Enabling ccache support for catalyst."
	else
		ewarn "By default, ccache support for catalyst is disabled."
		ewarn "If this is not what you intended,"
		ewarn "then you should add ccache to your USE."
	fi
	echo
	einfo "The template spec files are now installed by default.  You can find"
	einfo "them under /usr/share/doc/${PF}/examples"
	einfo "and they are considered to be the authorative source of information"
	einfo "on catalyst."
	echo
	if [[ ${PV} == *9999* ]]; then
		ewarn "The ${EGIT_BRANCH:-master} branch (what you get with this ${PV} ebuild) contains"
		ewarn "work-in-progress code. Be aware that it's likely that it will not"
		ewarn "be in a working state at any given point. Please do not file bugs"
		ewarn "until you have posted on the gentoo-catalyst mailing list and we"
		ewarn "have asked you to do so."
	fi
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs 2 catalyst modules/catalyst_lock.py
	epatch "${FILESDIR}"/unfuck_firmware.patch
}

src_install() {
	insinto /usr/$(get_libdir)/${PN}
	exeinto /usr/$(get_libdir)/${PN}
	doexe catalyst || die "copying catalyst"
	if [[ ${PV} == 3.9999* ]]; then
		doins -r modules files || die "copying files"
	else
		doins -r arch modules livecd || die "copying files"
	fi
	for x in targets/*; do
		exeinto /usr/$(get_libdir)/${PN}/$x
		doexe $x/* || die "copying ${x}"
	done
	make_wrapper catalyst /usr/$(get_libdir)/${PN}/catalyst
	insinto /etc/catalyst
	doins files/catalyst.conf files/catalystrc || die "copying configuration"
	insinto /usr/share/doc/${PF}/examples
	doins examples/* || die
	dodoc README AUTHORS
	doman files/catalyst.1 files/catalyst-spec.5
	# Here is where we actually enable ccache
	use ccache && \
		dosed 's:options="autoresume kern:options="autoresume ccache kern:' \
		/etc/catalyst/catalyst.conf
	dosed "s:/usr/lib/catalyst:/usr/$(get_libdir)/catalyst:" \
		/etc/catalyst/catalyst.conf
}

pkg_postinst() {
	einfo "You can find more information about catalyst by checking out the"
	einfo "catalyst project page at:"
	einfo "http://www.gentoo.org/proj/en/releng/catalyst/index.xml"
	echo
}
