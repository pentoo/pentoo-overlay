# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="archive of packetstorm exploits"
HOMEPAGE="http://packetstorm.wowhacker.com/"
SRC_URI="1999? ( http://packetstorm.wowhacker.com/9912-exploits/1999-exploits.tgz )
		 2000? ( http://packetstorm.wowhacker.com/0012-exploits/2000-exploits.tgz )
		 2001? ( http://packetstorm.wowhacker.com/0112-exploits/2001-exploits.tgz )
		 2002? ( http://packetstorm.wowhacker.com/0212-exploits/2002-exploits.tgz )
		 2003? ( http://packetstorm.wowhacker.com/0312-exploits/2003-exploits.tgz )
		 2004? ( http://packetstorm.wowhacker.com/0412-exploits/2004-exploits.tgz )
		 2005? ( http://packetstorm.wowhacker.com/0512-exploits/2005-exploits.tgz )
		 2006? ( http://packetstorm.wowhacker.com/0612-exploits/2006-exploits.tgz )
		 2007? ( http://packetstorm.wowhacker.com/0712-exploits/2007-exploits.tgz )
		 2008? ( http://packetstorm.wowhacker.com/0812-exploits/2008-exploits.tgz )
		 2009? ( http://packetstorm.wowhacker.com/0912-exploits/2009-exploits.tgz )
		 2010? ( http://packetstorm.wowhacker.com/1012-exploits/2010-exploits.tgz )
		 2011? ( http://packetstorm.wowhacker.com/1112-exploits/2011-exploits.tgz )
		 2012? ( http://packetstorm.wowhacker.com/1201-exploits/1201-exploits.tgz
			 http://packetstorm.wowhacker.com/1202-exploits/1202-exploits.tgz
			 http://packetstorm.wowhacker.com/1203-exploits/1203-exploits.tgz
			 http://packetstorm.wowhacker.com/1203-exploits/1203-exploits.tgz
			 http://packetstorm.wowhacker.com/1204-exploits/1204-exploits.tgz
			 http://packetstorm.wowhacker.com/1205-exploits/1205-exploits.tgz
			 http://packetstorm.wowhacker.com/1206-exploits/1206-exploits.tgz
			 http://packetstorm.wowhacker.com/1207-exploits/1207-exploits.tgz
			 http://packetstorm.wowhacker.com/1208-exploits/1208-exploits.tgz
			 http://packetstorm.wowhacker.com/1209-exploits/1209-exploits.tgz
			 http://packetstorm.wowhacker.com/1210-exploits/1210-exploits.tgz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86 arm"
IUSE="+1999 +2000 +2001 +2002 +2003 +2004 +2005 +2006 +2007 +2008 +2009 +2010
+2011 +2012"

DEPEND=""
RDEPEND=""

QA_PREBUILT="/usr/share/exploits/packetstormexploits/0001-exploits/bnc246
		/usr/share/exploits/packetstormexploits/0212-exploits/kadmin
		/usr/share/exploits/packetstormexploits/9902-exploits/SDI-lsof
		/usr/share/exploits/packetstormexploits/0204-exploits/7350fun"

src_install() {
	insinto /usr/share/exploits/$PN
	doins -r * || die "install failed"
}
