# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{5,6} )

inherit eutils git-r3 python-r1

DESCRIPTION="A offensive security tool for reconnaissance and vulnerability scanning"
HOMEPAGE="https://github.com/j3ssie/Osmedeus"

EGIT_REPO_URI="https://github.com/j3ssie/Osmedeus"
EGIT_DOCS_URI=( "https://github.com/j3ssie/Osmedeus.wiki" )

#EGIT_3DPARTY_URI=(
#	"https://github.com/x90skysn3k/brutespray::v1.2.55"
#	"https://github.com/drwetter/testssl.sh"
#	"https://github.com/GerbenJavado/LinkFinder::5d2a412" # example
#	"https://github.com/sqlmapproject/sqlmap"
#	"https://github.com/RhinoSecurityLabs/SleuthQL"
#	"https://github.com/maurosoria/dirsearch"
#	"https://github.com/Nekmo/dirhunt"
#	"https://github.com/RUB-NDS/CORStest"
#	"https://github.com/nahamsec/JSParser"
#)
#
#WORDLIST_URI=(
#	"https://gist.githubusercontent.com/jhaddix/86a06c5dc309d08580a018c66354a056/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt -> ${P}_wordlist-all.txt"
#	"https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1mil-20000.txt -> ${P}_wordlist-subdomains-top1mil-20000.txt"
#	"https://gist.githubusercontent.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt -> ${P}_wordlist-content_discovery_all.txt"
#)
#
#SRC_URI="${WORDLIST_URI[@]}"

if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="v${PV}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/flask-cors[${PYTHON_USEDEP}]
	dev-python/flask-jwt[${PYTHON_USEDEP}]
	dev-python/flask-jwt-extended[${PYTHON_USEDEP}]
	dev-python/flask-restful[${PYTHON_USEDEP}]
	dev-python/python-libnmap[${PYTHON_USEDEP}]"

_doinit_module() {
	mkdir -p "${WORKDIR}"/assets/${PN} \
		&& touch "${WORKDIR}"/assets/${PN}/__init__.py \
		|| die 'filed to install!'

	for assets in ${@}; do
		mv ${assets} "${WORKDIR}"/assets/${PN} || die 'filed to install!'
	done
}

pkg_setup() {
	python_setup
}

src_unpack() {
	git-r3_src_unpack
	unset EGIT_COMMIT

	# for submodule_uri in ${EGIT_3DPARTY_URI[@]}; do
		# git-r3_fetch "${submodule_uri}"
		# git-r3_checkout "${submodule_uri}" "${WORKDIR}"/${submodule_uri/*\//}
	# done

	if use doc; then
		for docs_uri in ${EGIT_DOCS_URI[@]}; do
			git-r3_fetch "${docs_uri}"
			git-r3_checkout "${docs_uri}" "${S}"/docs
		done
	fi
}

src_prepare() {
	# WHY??
	# def flask_run():
	#     utils.print_banner("Starting Flask API")
	#     os.system('python3 core/app.py')
	sed -e "s:python3 core/app.py:python3 $(python_get_sitedir)/${PN}/core/app.py:" \
		-i osmedeus.py || die 'sed failed!'

	python_fix_shebang "${S}"
	eapply_user
}

src_install() {
	elog "Installing python bindings..."
	python_foreach_impl _doinit_module core modules osmedeus.py
	python_domodule "${WORKDIR}"/assets/${PN}

	#insinto /usr/share/${PN}/wordlist
	#doins -r "${DISTDIR}"/*.txt

	make_wrapper ${PN} \
		"python3 $(python_get_sitedir)/${PN}/osmedeus.py"

	dodoc \
		CONTRIBUTING.md \
		CREDITS.md \
		README.md \
		template-config.conf \
		$(use doc && echo docs/*)
}

pkg_postinst() {
	elog
	elog "See documentation: https://github.com/j3ssie/Osmedeus#how-to-use"
	elog
}
