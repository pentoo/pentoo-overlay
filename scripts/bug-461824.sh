#work around for detecting and fixing bug #461824
grep -r _portage_reinstall_ /etc {/usr,}/{*bin,lib*} | grep -v doebuild > /tmp/urfuct.txt
if [ -n "$(cat /tmp/urfuct.txt)" ]; then
	for badhit in "$(cat /tmp/urfuct.txt)" ; do
		echo ${badhit} | cut -d":" -f1 >> /tmp/badfiles.txt
	done
	for badfile in $(cat /tmp/badfiles.txt); do
		qfile -C ${badfile} | cut -d' ' -f1 >> /tmp/badpkg_us.txt
	done
	cat /tmp/badpkg_us.txt | sort -u > /tmp/badpkg.txt
	cat /tmp/badpkg.txt
	emerge -1 --buildpkg=y --nodeps $(cat /tmp/badpkg.txt) || /bin/bash
	rm -f /tmp/urfuct.txt /tmp/badfiles.txt /tmp/badpkg_us.txt /tmp/badpkg.txt
fi
