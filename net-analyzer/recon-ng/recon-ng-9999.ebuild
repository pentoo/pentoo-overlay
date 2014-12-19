# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit python-r1 git-2

DESCRIPTION="Web Reconnaissance Framework"
HOMEPAGE="https://bitbucket.org/LaNMaSteR53/recon-ng"
EGIT_REPO_URI="https://bitbucket.org/LaNMaSteR53/recon-ng"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

#src_prepare() {
#	find ./ -name .git\* | xargs rm -rf
#	sed -i recon-ng.py -i recon-cli.py -i recon-rpc.py -e "s:sys.path.append('./core/'):import os\nos.chdir(os.path.dirname(os.path.realpath(__file__)))\nsys.path.append('./core/'):g"
#}

src_install () {
	dodir /usr/share/"${PN}"/
	cp -R * "${D}"/usr/share/"${PN}"/
	dosym /usr/share/"${PN}"/recon-rpc /usr/bin/recon-rpc
	dosym /usr/share/"${PN}"/recon-cli /usr/bin/recon-cli
	dosym /usr/share/"${PN}"/recon-ng /usr/bin/recon-ng

	python_fix_shebang "${ED}"/usr/share/recon-ng/
}
