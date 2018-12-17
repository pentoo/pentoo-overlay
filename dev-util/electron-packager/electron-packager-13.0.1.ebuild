# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Six Degrees of Domain Admin"
HOMEPAGE="https://github.com/BloodHoundAD/BloodHound"
SRC_URI="https://github.com/electron-userland/electron-packager//archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/electron-packager-13.0.1-npm-cache.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="net-libs/nodejs[npm]"
RDEPEND="${DEPEND}"

src_compile(){
	# For use in npm scripts (recommended)
#	npm install electron-packager --save-dev

	# For use from the CLI
	npm install electron-packager -g --prefix "${EPREFIX}" \
		--cache="${WORKDIR}/${P}-npm-cache"

#			sys-cluster/ceph
#		--offline --no-save --verbose --parseable \
#		--no-rollback --no-progress --fetch-retries=0 \
#		--nodedir="/usr/include/node" \
#		--cache="${WORKDIR}/${P}-npm-cache" \
#		--registry="http://npmjs.invalid" \
#		--sass-binary-site="http://sass.invalid"
}

src_install(){
	local npm_module_dir="/usr/$(get_libdir)/node_modules/npm/node_modules/${PN}"
	insinto "${npm_module_dir}"
	doins *.js package.json usage.txt
	doins -r lib64/node_modules/electron-packager/node_modules
	dodoc CONTRIBUTING.md readme.md

	use doc && dodoc -r docs

	fperms +x "${npm_module_dir}/cli.js"
	dosym "${npm_module_dir}/cli.js" "/usr/bin/${PN}"
}
