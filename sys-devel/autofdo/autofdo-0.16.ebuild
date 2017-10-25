# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="System to simplify real-world deployment of feedback-directed optimization"
HOMEPAGE="https://gcc.gnu.org/wiki/AutoFDO"
SRC_URI="https://github.com/google/autofdo/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-devel/llvm-4.0.1:*
	sys-devel/gcc:*"

RDEPEND="${DEPEND}"

src_prepare(){
	#has Google forgot got change it?
#	sed -i 's|\[0.14\]|\[${PV}\]|' configure.ac
	eautoreconf
	eapply_user
}