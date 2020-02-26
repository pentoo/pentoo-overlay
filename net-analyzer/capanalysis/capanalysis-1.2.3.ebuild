# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils toolchain-funcs xdg-utils

DESCRIPTION="A web visual tool for information security specialists"
HOMEPAGE="https://www.capanalysis.net https://github.com/xplico/CapAnalysis"
SRC_URI="https://github.com/xplico/CapAnalysis/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT=0
IUSE=""

RDEPEND="
	dev-db/postgresql:11
	dev-db/sqlite:3
	dev-libs/openssl:0=
	net-analyzer/xplico
	net-libs/libpcap"

# vim-core (xxd) and jdk need for preparing a WebUI assets
DEPEND="${RDEPEND}
	app-editors/vim-core
	virtual/jdk
	virtual/pkgconfig"

S="${WORKDIR}"/CapAnalysis-${PV}

src_prepare() {
	# prepare WebUI assets
	./uipkg.sh || die

	# fix CFLAGS/LDFLAGS
	sed -e 's/ -O[0-3a-z]*//' \
		-e "s/^CFLAGS +=/CFLAGS += ${CFLAGS}/" \
		-e "s/^LDFLAGS +=/LDFLAGS += ${LDFLAGS}/" \
		-i Makefile || die
	sed -e 's/ -O[0-3a-z]*//' \
		-e "s/^CFLAGS =/CFLAGS = ${CFLAGS}/" \
		-e "s/^LDFLAGS =/LDFLAGS = ${LDFLAGS}/" \
		-i pcapseek/Makefile || die

	eapply_user
}

src_compile() {
	emake capanalysis CC="$(tc-getCC)"
	cd pcapseek || die
	emake pcapseek CC="$(tc-getCC)"
}

src_install() {
	local dist_dir="/opt/${PN}"

	exeinto "${dist_dir}"/bin
	doexe capanalysis pcapseek/pcapseek
	dosym \
		"../../xplico/bin/xplico" \
		"${dist_dir}/bin/xplico"

	find "/opt/xplico/bin/modules" -iname "*.so" -prune | while read l; do
		dosym \
			"../../../xplico/bin/modules/$(basename ${l})" \
			"${dist_dir}/bin/modules/$(basename ${l})"
	done

	insinto "${dist_dir}"/db
	doins -r db/*

	newins db/postgresql/items.sql postgres_items.sql
	newins db/postgresql/ips.sql postgres_ips.sql

	insinto "${dist_dir}"/cfg
	doins -r config/*

	insinto "${dist_dir}"/www
	doins -r wwwinst/*

	dosym \
		"../../..${dist_dir}/cfg/apache_capana.conf" \
		"/etc/apache2/vhosts.d/10_apache_capana.conf"

	dodir "${dist_dir}"/{log,tmp}

	fowners -R apache:apache "${dist_dir}"/{www,tmp}
	fperms -R g=u "${dist_dir}"/{www,tmp}

	newinitd "${FILESDIR}"/capanalysis.initd capanalysis

	domenu debian/applications/capanalysis.desktop
	dodoc README.md debian/changelog
}

pkg_config() {
	einfo "\nYou can modify options passed by editing:"
	einfo "    ${EROOT%/}/opt/${PN}/cfg/canalysis.cfg\n"
	[[ -f "${EROOT%/}/opt/${PN}/cfg/canalysis.cfg" ]] \
		&& source "${EROOT%/}/opt/${PN}/cfg/canalysis.cfg"

	DB_USER="${DB_USER:-capana}"
	DB_PASSWORD="${DB_PASSWORD:-123456}"

	einfo "Please provide a password for the postgres '${DB_USER}' user now"
	ewarn "Avoid [\"'\\_%] characters in the password:"
	read -rsp "    > " pswd1 ; echo
	einfo "Retype the password:"
	read -rsp "    > " pswd2 ; echo
	[[ "x$pswd1" == "x$pswd2" ]] || die "Passwords are not the same"
	DB_PASSWORD="${pswd2}"

	einfo "\nChecking postgresql-11 service ..."
	rc-service --ifexists -- postgresql-11 --ifstopped start

	einfo "\nInitializing the database ..."
	su postgres -c "psql -c \"CREATE ROLE ${DB_USER} WITH LOGIN ENCRYPTED PASSWORD '${DB_PASSWORD}';\""
	if ! su postgres -c "psql -lqt | cut -d \| -f 1 | grep -qw ${DB_NAME}"; then
		cd "${EROOT%/}/opt/${PN}/db/postgresql" && su postgres -c "psql -f create_db.sql"
	fi

	mkdir -p --mode 0770 "${EROOT%/}/opt/${PN}/www/app/tmp"/{cache/models,cache/persistent,logs,sessions} \
		|| die 'failed to create a "tmp" dir'
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update

	einfo "\nSteps"
	einfo "-----"
	einfo "1) Install and configure APACHE2 and PHP5 manually"
	einfo "Warning: You need to enable the \"access_compat\" module in APACHE2_MODULES=\"\" and enable \"pdo postgres\" use flags for PHP"
	einfo "    https://wiki.gentoo.org/wiki/Apache"
	einfo "    https://wiki.gentoo.org/wiki/PHP"
	einfo "\n2) Launch the command:"
	einfo "    ~$ sudo emerge --config net-analyzer/capanalysis"
	einfo "\n3) From file php.ini (/etc/php/apache2-<YOUR_PHP_VERSION>/php.ini) change the line:"
	einfo "        memory_limit = 128M"
	einfo "   to:"
	einfo "        memory_limit = 300M"
	einfo "\n4) Start the \"capanalysis\" service:"
	einfo "    ~$ sudo rc-service capanalysis start"
	einfo "\n5) Open in your browser: http://localhost:9877/capinstall\n"
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_desktop_database_update
}
