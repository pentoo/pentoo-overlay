# /lib/rcscripts/addons/dm-crypt-stop.sh
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cryptsetup/files/dm-crypt-stop.sh,v 1.2 2005/03/02 15:16:39 vapier Exp $

# Try to remove any dm-crypt mappings
if [ -f /etc/conf.d/cryptfs ] && [ -x /bin/cryptsetup ]
then
	einfo "Removing dm-crypt mappings"

	/bin/egrep "^(mount|swap)" /etc/conf.d/cryptfs | \
	while read mountline
	do
		mount=
		swap=
		target=

		eval ${mountline}

		if [ -n "${mount}" ]
		then
			target=${mount}
		elif [ -n "${swap}" ]
		then
			target=${swap}
		else
			ewarn "Invalid line in /etc/conf.d/cryptfs: ${mountline}"
		fi

		ebegin "Removing dm-crypt mapping for: ${target}"
		/bin/cryptsetup remove ${target}
		eend $? "Failed to remove dm-crypt mapping for: ${target}"
	done

	if [[ -n $(/bin/egrep -e "^(source=)./dev/loop*" /etc/conf.d/cryptfs) ]] ; then
		einfo "Taking down any dm-crypt loop devices"
		/bin/egrep -e "^(source)" /etc/conf.d/cryptfs | while read sourceline
		do
			source=
			eval ${sourceline}
			if [[ -n $(echo ${source} | grep /dev/loop) ]] ; then
				ebegin "   Taking down ${source}"
				/sbin/losetup -d ${source}
				eend $? "  Failed to remove loop"
			fi
		done
	fi
fi


# vim:ts=4
