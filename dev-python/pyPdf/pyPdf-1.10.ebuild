inherit distutils


S=${WORKDIR}/${PN}-${PV}
DESCRIPTION="A Pure-Python library built as a PDF toolkit."
HOMEPAGE="http://pybrary.net/pyPdf/"
SRC_URI="http://pybrary.net/pyPdf/${PN}-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""
DEPEND="dev-lang/python"

src_install() {
	distutils_src_install
	dodoc ${S}/{README}
}

