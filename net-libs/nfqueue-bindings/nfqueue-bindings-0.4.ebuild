# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils linux-info cmake-utils

DESCRIPTION="Set of high-level modules for languages such as Perl or Python, for libnetfilter_queue"
HOMEPAGE="https://www.wzdftpd.net/redmine/projects/nfqueue-bindings"
#invalid cert: SRC_URI="https://www.wzdftpd.net/redmine/attachments/download/62/${P}.tar.gz"
SRC_URI="http://dev.pentoo.ch/~blshkv/distfiles/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
#mask due to invalid certificate in SRC_URI
KEYWORDS="~amd64 ~x86"
IUSE="perl python examples"

DEPEND=""
RDEPEND="python? (
	dev-lang/python
	dev-python/dpkt
	)
	perl? ( dev-lang/perl )
	net-libs/libnetfilter_queue
	dev-lang/swig"

pkg_setup() {
	# At least one of Python or Perl must be selected
	use python || use perl || die "At least one supported language must be selected."
	# Check kernel configuration for NFQUEUE
	if linux_config_exists; then
		ebegin "Checking NETFILTER_NETLINK_QUEUE support"
			linux_chkconfig_present NETFILTER_NETLINK_QUEUE
		eend $? || \
		eerror 'Netfilter NFQUEUE over NFNETLINK interface support not found!'
		ebegin "Checking NETFILTER_XT_TARGET_NFQUEUE support"
			linux_chkconfig_present NETFILTER_XT_TARGET_NFQUEUE
		eend $? || \
		eerror '"NFQUEUE" target Support not found!'
	fi
}

src_prepare() {
	#perl_set_version

	#upstream was smoking something
#	sed -i "s|PerlLibs2|PerlLibs|g" perl/CMakeLists.txt
	epatch "${FILESDIR}/0.4-perl.patch"
	rm FindPerlLibs2.cmake

	#python modules must be in the searchable path
	sed -i "s|dist-packages|site-packages|g" python/CMakeLists.txt

	#outdated
	epatch "${FILESDIR}/10-fix-ftbfs-uint32.patch"

#	# Disable Perl/Python from USE flags
	use perl || sed -i '/ADD_SUBDIRECTORY[[:space:]]*([[:space:]]*perl[[:space:]]*)/s/^/#/g' CMakeLists.txt
	use python || sed -i '/ADD_SUBDIRECTORY[[:space:]]*([[:space:]]*python[[:space:]]*)/s/^/#/g' CMakeLists.txt
}

src_install() {
	emake DESTDIR="${D}" install PREFIX=/usr
	docinto examples
	use examples && dodoc examples/*
}
