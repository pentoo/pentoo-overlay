# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git mono multilib

DESCRIPTION="A GUI for aircrack-ng written in C#"
HOMEPAGE="http://sourceforge.net/projects/wepcrackgui/"
SRC_URI=""
EGIT_REPO_URI="git://wepcrackgui.git.sourceforge.net/gitroot/wepcrackgui/wepcrackgui"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug gtk qt4"

DEPEND="dev-lang/mono
		gtk? ( dev-dotnet/gtk-sharp )
		qt? ( kde-base/kdebindings-csharp )"
RDEPEND="${DEPEND}
		net-wireless/aircrack-ng
		net-wireless/mdk"

src_configure() {
	local _conf
	if use debug ; then
		_conf=DEBUG
	else
		_conf=RELEASE
	fi
	echo $_conf >> _conf
	./configure --prefix=/usr --config=$_conf
}

src_install() {
	local _rls
	if [[ $(cat _conf) == RELEASE ]]; then
		_rls=Release
	else
		_rls=Debug
	fi
	insinto /usr/$(get_libdir)/${PN}/
	doins WepCrack/bin/$_rls/Unbuffer.exe || die
	doins WepCrack/bin/$_rls/TestRun.exe || die
	doins WepCrack/bin/$_rls/WepCrack.dll || die
	doins WepCrack/bin/$_rls/WepCrackInterfaces.dll || die
	if use gtk ; then
		doins GWepCrackGui/bin/$_rls/GWepCrackGui.exe || die
		doins GWepCrackGui/bin/$_rls/WepCrackGtk.dll || die
		sed -i "s|./|/usr/$(get_libdir)/${PN}/|" GWepCrackGui/gwepcrack || die
		dobin GWepCrackGui/gwepcrack || die
	fi
	if use qt4 ; then
		doins QWepCrackGui/bin/$_rls/QWepCrackGui.exe || die
		doins QWepCrackGui/bin/$_rls/WepCrackQt.dll || die
		sed -i "s|./|/usr/$(get_libdir)/${PN}/|" QWepCrackGui/qwepcrack || die
		dobin QWepCrackGui/qwepcrack || die
	fi
	insinto /usr/share/${PN}/
	doins WepCrack/SSID.txt || die
	doins WepCrack/oui.txt || die
	insinto /usr/share/${PN}/wordlists
	doins WepCrack/wordlists/password.lst || die
	dodoc TODO README || die
}
