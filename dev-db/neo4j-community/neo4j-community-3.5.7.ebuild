# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Neo4j is a high-performance, NOSQL graph database with all the features of a mature and robust database"
HOMEPAGE="https://neo4j.com/"
SRC_URI="https://dist.neo4j.org/${P}-unix.tar.gz"
LICENSE="GPL-3"
SLOT=0
KEYWORDS="~amd64 ~x86"

RDEPEND="
	!dev-db/neo4j-advanced
	!dev-db/neo4j-enterprise
	virtual/jre:="

src_prepare() {
	mv conf/neo4j.conf "${T}" || die

	# set absolute path
	sed -e "s:dbms.directories.import=import:dbms.directories.import=/var/lib/${PN}/import:" \
		-e "s:#dbms.directories.data=data:dbms.directories.data=/var/lib/${PN}/data:" \
		-e "s:#dbms.directories.plugins=plugins:#dbms.directories.plugins=/opt/${P}/plugins:" \
		-e "s:#dbms.directories.lib=lib:#dbms.directories.lib=/opt/${P}/lib:" \
		-e "s:#dbms.directories.certificates=certificates:dbms.directories.certificates=/var/lib/${PN}/certificates:" \
		-e "s:#dbms.directories.logs=logs:dbms.directories.logs=/var/log/${PN}:" \
		-e "s:#dbms.directories.run=run:dbms.directories.run=/run/neo4j-daemon:" \
		-i "${T}"/neo4j.conf || die "sed failed!"

	# cleanup
	rm -fr logs conf run data import LICENSE{,S}.txt || die

	default
}

src_install() {
	local dest_dir="/opt/${P}"

	dodir "${dest_dir}"
	cp -Rp . "${D}${dest_dir}" || die "failed to install!"

	insinto "/etc/${PN}"
	doins "${T}"/neo4j.conf

	keepdir "/var/log/${PN}" "/var/lib/${PN}"
	fowners -R nobody:nobody "/var/log/${PN}" "/var/lib/${PN}"
	fperms -R 750 "/var/lib/${PN}" "/var/log/${PN}"

	dodir "opt/bin"
	for x in $(find bin -type f -executable -printf "%f\n"); do
		cat > "${D}/opt/bin"/${x} <<-_EOF_ || die "cat EOF failed"
				#!/bin/sh

				JAVA_CMD="\${JAVA_CMD:-"/usr/bin/java"}"
				NEO4J_HOME="\${NEO4J_HOME:-"${dest_dir}"}"
				NEO4J_CONF="\${NEO4J_CONF:-"/etc/${PN}"}"
				NEO4J_DATA="\${NEO4J_DATA:-"/var/lib/${PN}/data"}"
				NEO4J_LIB="\${NEO4J_LIB:-"${dest_dir}/lib"}"
				NEO4J_LOGS="\${NEO4J_LOGS:-"/var/log/${PN}"}"
				NEO4J_PIDFILE="\${NEO4J_PIDFILE:-"/var/lib/${PN}/${PN%-community}.pid"}" # run it as user
				NEO4J_PLUGINS="\${NEO4J_PLUGINS:-"${dest_dir}/plugins"}"

				export JAVA_CMD NEO4J_HOME NEO4J_CONF NEO4J_DATA NEO4J_LIB NEO4J_LOGS NEO4J_PIDFILE NEO4J_PLUGINS

				ulimit -s 40000

				cd "${dest_dir}/bin" &&
				exec "${dest_dir}/bin/${x}" "\$@"
			_EOF_

		fperms 0755 "/opt/bin/${x}"
	done

	newinitd "${FILESDIR}"/neo4j-daemon.initd neo4j-daemon

	dodoc *.txt
}

pkg_postinst() {
	elog "\nJust run:"
	elog "    ~# rc-service neo4j-daemon start"
	elog "and open in browser http://localhost:7474/\n"
}
