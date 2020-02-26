# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Small set of tools to generate plainmasterkeys (rainbowtables) and hashes for the use with latest hashcat and John the Ripper"
HOMEPAGE="https://github.com/ZerBea/hcxkeys"
MY_COMMIT="207746b3cb8a35daf8cde423e80c7b4dfe97db22"
SRC_URI="https://github.com/ZerBea/hcxkeys/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="dev-libs/openssl:*
	virtual/opencl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

src_install(){
	dobin wlangenpmk
	dobin wlangenpmkocl
	dobin pwhash
}
