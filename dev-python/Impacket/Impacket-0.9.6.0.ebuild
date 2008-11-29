DESCRIPTION="Impacket is a collection of Python classes focused on providing access to network packets."
HOMEPAGE="http://oss.coresecurity.com/projects/impacket.html"
SRC_URI="http://oss.coresecurity.com/repo/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="-* ~x86"

IUSE="examples"

RDEPEND="virtual/python"

DEPEND="${RDEPEND}"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	insinto /usr/lib/python2.4/site-packages/impacket
	doins impacket/*

	insinto ${INSDESTTREE}/dcerpc
	doins impacket/dcerpc/*

	dodoc ChangeLog LICENSE README PKG-INFO doc/*

	use examples && docinto examples && dodoc examples/*
}

