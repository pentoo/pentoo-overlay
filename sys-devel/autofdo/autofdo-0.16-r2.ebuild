# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils autotools

DESCRIPTION="System to simplify real-world deployment of feedback-directed optimization"
HOMEPAGE="https://gcc.gnu.org/wiki/AutoFDO"
SRC_URI="https://github.com/google/autofdo/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-devel/llvm-5.0.1:*
	sys-devel/gcc:*"

RDEPEND="${DEPEND}"

src_prepare(){
	#has Google forgot got change it?
	sed -i "s|\[0.14\]|\[${PV}\]|" configure.ac

	#https://github.com/google/autofdo/issues/55
	epatch "${FILESDIR}/0.16_issue55.patch"
	epatch "${FILESDIR}/72b7f86b920a35b02faed94afc685fd2d517fc78.patch"
	epatch "${FILESDIR}/0.16_issue55_2.patch"
	epatch "${FILESDIR}/f7ee8285dee9d47047bbcddd67a6027b59ec300d.patch"

	eautoreconf
	eapply_user
}

src_configure(){
	econf --with-llvm
}
