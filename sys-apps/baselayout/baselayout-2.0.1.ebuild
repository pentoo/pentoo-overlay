# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout/baselayout-2.0.1.ebuild,v 1.2 2010/01/15 02:45:10 vapier Exp $

inherit multilib

DESCRIPTION="Filesystem baselayout and init scripts"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~vapier/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="build +pentoo"

PDEPEND="sys-apps/openrc"

pkg_preinst() {
	# Bug #217848 - Since the remap_dns_vars() called by pkg_preinst() of
	# the baselayout-1.x ebuild copies all the real configs from the user's
	# /etc/conf.d into ${D}, it makes them all appear to be the default
	# versions. In order to protect them from being unmerged after this
	# upgrade, modify their timestamps.
	touch "${ROOT}"/etc/conf.d/* 2>/dev/null

	# We need to install directories and maybe some dev nodes when building
	# stages, but they cannot be in CONTENTS.
	# Also, we cannot reference $S as binpkg will break so we do this.
	if use build ; then
		local libdirs="$(get_all_libdirs)" dir=
		# Create our multilib dirs - the Makefile has no knowledge of this
		: ${libdirs:=lib}	# it isn't that we don't trust multilib.eclass...
		for dir in ${libdirs}; do
			mkdir -p "${ROOT}${dir}"
			touch "${ROOT}${dir}"/.keep
			mkdir -p "${ROOT}usr/${dir}"
			touch "${ROOT}usr/${dir}"/.keep
			mkdir -p "${ROOT}usr/local/${dir}"
			touch "${ROOT}usr/local/${dir}"/.keep
		done

		# Create symlinks for /lib, /usr/lib, and /usr/local/lib and
		# merge contents of duplicate directories if necessary.
		# Only do this when $ROOT != / since it should only be necessary
		# when merging to an empty $ROOT, and it's not very safe to perform
		# this operation when $ROOT = /.
		if [ "${SYMLINK_LIB}" = yes ] && [ "$ROOT" != / ] ; then
			local prefix libabi=$(get_abi_LIBDIR $DEFAULT_ABI)
			for prefix in "$ROOT"{,usr/,usr/local/} ; do

				[ ! -d "${prefix}lib" ] && rm -f "${prefix}lib" && \
					mkdir -p "${prefix}lib"

				[ ! -d "$prefix$libabi" ] && ln -sf "${prefix}lib"

				[ -h "$prefix$libabi" ] && [ -d "${prefix}lib" ] && \
					[ "$prefix$libabi" -ef "${prefix}lib" ] && continue

				local destdir=$prefix$libabi/ srcdir=${prefix}lib/

				[ -d "$destdir" ] || die "unable to create '$destdir'"
				[ -d "$srcdir" ] || die "unable to create $srcdir"

				mv -f "$srcdir".keep "$destdir".keep 2>/dev/null
				if ! rmdir "$srcdir" 2>/dev/null ; then
					ewarn "merging contents of '$srcdir' into '$destdir':"

					# Move directories if the dest doesn't exist.
					find "$srcdir" -type d -print0 | \
					while read -d $'\0' src ; do

						# If a parent directory of $src has already
						# been merged then it will no longer exist.
						[ -d "$src" ] || continue

						dest=$destdir${src#${srcdir}}
						if [ ! -d "$dest" ] ; then
							if [ -e "$dest" ] ; then
								ewarn "  not overwriting file '$dest'" \
									"with directory '$src'"
								continue
							fi
							mv -f "$src" "$dest" && \
								ewarn "  /${src#${ROOT}} merged" || \
								ewarn "  /${src#${ROOT}} not merged"
						fi
					done

					# Move non-directories.
					find "$srcdir" ! -type d -print0 | \
					while read -d $'\0' src ; do
						dest=$destdir${src#${srcdir}}
						if [ -e "$dest" ] ; then
							if [ -d "$dest" ] ; then
								ewarn "  not overwriting directory '$dest'" \
									"with file '$src'"
							else
								if [ -f "$src" -a ! -s "$src" ] && \
									[ -f "$dest" -a ! -s "$dest" ] ; then
									# Ignore empty files such as '.keep'.
									true
								else
									ewarn "  not overwriting file '$dest'" \
										"with file '$src'"
								fi
							fi
							continue
						fi

						mv -f "$src" "$dest" && \
							ewarn "  /${src#${ROOT}} merged" || \
							ewarn "  /${src#${ROOT}} not merged"
					done
				fi

				rm -rf "${prefix}lib" || \
					die "unable to remove '${prefix}lib'"

				ln -s "$libabi" "${prefix}lib" || \
					die "unable to create '${prefix}lib' symlink"
			done
		fi

		emake -C "${D}/usr/share/${PN}" DESTDIR="${ROOT}" layout || die "failed to layout filesystem"
	fi
	rm -f "${D}"/usr/share/${PN}/Makefile
}

src_install() {
	local libdir="lib"
	[[ ${SYMLINK_LIB} == "yes" ]] && libdir=$(get_abi_LIBDIR "${DEFAULT_ABI}")

	emake \
		OS=$(use kernel_FreeBSD && echo BSD || echo Linux) \
		LIB=${libdir} \
		DESTDIR="${D}" \
		install || die
	dodoc ChangeLog

	# need the makefile in pkg_preinst
	insinto /usr/share/${PN}
	doins Makefile || die

	# Should this belong in another ebuild? Like say binutils?
	# List all the multilib libdirs in /etc/env/04multilib (only if they're
	# actually different from the normal
	if has_multilib_profile || [ $(get_libdir) != "lib" -o -n "${CONF_MULTILIBDIR}" ]; then
		local libdirs="$(get_all_libdirs)" libdirs_env= dir=
		: ${libdirs:=lib}	# it isn't that we don't trust multilib.eclass...
		for dir in ${libdirs}; do
			libdirs_env=${libdirs_env:+$libdirs_env:}/${dir}:/usr/${dir}:/usr/local/${dir}
		done

		# Special-case uglyness... For people updating from lib32 -> lib amd64
		# profiles, keep lib32 in the search path while it's around
		if has_multilib_profile && [ -d "${ROOT}"lib32 -o -d "${ROOT}"lib32 ] && ! hasq lib32 ${libdirs}; then
			libdirs_env="${libdirs_env}:/lib32:/usr/lib32:/usr/local/lib32"
		fi
		echo "LDPATH=\"${libdirs_env}\"" > "${T}"/04multilib
		doenvd "${T}"/04multilib
	fi

	# rc-scripts version for testing of features that *should* be present
	echo "Gentoo Base System release ${PV}" > "${D}"/etc/gentoo-release
	if use pentoo; then
		insinto /etc/
		doins "${FILESDIR}"/sysctl.conf
	fi
}

pkg_postinst() {
	local x

	# We installed some files to /usr/share/baselayout instead of /etc to stop
	# (1) overwriting the user's settings
	# (2) screwing things up when attempting to merge files
	# (3) accidentally packaging up personal files with quickpkg
	# If they don't exist then we install them
	for x in master.passwd passwd shadow group fstab ; do
		[ -e "${ROOT}etc/${x}" ] && continue
		[ -e "${ROOT}usr/share/baselayout/${x}" ] || continue
		cp -p "${ROOT}usr/share/baselayout/${x}" "${ROOT}"etc
	done

	# Force shadow permissions to not be world-readable #260993
	for x in shadow ; do
		[ -e "${ROOT}etc/${x}" ] && chmod o-rwx "${ROOT}etc/${x}"
	done

	# This is also written in src_install (so it's in CONTENTS), but
	# write it here so that the new version is immediately in the file
	# (without waiting for the user to do etc-update)
	rm -f "${ROOT}"/etc/._cfg????_gentoo-release
	local release="${PV}"
	[ "${PR}" != r0 ] && release="${release}-${PR}"
	echo "Gentoo Base System release ${release}" > "${ROOT}"/etc/gentoo-release

	# whine about users that lack passwords #193541
	if [[ -e ${ROOT}/etc/shadow ]] ; then
		local bad_users=$(sed -n '/^[^:]*::/s|^\([^:]*\)::.*|\1|p' "${ROOT}"/etc/shadow)
		if [[ -n ${bad_users} ]] ; then
			echo
			ewarn "The following users lack passwords!"
			ewarn ${bad_users}
		fi
	fi

	# whine about users with invalid shells #215698
	if [[ -e ${ROOT}/etc/passwd ]] ; then
		local bad_shells=$(awk -F: 'system("test -e " $7) { print $1 " - " $7}' /etc/passwd | sort)
		if [[ -n ${bad_shells} ]] ; then
			echo
			ewarn "The following users have non-existent shells!"
			ewarn "${bad_shells}"
		fi
	fi
}
