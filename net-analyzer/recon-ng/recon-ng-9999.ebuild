# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit python-r1 git-2 eutils

DESCRIPTION="Web Reconnaissance Framework"
HOMEPAGE="https://bitbucket.org/LaNMaSteR53/recon-ng"
EGIT_REPO_URI="https://bitbucket.org/LaNMaSteR53/recon-ng"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

src_prepare() {
	find ./ -name .git\* | xargs rm -rf
	sed -i recon-ng.py -i recon-cli.py -i recon-rpc.py -e "s:sys.path.append('./core/'):import os\nos.chdir(os.path.dirname(os.path.realpath(__file__)))\nsys.path.append('./core/'):g"
}

src_install () {
	dodir /usr/share/"${PN}"/
	cp -R * "${D}"/usr/share/"${PN}"/
	dosym /usr/share/"${PN}"/recon-rpc.py /usr/bin/recon-rpc
	dosym /usr/share/"${PN}"/recon-cli.py /usr/bin/recon-cli
	dosym /usr/share/"${PN}"/recon-ng.py /usr/bin/recon-ng
}
