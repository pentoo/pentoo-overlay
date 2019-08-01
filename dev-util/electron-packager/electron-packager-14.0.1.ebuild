# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Six Degrees of Domain Admin"
HOMEPAGE="https://github.com/electron-userland/electron-packager"
SRC_URI="https://github.com/electron-userland/electron-packager/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/electron-packager-14.0.1-node_modules.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="net-libs/nodejs[npm]"
RDEPEND="${DEPEND}"

src_prepare(){
	mv ${WORKDIR}/node_modules ${S}
	eapply_user
}

src_compile(){
	# For use in npm scripts (recommended)
#	npm install electron-packager --save-dev

	# For use from the CLI
#	npm install electron-packager -g --prefix "${EPREFIX}" \
#		--cache="${WORKDIR}/${P}-npm-cache"

	npm build
# -g --prefix "${EPREFIX}"

#			sys-cluster/ceph
#		--offline --no-save --verbose --parseable \
#		--no-rollback --no-progress --fetch-retries=0 \
#		--nodedir="/usr/include/node" \
#		--cache="${WORKDIR}/${P}-npm-cache" \
#		--registry="http://npmjs.invalid" \
#		--sass-binary-site="http://sass.invalid"
}

src_install(){
	#this may be a wrong directory, but npm is a mess
	local npm_module_dir="/usr/$(get_libdir)/node_modules/${PN}"

	insinto "${npm_module_dir}"
	doins -r {bin,node_modules,src,package.json,usage.txt}
	dodoc CONTRIBUTING.md readme.md

	use doc && dodoc -r docs

	fperms +x "${npm_module_dir}/bin/electron-packager.js"
	dosym "${npm_module_dir}/bin/electron-packager.js" "/usr/bin/${PN}"
}
