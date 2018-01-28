# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="System to simplify real-world deployment of feedback-directed optimization"
HOMEPAGE="https://gcc.gnu.org/wiki/AutoFDO"
EGIT_REPO_URI="https://github.com/kim-phillips-arm/autofdo.git"
#EGIT_COMMIT=""
EGIT_BRANCH="fixissue55"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=sys-devel/llvm-5.0.1:*
	sys-devel/gcc:*"

RDEPEND="${DEPEND}"

src_configure(){
	econf --with-llvm
}
