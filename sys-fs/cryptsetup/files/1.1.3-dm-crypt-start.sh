# /lib/rcscripts/addons/dm-crypt-start.sh

# For backwards compatibility with baselayout < 1.13.0 #174256
: ${SVCNAME:=${myservice}}

# We might be hooked into init.d scripts (ala baselayout-1), or we might
# be a standalone dmcrypt script.  We support multiple dmcrypt instances,
# but they must start with "dmcrypt." to be detected that way.  It keeps
# our lives much simpler with this multiplexed arrangement.
execute_hook="dm_crypt_execute_dmcrypt"
conf_file="dmcrypt"
case ${SVCNAME} in
	localmount) execute_hook="dm_crypt_execute_localmount" ;;
	dmcrypt.*)  conf_file="${SVCNAME}" ;;
esac
conf_file="/etc/conf.d/${conf_file}"

# Setup mappings for an individual target/swap
# Note: This relies on variables localized in the main body below.
dm_crypt_execute_dmcrypt() {
	local dev ret mode foo
	# some colors
	local red='\033[31;01m' green='\033[32;01m' off='\033[0;0m'

	if [ -n "$target" ]; then
		# let user set options, otherwise leave empty
		: ${options:=' '}
	elif [ -n "$swap" ]; then
		einfo "Checking swap is not LUKS"
		cryptsetup isLuks ${source} 2>/dev/null
		foo="$?"
		if [ "${foo}" -eq 0 ]; then
		ewarn "The swap you have defined is a LUKS partition. Aborting crypt-swap setup."
		return
		fi
		target=${swap}
		# swap contents do not need to be preserved between boots, luks not required.
		# suspend2 users should have initramfs's init handling their swap partition either way.
		: ${options:='-c aes -h sha1 -d /dev/urandom'}
		: ${pre_mount:='mkswap ${dev}'}
	else
		return
	fi
	if [ -z "$source" ] && [ ! -e "$source" ]; then
		ewarn "source \"${source}\" for ${target} missing, skipping..."
		return
	fi

	if [ -n "${loop_file}" ] ; then
		dev="/dev/mapper/${target}"
		ebegin "  Setting up loop device ${source}"
		/sbin/losetup "${source}" "${loop_file}"
	fi

	# cryptsetup:
	# luksOpen <device> <name>      # <device> is $source
	# create   <name>   <device>    # <name>   is $target
	local arg1="create" arg2="$target" arg3="$source" luks=0

	cryptsetup isLuks ${source} 2>/dev/null && { arg1="luksOpen"; arg2="$source"; arg3="$target"; luks=1; }

	# Older versions reported:
	#	${target} is active:
	# Newer versions report:
	#	${target} is active[ and is in use.]
	if cryptsetup status ${target} | egrep -q ' is active' ; then
		einfo "dm-crypt mapping ${target} is already configured"
		return
	fi
	splash svc_input_begin ${SVCNAME} >/dev/null 2>&1

	# Handle keys
	if [ -n "$key" ]; then
		reset_stty() {
			stty ${savestty}
			trap - EXIT HUP INT TERM
		}
		read_abort() {
			local ans a b back
			printf " ${green}*${off}  %s? (${red}yes${off}/${green}No${off}) " "$1"
			back=" *  $1? (yes/No) "
			shift
			savestty=`stty -g`
			trap reset_stty EXIT HUP INT TERM
			stty -icanon -echo
			if [ "$1" = '-t' ] && [ "$2" -gt 0 ]; then
				stty min 0 time "$(( $2 * 10 ))"
			fi
			ans=`dd count=1 bs=1 2>/dev/null` || ans=''
			reset_stty
			if [ -z "${ans}" ]; then
				a=''
				b=''
				while [ -n "${back}" ]; do
					a="${a}"'\b'
					b="${b} "
					back=${back%?}
				done
				printf "${a}${b}${a}"
				return 1
			fi
			case "${ans}" in
				y*|Y*) printf "${red}YES${off}\n"; return 0;;
			esac
			printf "${green}No${off}\n"
			return 1
		}

		# Notes: sed not used to avoid case where /usr partition is encrypted.
		mode=${key##*:} && ( [ "$mode" = "$key" ] || [ -z "$mode" ] ) && mode=reg
		key=${key%%:*}
		case "$mode" in
		gpg|reg)
			# handle key on removable device
			if [ -n "$remdev" ]; then
				# temp directory to mount removable device
				local mntrem="${RC_SVCDIR}/dm-crypt-remdev.$$"
				if [ ! -d "${mntrem}" ] ; then
					if ! mkdir -p "${mntrem}" ; then
						ewarn "${source} will not be decrypted ..."
						einfo "Reason: Unable to create temporary mount point '${mntrem}'"
						return
					fi
				fi
				i=0
				einfo "Please insert removable device for ${target}"
				while [ ${i} -lt ${dmcrypt_max_timeout:-120} ] ; do
					foo=""
					if mount -n -o ro "${remdev}" "${mntrem}" 2>/dev/null >/dev/null ; then
						# keyfile exists?
						if [ ! -e "${mntrem}${key}" ]; then
							umount -n "${mntrem}"
							rmdir "${mntrem}"
							einfo "Cannot find ${key} on removable media."
							read_abort "Abort" ${read_timeout:--t 1} && return
						else
							key="${mntrem}${key}"
							break
						fi
					else
						[ -e "${remdev}" ] \
							&& foo="mount failed" \
							|| foo="mount source not found"
					fi
					i=$(( $i + 1 ))
					read_abort "Stop waiting after $i attempts (${foo})" -t 1 && return
				done
			else    # keyfile ! on removable device
				if [ ! -e "$key" ]; then
					ewarn "${source} will not be decrypted ..."
					einfo "Reason: keyfile ${key} does not exist."
					return
				fi
			fi
			;;
		*)
			ewarn "${source} will not be decrypted ..."
			einfo "Reason: mode ${mode} is invalid."
			return
			;;
		esac
	else
		mode=none
	fi
	ebegin "dm-crypt map ${target}"
	einfo "cryptsetup will be called with : ${options} ${arg1} ${arg2} ${arg3}"
	if [ "$mode" = "gpg" ]; then
		: ${gpg_options:='-q -d'}
		# gpg available ?
		if command -v gpg >/dev/null 2>&1; then
			local i=0
			while [ $i -lt 3 ]
			do
				# paranoid, don't store key in a variable, pipe it so it stays very little in ram unprotected.
				# save stdin stdout stderr "values"
				gpg ${gpg_options} ${key} 2>/dev/null | cryptsetup ${options} ${arg1} ${arg2} ${arg3}
				ret="$?"
				[ "$ret" -eq 0 ] && break
				i=$(( $i + 1 ))
			done
			eend "${ret}" "failure running cryptsetup"
		else
			ewarn "${source} will not be decrypted ..."
			einfo "Reason: cannot find gpg application."
			einfo "You have to install app-crypt/gnupg first."
			einfo "If you have /usr on its own partition, try copying gpg to /bin ."
		fi
	else
		if [ "$mode" = "reg" ]; then
			cryptsetup ${options} -d ${key} ${arg1} ${arg2} ${arg3}
			ret="$?"
			eend "${ret}" "failure running cryptsetup"
		else
			cryptsetup ${options} ${arg1} ${arg2} ${arg3}
			ret="$?"
			eend "${ret}" "failure running cryptsetup"
		fi
	fi
	if [ -d "$mntrem" ]; then
		umount -n "${mntrem}" 2>/dev/null >/dev/null
		rmdir "${mntrem}" 2>/dev/null >/dev/null
	fi
	splash svc_input_end ${SVCNAME} >/dev/null 2>&1

	if [ "${ret}" -ne 0 ] ; then
		cryptfs_status=1
	else
		if [ -n "${pre_mount}" ] ; then
			dev="/dev/mapper/${target}"
			ebegin "  Running pre_mount commands for ${target}"
			eval "${pre_mount}" > /dev/null
			ewend $? || cryptfs_status=1
		fi
	fi
}

