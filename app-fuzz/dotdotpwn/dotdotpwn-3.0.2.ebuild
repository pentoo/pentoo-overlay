# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="The Directory Traversal Fuzzer"
HOMEPAGE="http://dotdotpwn.blogspot.com"
SRC_URI="https://github.com/wireghoul/dotdotpwn/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="os-detection"

RDEPEND="dev-lang/perl
	virtual/perl-Time-HiRes
	dev-perl/Net-SSLeay
	dev-perl/IO-Socket-SSL
	dev-perl/HTTP-Message
	dev-perl/LWP-UserAgent-Determined
	os-detection? ( net-analyzer/nmap )"

#perl_site_lib() {
#	eval "$(perl -V:sitelib )"
#	SITE_LIB=${sitelib}
#}

src_prepare() {
	epatch "${FILESDIR}"/homedir.patch

	sed -i -e 's:DotDotPwn/User-Agents.txt:/etc/dotdotpwn/User-Agents.txt:' \
		DotDotPwn/HTTP.pm || die

	sed -i -e 's:DotDotPwn/User-Agents.txt:/etc/dotdotpwn/User-Agents.txt:' \
		DotDotPwn/HTTP_Url.pm || die
	eapply_user
}

#pkg_setup(){
#	PERL_MM_USE_DEFAULT=1 cpan -i HTTP::Lite
#	PERL_MM_USE_DEFAULT=1 cpan -i Net::FTP
#	PERL_MM_USE_DEFAULT=1 cpan -i TFTP
#	PERL_MM_USE_DEFAULT=1 cpan -i IO::Socket
#	PERL_MM_USE_DEFAULT=1 cpan -i Getopt::Std
#}

#src_compile() {
#	einfo "nothing to compile"
#	true
#}

src_install() {
#	perl_site_lib
	insinto /usr/$(get_libdir)/${PN}/
	doins -r DotDotPwn
	doins dotdotpwn.pl
	fperms +x /usr/$(get_libdir)/${PN}/${PN}.pl

	insinto /etc/dotdotpwn
	doins *.txt
	doins DotDotPwn/User-Agents.txt  || die "install user-agents file failed"
#	doins -r retrieved_files || die "install retrieved_files dir failed"

#	insinto /etc/dotdotpwn
#	doins -r Reports || die "install Reports dir failed"
#	fperms 777 /etc/dotdotpwn/Reports

	dobin "${FILESDIR}"/dotdotpwn
}
