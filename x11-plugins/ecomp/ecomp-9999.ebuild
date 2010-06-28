# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://github.com/jeffdameth/ecomp.git"
inherit git libtool flag-o-matic

DESCRIPTION="e17 window manager with compiz"
HOMEPAGE="http://code.google.com/p/itask-module/wiki/Stuff
http://web.enlightenment.org/"

LICENSE="BSD"
SLOT="0"
IUSE="local pam nls doc"

RDEPEND="x11-plugins/ecomorph"

DEPEND="${RDEPEND}
   x11-proto/xproto
   sys-devel/libtool"

src_unpack() {
   git_src_unpack
}

src_compile() {
   # We need to filter the --as-needed LDFLAG since it breaks ecomp on runtime
   filter-ldflags "-Wl,--as-needed"
   filter-ldflags "-Wl,-O1"
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
   use local && MY_ECONF="$MY_ECONF --prefix=/usr/local"
   epunt_cxx
   elibtoolize
   econf ${MY_ECONF} || die "econf failed"
   emake || die "emake failed"
   use doc && [[ -x ./gendoc ]] && { ./gendoc || die "gendoc failed" ; }
}


src_install() {
   emake install DESTDIR="${D}" || die
   find "${D}" '(' -name CVS -o -name .svn -o -name .git ')' -type d -exec rm -rf '{}' \; 2>/dev/null
   dodoc AUTHORS ChangeLog NEWS README TODO
   use doc && [[ -d doc ]] && dohtml -r doc/*
}
