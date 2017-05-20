# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit python-r1

DESCRIPTION="A virtual for scapy, for Python 2 & 3"
SLOT="0"
KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ppc ppc64 ~s390 ~sh sparc x86 ~amd64-linux ~x86-linux"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'net-analyzer/scapy[${PYTHON_USEDEP}]' python2*)
	$(python_gen_cond_dep 'dev-python/scapy-python3[${PYTHON_USEDEP}]' python3*)"
DEPEND="!!<net-analyzer/scapy-2.3.3-r1
	!!<dev-python/scapy-python3-0.19"

S=${WORKDIR}

src_install(){
	dobin ${FILESDIR}/scapy
	dobin ${FILESDIR}/UTscapy
	python_replicate_script ${D}/usr/bin/scapy
	python_replicate_script ${D}/usr/bin/UTscapy
}
