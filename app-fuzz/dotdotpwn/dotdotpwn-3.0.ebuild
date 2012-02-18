# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="The Directory Traversal Fuzzer."
HOMEPAGE="http://dotdotpwn.blogspot.com"
SRC_URI="http://www.brainoverflow.org/code/${PN}-v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="os-detection"

RDEPEND="dev-lang/perl
	perl-core/Switch
	dev-libs/openssl dev-perl/Net-SSLeay
	perl-core/Time-HiRes
	app-portage/g-cpan
	os-detection? ( net-analyzer/nmap )"

S=${WORKDIR}/${PN}-v${PV}

perl_site_lib() {
	eval "$(perl -V:sitelib )"
	SITE_LIB=${sitelib}
}

src_prepare() {
	sed -i -e 's:Reports:/etc/dotdotpwn/Reports:g' \
		dotdotpwn.pl || die

	sed -i -e 's:retrieved_files:/etc/dotdotpwn/retrieved_files:' \
		DotDotPwn/FTP.pm || die

	sed -i -e 's:retrieved_files:/etc/dotdotpwn/retrieved_files:' \
		DotDotPwn/TFTP.pm || die

	sed -i -e 's:DotDotPwn/User-Agents.txt:/etc/dotdotpwn/User-Agents.txt:' \
		DotDotPwn/HTTP.pm || die

	sed -i -e 's:DotDotPwn/User-Agents.txt:/etc/dotdotpwn/User-Agents.txt:' \
		DotDotPwn/HTTP_Url.pm || die
}

pkg_setup(){
	PERL_MM_USE_DEFAULT=1 cpan -i HTTP::Lite
	PERL_MM_USE_DEFAULT=1 cpan -i Net::FTP
	PERL_MM_USE_DEFAULT=1 cpan -i TFTP
	PERL_MM_USE_DEFAULT=1 cpan -i IO::Socket
	PERL_MM_USE_DEFAULT=1 cpan -i Getopt::Std
}

src_compile() {
	einfo "nothing to compile"
	true
}

src_install() {
	perl_site_lib
	insinto ${SITE_LIB}
	doins -r DotDotPwn || die "install DotDotPwn packages failed"

	insinto /etc/dotdotpwn
	doins *.txt  || die "install info and howto data failed"
	doins DotDotPwn/User-Agents.txt  || die "install user-agents file failed"
	doins -r retrieved_files || die "install retrieved_files dir failed"

	insinto /etc/dotdotpwn
	doins -r Reports || die "install Reports dir failed"
	fperms 777 /etc/dotdotpwn/Reports

	newbin dotdotpwn.pl dotdotpwn || die "install failed"
}
