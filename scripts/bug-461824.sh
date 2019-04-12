#!/bin/bash
#work around for detecting and fixing bug #461824

rm -f /tmp/_portage_reinstall_.txt /tmp/badpkg_us.txt /tmp/badpkg.txt

for dir in /etc {/usr,}/{*bin,lib*};
do
	grep -Fr '_portage_reinstall_' $dir | grep -Fv 'doebuild' >> /tmp/_portage_reinstall_.txt &
	WAITPIDS="$WAITPIDS "$!
done
wait $WAITPIDS

if [ -n "$(cat /tmp/_portage_reinstall_.txt)" ]; then
	cat /tmp/_portage_reinstall_.txt | cut -d":" -f1 > /tmp/badfiles.txt
	xargs -a /tmp/badfiles.txt qfile -S -C | cut -d' ' -f1 > /tmp/badpkg_us.txt
	sort -u /tmp/badpkg_us.txt | grep -v portage > /tmp/badpkg.txt
	if [ -n "$(cat /tmp/badpkg.txt)" ]; then
		emerge -1 --buildpkg=y --nodeps $(cat /tmp/badpkg.txt)
	fi
	rm -f /tmp/_portage_reinstall_.txt /tmp/badfiles.txt /tmp/badpkg_us.txt /tmp/badpkg.txt
fi
