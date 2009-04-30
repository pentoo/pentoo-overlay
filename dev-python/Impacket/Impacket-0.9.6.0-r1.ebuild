DESCRIPTION="Impacket is a collection of Python classes focused on providing access to network packets."
HOMEPAGE="http://oss.coresecurity.com/projects/impacket.html"
SRC_URI="http://oss.coresecurity.com/repo/${P}.tar.gz"

inherit python

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="virtual/python"

DEPEND="${RDEPEND}"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	python_version
	insinto /usr/lib/python"${PYVER}"/site-packages/impacket
	doins impacket/*

	insinto ${INSDESTTREE}/dcerpc
	doins impacket/dcerpc/*

	dodoc ChangeLog LICENSE README doc/*

	docinto examples && dodoc examples/*
	cd examples && dosbin rpcdump.py samrdump.py smbclient.py smbcat.py
}