# Run any post_mount commands for an individual mount
#
# Note: This relies on variables localized in the main body below.
dm_crypt_execute_localmount() {
	local mount_point

	[ -z "$target" ] && [ -z "$post_mount" ] && return

	if ! /sbin/cryptsetup status ${target} | egrep -q '\<active:' ; then
		ewarn "Skipping unmapped target ${target}"
		cryptfs_status=1
		return
	fi

	mount_point=$(grep "/dev/mapper/${target}" /proc/mounts | cut -d' ' -f2)
	if [ -z "${mount_point}" ] ; then
		ewarn "Failed to find mount point for ${target}, skipping"
		cryptfs_status=1
	fi

	if [ -n "${post_mount}" ] ; then
		ebegin "Running post_mount commands for target ${target}"
		eval "${post_mount}" >/dev/null
		eend $? || cryptfs_status=1
	fi
}

# Determine string lengths
strlen() {
	if [ -z "$1" ]
		then
			echo "usage: strlen <variable_name>"
			die
		fi
	eval echo "\${#${1}}"
}

# Lookup optional bootparams
parse_opt() {
	case "$1" in
		*\=*)
			local key_name=${1%%=*}
			local key_len=`strlen key_name`
			local value_start=$(( $key_len + 2 ))
			echo "$1" | cut -c ${value_start}-
		;;
	esac
}

local cryptfs_status=0
local gpg_options key loop_file target targetline options pre_mount post_mount source swap remdev

CMDLINE="`cat /proc/cmdline`"
for x in ${CMDLINE}
do
	case "${x}" in
		key_timeout\=*)
			KEY_TIMEOUT=`parse_opt "${x}"`
			if [ ${KEY_TIMEOUT} -gt 0 ]; then
				read_timeout="-t ${KEY_TIMEOUT}"
			fi
		;;
	esac
done

if [ -f "${conf_file}" ] && [ -x /sbin/cryptsetup ] ; then
	ebegin "Setting up dm-crypt mappings"

	while read targetline <&3 ; do
		# skip comments and blank lines
#		[[ ${targetline}\# == \#* ]] && continue

		# check for the start of a new target/swap
		case ${targetline} in
			''|'#'*)
				# skip comments and blank lines
				continue
				;;
			target=*|swap=*)
				# If we have a target queued up, then execute it
				${execute_hook}

				# Prepare for the next target/swap by resetting variables
				unset gpg_options key loop_file target options pre_mount post_mount source swap remdev
				;;

			gpg_options=*|remdev=*|key=*|loop_file=*|options=*|pre_mount=*|post_mount=*|source=*)
				if [ -z "${target}" ] && [ -z "${swap}" ] ; then
					ewarn "Ignoring setting outside target/swap section: ${targetline}"
					continue
				fi
				;;

			dmcrypt_max_timeout=*)
				# ignore global options
				continue
				;;

			*)
				ewarn "Skipping invalid line in ${conf_file}: ${targetline}"
				;;
		esac

		# Queue this setting for the next call to dm_crypt_execute_xxx
		eval "${targetline}"
	done 3< "${conf_file}"

	# If we have a target queued up, then execute it
	${execute_hook}

	ewend ${cryptfs_status} "Failed to setup dm-crypt devices"
fi

# vim:ts=4
