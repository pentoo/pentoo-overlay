# /lib/rcscripts/addons/dm-crypt-stop.sh

# For backwards compatibility with baselayout < 1.13.0 #174256
: ${SVCNAME:=${myservice}}

# See notes in dm-crypt-start.sh
execute_hook="dm_crypt_execute_dmcrypt"
conf_file="dmcrypt"
case ${SVCNAME} in
	dmcrypt.*)  conf_file="${SVCNAME}" ;;
esac
conf_file="/etc/conf.d/${conf_file}"

# Try to remove any dm-crypt mappings
csetup=/sbin/cryptsetup
if [ -f "${conf_file}" ] && [ -x "$csetup" ]
then
	einfo "Removing dm-crypt mappings"

	/bin/egrep "^(target|swap)" "${conf_file}" | \
	while read targetline
	do
		target=
		swap=

		eval ${targetline}

		[ -n "${swap}" ] && target=${swap}
		[ -z "${target}" ] && ewarn "Invalid line in ${conf_file}: ${targetline}"

		ebegin "Removing dm-crypt mapping for: ${target}"
		${csetup} remove ${target}
		eend $? "Failed to remove dm-crypt mapping for: ${target}"
	done

	if /bin/egrep -q -e "^(source=)./dev/loop" "${conf_file}"; then
		einfo "Taking down any dm-crypt loop devices"
		/bin/egrep -e "^(source)" "${conf_file}" | while read sourceline
		do
			source=
			eval "${sourceline}"
			case "${source}" in
			*/dev/loop*)
				ebegin "   Taking down ${source}"
				/sbin/losetup -d ${source}
				eend $? "  Failed to remove loop"
			;;
			esac
		done
	fi
fi

# vim:ts=4
