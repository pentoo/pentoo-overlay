# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2


EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

if [[ ${PV} == *9999 ]] ; then
	SCM="git-r3"
	EGIT_REPO_URI="https://github.com/Veil-Framework/Veil.git${PN}.git"
fi

DESCRIPTION="A tool for payloads generation that bypass common anti-virus solutions"
HOMEPAGE="https://github.com/Veil-Framework/Veil"
SRC_URI="https://github.com/Veil-Framework/Veil/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="tools windows"

DEPEND=""
RDEPEND=">=dev-python/pycrypto-2.3
	dev-python/symmetricjsonrpc
	dev-python/pefile
	dev-python/capstone-python
	windows? (
		dev-python/pyinstaller
		dev-python/py2exe 
		# NOTE: Using Py2Exe is recommended over PyInstaller (as it has a lower detection rate).
		app-emulation/wine
	)
	tools? (
		dev-lang/go
		net-analyzer/metasploit )
	"

# FIXME:
#  mingw-w64 monodoc-browser monodevelop mono-mcs unzip ruby wget git \
#  ca-certificates ttf-mscorefonts-installer

S="${WORKDIR}/Veil-${PV}"

src_prepare() {
	#+os.path.expanduser(settings.PYINSTALLER_PATH + '/pyinstaller.py')+
	# os.path.expanduser(settings.PYINSTALLER_PATH + '/pyinstaller.py')
	sed -i "s|os.path.expanduser(settings.PYINSTALLER_PATH + '/pyinstaller.py')|'/usr/bin/pyinstall'|g" modules/common/supportfiles.py || die "sed failed"
}

src_install() {
	rm -r config/
	rm -r setup/

	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}/Veil.py

	#use our custom settings
	insinto /etc/veil
	newins "${FILESDIR}"/${PN}-settings.py settings.py

	dosym /usr/$(get_libdir)/veil-evasion/Veil.py /usr/bin/veil-evasion
}

pkg_postinst(){
	einfo "you need to setup wine env for pyinstaller & py2exe "
	einfo "py2exe less likely to get detected "
	einfo "wine msiexec /i python-2.7.12.msi"
}
