# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwdata-redhat/hwdata-redhat-0.217.ebuild,v 1.1 2008/07/15 17:05:57 darkside Exp $

inherit flag-o-matic rpm

# Tag for which Fedora Core version it's from
FCVER="10"
# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1"

MY_P="${P/-redhat}"
DESCRIPTION="Hardware identification and configuration data"
HOMEPAGE="http://fedora.redhat.com/projects/config-tools/"
SRC_URI="mirror://fedora-dev/releases/10/Everything/source/SRPMS/${MY_P}-${RPMREV}.fc${FCVER}.src.rpm"
LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="-*"
IUSE="test"
RDEPEND=">=sys-apps/module-init-tools-3.2
	!sys-apps/hwdata-gentoo"
DEPEND="${RDEPEND}
	test? ( sys-apps/pciutils )"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	rpm_src_unpack ${A}

	cd "${S}"
	sed -i -e "s:\(/sbin\/lspci\):/usr\1:g" Makefile || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	# Don't let it overwrite a udev-installed file
	rm -rf "${D}"/etc/ || die
}
