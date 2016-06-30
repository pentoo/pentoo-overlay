#!/bin/bash
#work around for detecting and fixing bug #461824

#CORES="$(grep -c ^proc /proc/cpuinfo)"
#if [[ "${CORES}" -eq "0" ]] ; then CORES="1" ; fi

rm -f /tmp/urfuct.txt /tmp/badpkg_us.txt /tmp/badpkg.txt

for dir in /etc {/usr,}/{*bin,lib*};
do
	fgrep -r _portage_reinstall_ $dir | fgrep -v doebuild >> /tmp/urfuct.txt &
	WAITPIDS="$WAITPIDS "$!
done
wait $WAITPIDS

#fgrep -r _portage_reinstall_ /etc {/usr,}/{*bin,lib*} | fgrep -v doebuild > /tmp/urfuct.txt
#find /etc {/usr,}/{*bin,lib*} -type f | xargs -P ${CORES} fgrep '_portage_rebuild_' | fgrep -v doebuild > /tmp/urfuct.txt
if [ -n "$(cat /tmp/urfuct.txt)" ]; then
	cat /tmp/urfuct.txt | cut -d":" -f1 > /tmp/badfiles.txt
	xargs -a /tmp/badfiles.txt qfile -S -C | cut -d' ' -f1 > /tmp/badpkg_us.txt
	sort -u /tmp/badpkg_us.txt | grep -v portage > /tmp/badpkg.txt
	if [ -n "$(cat /tmp/badpkg.txt)" ]; then
		emerge -1 --buildpkg=y --nodeps $(cat /tmp/badpkg.txt)
	fi
	rm -f /tmp/urfuct.txt /tmp/badfiles.txt /tmp/badpkg_us.txt /tmp/badpkg.txt
fi
