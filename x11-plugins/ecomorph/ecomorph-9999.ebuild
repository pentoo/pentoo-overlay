# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: x11-plugins/ecomorph-9999 $

EAPI="2"
EGIT_REPO_URI="git://github.com/jeffdameth/ecomorph.git"
inherit git libtool flag-o-matic

DESCRIPTION="Ecomorph is a compositing manager for e17"
HOMEPAGE="http://code.google.com/p/itask-module/wiki/Stuff
http://web.enlightenment.org/"

LICENSE="BSD"
SLOT="0"
IUSE="-patches"

DEPEND=">=x11-wm/enlightenment-9999
      dev-libs/libxml2
      dev-libs/libxslt
      dev-util/intltool
      gnome-base/librsvg
      media-libs/mesa
      sys-apps/dbus
      sys-devel/libtool
      x11-proto/xproto"
RDEPEND="${DEPEND}
      sys-apps/pciutils
      x11-apps/mesa-progs
      x11-apps/xdpyinfo
      x11-apps/xvinfo"

src_unpack() {
   git_src_unpack
}

src_prepare() {
   cd "$S"/scripts
   if use patches; then
      # The following line allows you to pass arguments to
      # enlightenment_start.sh
      sed -i -e '/^enlightenment_start/s/$/ "\$@"/' enlightenment_start.sh
      sed -i -e 's:\$(lspci:\$(/usr/sbin/lspci:' ecomp.sh
   fi
   # Fix sandbox violation
   #epatch "${FILESDIR}/Makefile.patch"
}

src_configure() {
   # Try getting rid of segfaults and some non-functionalities
   filter-ldflags "-Wl,--as-needed"
   filter-ldflags "-Wl,-O1"

   if [[ ! -e configure ]] ; then
      env \
         PATH="${T}:${PATH}" \
         NOCONFIGURE=yes \
         USER=blah \
         ./autogen.sh \
         || die "autogen failed"
      # symlinked files will cause sandbox violation
      local x
      for x in config.{guess,sub} ; do
         [[ ! -L ${x} ]] && continue
         rm -f ${x}
         touch ${x}
      done
   else
      eautoreconf
   fi
   epunt_cxx
   elibtoolize
   econf ${MY_ECONF} || die "econf failed"
}

src_compile() {
   emake || die "emake failed"
}

src_install() {
   emake DESTDIR="${D}" install || die
   find "${D}" '(' -name CVS -o -name .svn -o -name .git ')' -type d -exec rm -rf '{}' \; 2>/dev/null
   dodoc AUTHORS ChangeLog NEWS README
} 
