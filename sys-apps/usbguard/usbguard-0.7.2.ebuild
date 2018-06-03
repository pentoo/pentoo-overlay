# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools systemd

DESCRIPTION="The USBGuard software framework helps to protect your computer against BadUSB."
HOMEPAGE="https://github.com/dkopecek/usbguard"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_BRANCH="master"
	EGIT_REPO_URI="https://github.com/dkopecek/${PN}.git"
	EGIT_SUBMODULES=( src/ThirdParty/Catch src/ThirdParty/PEGTL src/ThirdParty/usbmon )
	KEYWORDS=""
else
	KEYWORDS="~x86 ~amd64"
	SRC_URI="https://github.com/USBGuard/usbguard/archive/${P}.tar.gz"
	S=${WORKDIR}/${PN}-${PN}-${PV}
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="crypt +dbus +policykit qt5 systemd"

DEPEND="sys-cluster/libqb
	sys-libs/libseccomp
	sys-libs/libcap-ng
	dev-libs/protobuf
	dev-ruby/asciidoctor
	dev-cpp/catch
	<=dev-libs/pegtl-2.0
	systemd? ( sys-apps/systemd )
	dbus? ( sys-apps/dbus
		dev-libs/dbus-glib )
	policykit? ( sys-auth/polkit )
	qt5? ( dev-qt/qtgui:5
		dev-qt/qtsvg:5
		dev-qt/qtwidgets:5
		dev-qt/qtcore:5 )
	crypt? ( || ( dev-libs/libgcrypt:0 dev-libs/libsodium ) )
	"

RDEPEND="${DEPEND}
	virtual/udev"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
#	local myconf=()
	econf $(use_enable systemd) \
		$(use_with dbus) \
		--with-gui-qt=$(usex qt5 qt5) \
		$(use_with policykit polkit) \
		--disable-dependency-tracking
#		"${myconf[@]}"
}

src_compile() {
	if use qt5; then
		export QT_SELECT=qt5
	fi

	emake
}

src_install() {
	emake DESTDIR="${D}" install

	if use systemd ; then
		systemd_dounit usbguard.service
	fi

	insinto /etc/usbguard
	doins usbguard-daemon.conf

	keepdir /var/lib/log/usbguard
}

pkg_postinst() {
	elog "You will need to allow access to your user for accessing the QT gui."
	elog "Execute as root. usbguard add-user YOUR_USERNAME --devices ALL --exceptions ALL"
}
