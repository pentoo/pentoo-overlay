# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Kismet WiFi data source shootout"
HOMEPAGE="https://github.com/deltj/kis_shootout_python.git"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/deltj/kis_shootout_python.git"
else
	COMMIT="ac635d8a15efa5b16d3c4f133ed63fb8545bffe3"
	SRC_URI="https://github.com/deltj/kis_shootout_python/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/kis_shootout_python-${COMMIT}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
PDEPEND="net-wireless/kismet-rest"
BDEPEND=""

src_install(){
	newbin shootout kismet_shootout
}
