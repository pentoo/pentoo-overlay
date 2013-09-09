# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jdk/jdk-1.7.0.ebuild,v 1.10 2013/03/10 11:01:08 sera Exp $

DESCRIPTION="Virtual for Java Development Kit (JDK)"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="1.7"
KEYWORDS="~amd64 ~ia64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="|| (
		=dev-java/icedtea-7*
		=dev-java/icedtea-bin-7*
		=dev-java/oracle-jdk-bin-1.7.0*
		=dev-java/soylatte-jdk-bin-7*
	)"
DEPEND=""
