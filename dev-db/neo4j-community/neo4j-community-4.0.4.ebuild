# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="High-performance, mature and robust NOSQL graph database"
HOMEPAGE="https://neo4j.com/"
SRC_URI="https://dist.neo4j.org/${P}-unix.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"

# TODO: add support virtual/jre:11 (masked)
RDEPEND="
	acct-group/neo4j
	!dev-db/neo4j-advanced
	!dev-db/neo4j-enterprise
	virtual/jre"

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
	local limitsdfile="50-${PN}.conf"

	dodir "${dest_dir}"
	cp -Rp . "${D}${dest_dir}" || die "failed to install!"

	insinto "/etc/${PN}"
	doins "${T}"/neo4j.conf

	keepdir "/var/log/${PN}" "/var/lib/${PN}"
	fowners -R nobody:neo4j "/var/log/${PN}" "/var/lib/${PN}"
	fperms -R 750 "/var/lib/${PN}" "/var/log/${PN}"

	dodir "/opt/bin"
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

				cd "${dest_dir}/bin" &&
				exec "${dest_dir}/bin/${x}" "\$@"
			_EOF_

		fperms 0755 "/opt/bin/${x}"
	done

	dodir "/etc/security/limits.d"
	cat > "${D}/etc/security/limits.d"/${limitsdfile} <<-_EOF_ || die "cat EOF failed"
		# Start of ${limitsdfile} from ${P}
		# This is needed because neo4j can open a high number of file
		# descriptors
		@${PN%-community}  soft  nofile  40000
		@${PN%-community}  hard  nofile  40000
		# End of ${limitsdfile} from ${P}
	_EOF_

	newinitd "${FILESDIR}"/neo4j-daemon.initd-r1 neo4j-daemon
	newconfd "${FILESDIR}"/neo4j-daemon.confd neo4j-daemon

	dodoc *.txt
}

pkg_config() {
	local _yesno_ask

	ewarn "*** Please create a backup!!! ***"
	ewarn "Reset databases and log files for new configuring ..."
	read -r -p " [>] Are you sure? [y/N] " _yesno_ask

	if [[ ${_yesno_ask,,} =~ ^(yes|y)$ ]]; then
		ewarn "Remove: \"${EROOT}/var/lib/${PN}\" and \"${EROOT}/var/log/${PN}\" ..."
		read -r -p " [>] Continue? [y/N] " _yesno_ask
		if [[ ${_yesno_ask,,} =~ ^(yes|y)$ ]]; then
			rm -rf -- "${EROOT}/var/lib/${PN}" "${EROOT}/var/log/${PN}" || die
		fi

		ebegin "Preparing a new configuration for ${PF}"

		mkdir -p "${EROOT}/var/lib/${PN}" "${EROOT}/var/log/${PN}"
		chown nobody:neo4j "${EROOT}/var/lib/${PN}" "${EROOT}/var/log/${PN}"
		chmod 750 "${EROOT}/var/lib/${PN}" "${EROOT}/var/log/${PN}"

		touch \
			"${EROOT}/var/lib/${PN}/.keep_dev-db_neo4j-community-${SLOT}" \
			"${EROOT}/var/log/${PN}/.keep_dev-db_neo4j-community-${SLOT}"

		eend ${?} || die
	fi
}

pkg_postinst() {
	ewarn "\nFor upgrade instructions ('3.5.any' to '4.0.0'), please see:"
	ewarn "    https://neo4j.com/docs/operations-manual/current/upgrade/"
	ewarn "    https://neo4j.com/docs/migration-guide/4.0/"
	ewarn "\nAlso create a backup from \"/var/lib/${PN}\" and run:"
	ewarn "    ~# emerge --config \"=${CATEGORY}/${PF}\""
	ewarn "for new configuring"
	ewarn "\nWARNING: Use Oracle(R) Java(TM) 11, OpenJDK(TM) 11 to run ${PF} !!!"
	ewarn "    ~# emerge -avw dev-java/oracle-jdk-bin:11"
	ewarn "    ~# JAVA_CMD=\"/opt/openjdk-bin-<openjdk_version>/bin/java\" neo4j start"
	ewarn "or:"
	ewarn "    ~# echo JAVA_CMD=\"/opt/openjdk-bin-<openjdk_version>/bin/java\" >> /etc/conf.d/neo4j-daemon"
	ewarn "    ~# rc-service neo4j-daemon start\n"
	ewarn "Wait for few seconds and open in browser http://localhost:7474/\n"
}
