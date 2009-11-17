# /lib/rcscripts/addons/dm-crypt-start.sh
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cryptsetup/files/dm-crypt-start.sh,v 1.6 2006/04/12 02:52:43 vapier Exp $

# Setup mappings for an individual mount/swap
#
# Note: This relies on variables localized in the main body below.
dm-crypt-execute-checkfs() {
	local dev target ret

	if [[ -n ${loop_file} ]] ; then
		dev="/dev/mapper/${target}"
		ebegin "  Setting up loop device ${source}"
		/sbin/losetup ${source} ${loop_file} 
	fi

	if [[ -n ${mount} ]] ; then
		target=${mount}
		: ${options:='-c aes -h sha1'}
		[[ -n ${key} ]] && : ${gpg_options:='-q -d'}
	elif [[ -n ${swap} ]] ; then
		target=${swap}
		: ${options:='-c aes -h sha1 -d /dev/urandom'}
		: ${pre_mount:='mkswap ${dev}'}
	else
		return
	fi

	if /bin/cryptsetup status ${target} | egrep -q '\<active:' ; then
		einfo "dm-crypt mapping ${target} is already configured"
		return
	fi

	splash svc_input_begin checkfs
	ebegin "dm-crypt map ${target}"
	if [[ -z ${key} ]] ; then
		/bin/cryptsetup ${options} create ${target} ${source} >/dev/console </dev/console
		ret=$?
		eend ${ret} "failure running cryptsetup"
	else
		if type -p gpg >/dev/null ; then
			ret=1
			while [[ ${ret} -gt 0 ]] ; do
				keystring=$(gpg ${gpg_options} ${key} 2>/dev/null </dev/console)
				if [[ -z ${keystring} ]] ; then
					ret=5
				else
					echo ${keystring} | /bin/cryptsetup ${options} create ${target} ${source}
					ret=$?
				fi
			done
			eend ${ret}
		else
			einfo "You have to install app-crypt/gnupg first"
		fi
	fi
	splash svc_input_end checkfs

	if [[ ${ret} != 0 ]] ; then
		cryptfs_status=1
	else
		if [[ -n ${pre_mount} ]] ; then
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
dm-crypt-execute-localmount() {
	local mount_point target

	if [[ -n ${mount} && -n ${post_mount} ]] ; then
		target=${mount}
	else
		return
	fi

	if ! /bin/cryptsetup status ${target} | egrep -q '\<active:' ; then
		ewarn "Skipping unmapped target ${target}"
		cryptfs_status=1
		return
	fi

	mount_point=$(grep "/dev/mapper/${target}" /proc/mounts | cut -d' ' -f2)
	if [[ -z ${mount_point} ]] ; then
		ewarn "Failed to find mount point for ${target}, skipping"
		cryptfs_status=1
	fi

	if [[ -n ${post_mount} ]] ; then
		ebegin "Running post_mount commands for target ${target}"
		eval "${post_mount}" >/dev/null
		eend $? || cryptfs_status=1
	fi
}

local cryptfs_status=0 
local gpg_options key loop_file mount mountline options pre_mount post_mount source swap

if [[ -f /etc/conf.d/cryptfs ]] && [[ -x /bin/cryptsetup ]] ; then
	ebegin "Setting up dm-crypt mappings"

	while read mountline ; do
		# skip comments and blank lines
		[[ ${mountline}\# == \#* ]] && continue

		# check for the start of a new mount/swap
		case ${mountline} in
			mount=*|swap=*)
				# If we have a mount queued up, then execute it
				dm-crypt-execute-${myservice}

				# Prepare for the next mount/swap by resetting variables
				unset gpg_options key loop_file mount options pre_mount post_mount source swap
				;;

			gpg_options=*|key=*|loop_file=*|options=*|pre_mount=*|post_mount=*|source=*)
				if [[ -z ${mount} && -z ${swap} ]] ; then
					ewarn "Ignoring setting outside mount/swap section: ${mountline}"
					continue
				fi
				;;

			*)
				ewarn "Skipping invalid line in /etc/conf.d/cryptfs: ${mountline}"
				;;
		esac

		# Queue this setting for the next call to dm-crypt-execute-${myservice}
		eval "${mountline}"
	done < /etc/conf.d/cryptfs

	# If we have a mount queued up, then execute it
	dm-crypt-execute-${myservice}

	ewend ${cryptfs_status} "Failed to setup dm-crypt devices"
fi


# vim:ts=4
