# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="System to simplify real-world deployment of feedback-directed optimization"
HOMEPAGE="https://gcc.gnu.org/wiki/AutoFDO"
#SRC_URI="https://github.com/google/autofdo/archive/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="https://github.com/google/autofdo/releases/download/0.19/0.19.tar.gz  -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-devel/llvm-5.0.1:*
	sys-devel/gcc:*"

RDEPEND="${DEPEND}"

src_prepare(){
	eapply "${FILESDIR}/disable-rpath.diff"
	eapply "${FILESDIR}/link-atomic.diff"
#	eapply "${FILESDIR}/link-libgflags.diff"
#	eapply "${FILESDIR}/link-libglog.diff"

	eautoreconf
	eapply_user
}

src_configure(){
	econf --with-llvm
}
