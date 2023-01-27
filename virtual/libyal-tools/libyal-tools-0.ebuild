# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for all command line forensics tools provided by libyal"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="nls unicode python fuse +threads debug"

# This is a list of the packages and the command line tools contained within:
# app-forensics/libbde: /usr/bin/bdeinfo
# app-forensics/libbde: /usr/bin/bdemount
# app-forensics/libesedb: /usr/bin/esedbexport
# app-forensics/libesedb: /usr/bin/esedbinfo
# app-forensics/libevt: /usr/bin/evtexport
# app-forensics/libevt: /usr/bin/evtinfo
# app-forensics/libevtx: /usr/bin/evtxexport
# app-forensics/libevtx: /usr/bin/evtxinfo
# app-forensics/libewf: /usr/bin/ewfacquire
# app-forensics/libewf: /usr/bin/ewfacquirestream
# app-forensics/libewf: /usr/bin/ewfdebug
# app-forensics/libewf: /usr/bin/ewfexport
# app-forensics/libewf: /usr/bin/ewfinfo
# app-forensics/libewf: /usr/bin/ewfmount
# app-forensics/libewf: /usr/bin/ewfrecover
# app-forensics/libewf: /usr/bin/ewfverify
# app-forensics/libexe: /usr/bin/exeinfo
# app-forensics/libfsapfs: /usr/bin/fsapfsinfo
# app-forensics/libfsapfs: /usr/bin/fsapfsmount
# app-forensics/libfsclfs: /usr/bin/fsclfsinfo
# app-forensics/libfsclfs: /usr/bin/fsclfstest
# app-forensics/libfsext: /usr/bin/fsextinfo
# app-forensics/libfsext: /usr/bin/fsextmount
# app-forensics/libfsfat: /usr/bin/fsfatinfo
# app-forensics/libfsfat: /usr/bin/fsfatmount
# app-forensics/libfshfs: /usr/bin/fshfsinfo
# app-forensics/libfshfs: /usr/bin/fshfsmount
# app-forensics/libfsntfs: /usr/bin/fsntfsinfo
# app-forensics/libfsntfs: /usr/bin/fsntfsmount
# app-forensics/libfsxfs: /usr/bin/fsxfsinfo
# app-forensics/libfsxfs: /usr/bin/fsxfsmount
# app-forensics/libfvde: /usr/bin/fvdeinfo
# app-forensics/libfvde: /usr/bin/fvdemount
# app-forensics/libfvde: /usr/bin/fvdewipekey
# app-forensics/liblnk: /usr/bin/lnkinfo
# app-forensics/libluksde: /usr/bin/luksdeinfo
# app-forensics/libluksde: /usr/bin/luksdemount
# app-forensics/libmodi: /usr/bin/modiinfo
# app-forensics/libmodi: /usr/bin/modimount
# app-forensics/libmsiecf: /usr/bin/msiecfexport
# app-forensics/libmsiecf: /usr/bin/msiecfinfo
# app-forensics/libnk2: /usr/bin/nk2export
# app-forensics/libnk2: /usr/bin/nk2info
# app-forensics/libnsfdb: /usr/bin/nsfdbexport
# app-forensics/libnsfdb: /usr/bin/nsfdbinfo
# app-forensics/libodraw: /usr/bin/odrawinfo
# app-forensics/libodraw: /usr/bin/odrawverify
# app-forensics/libolecf: /usr/bin/olecfexport
# app-forensics/libolecf: /usr/bin/olecfinfo
# app-forensics/libolecf: /usr/bin/olecfmount
# app-forensics/libpff: /usr/bin/pffexport
# app-forensics/libpff: /usr/bin/pffinfo
# app-forensics/libphdi: /usr/bin/phdiinfo
# app-forensics/libphdi: /usr/bin/phdimount
# app-forensics/libqcow: /usr/bin/qcowinfo
# app-forensics/libqcow: /usr/bin/qcowmount
# app-forensics/libregf: /usr/bin/regfexport
# app-forensics/libregf: /usr/bin/regfinfo
# app-forensics/libregf: /usr/bin/regfmount
# app-forensics/libscca: /usr/bin/sccainfo
# app-forensics/libsmraw: /usr/bin/smrawmount
# app-forensics/libsmraw: /usr/bin/smrawverify
# app-forensics/libvsgpt: /usr/bin/vsgptinfo
# app-forensics/libvshadow: /usr/bin/vshadowdebug
# app-forensics/libvshadow: /usr/bin/vshadowinfo
# app-forensics/libvshadow: /usr/bin/vshadowmount
# app-forensics/libvslvm: /usr/bin/vslvminfo
# app-forensics/libvslvm: /usr/bin/vslvmmount
# app-forensics/libvsmbr: /usr/bin/vsmbrinfo
# dev-libs/libcreg: /usr/bin/cregexport
# dev-libs/libcreg: /usr/bin/creginfo
# dev-libs/libcreg: /usr/bin/cregmount
# dev-libs/libhmac: /usr/bin/hmacsum
# dev-libs/libsigscan: /usr/bin/sigscan
# dev-libs/libsmdev: /usr/bin/smdevinfo
# dev-libs/libuna: /usr/bin/unabase
# dev-libs/libuna: /usr/bin/unaexport
# dev-libs/libvhdi: /usr/bin/vhdiinfo
# dev-libs/libvhdi: /usr/bin/vhdimount
# dev-libs/libvmdk: /usr/bin/vmdkinfo
# dev-libs/libvmdk: /usr/bin/vmdkmount
# dev-libs/libwrc: /usr/bin/wrcinfo

RDEPEND="
	app-forensics/libbde[nls=,unicode=,python=,debug=]
	app-forensics/libesedb[nls=,unicode=,python=,threads=,debug=]
	app-forensics/libevt[nls=,unicode=,python=,threads=,debug=]
	app-forensics/libevtx[nls=,unicode=,python=,threads=,debug=]
	>app-forensics/libewf-20171231[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libexe[nls=,unicode=,python=,threads=,debug=]
	app-forensics/libfsapfs[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libfsclfs[nls=,unicode=,threads=,debug=]
	app-forensics/libfsext[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libfsfat[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libfshfs[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libfsntfs[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libfsxfs[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libfvde[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/liblnk[nls=,unicode=,python=,threads=,debug=]
	app-forensics/libluksde[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libmodi[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libmsiecf[nls=,unicode=,python=,threads=,debug=]
	app-forensics/libnk2[nls=,unicode=,python=,threads=,debug=]
	app-forensics/libnsfdb[nls=,unicode=,threads=,debug=]
	app-forensics/libodraw[nls=,unicode=,threads=,debug=]
	app-forensics/libolecf[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libpff[nls=,unicode=,python=,threads=,debug=]
	app-forensics/libphdi[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libqcow[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libregf[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libscca[nls=,unicode=,python=,threads=,debug=]
	app-forensics/libsmraw[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libvsgpt[nls=,unicode=,python=,threads=,debug=]
	app-forensics/libvshadow[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libvslvm[nls=,unicode=,python=,fuse=,threads=,debug=]
	app-forensics/libvsmbr[nls=,unicode=,python=,threads=,debug=]
	dev-libs/libcreg[nls=,unicode=,python=,fuse=,threads=,debug=]
	dev-libs/libhmac[nls=,unicode=,threads=]
	dev-libs/libsigscan[nls=,unicode=,python=,threads=,debug=]
	dev-libs/libsmdev[nls=,unicode=,python=,threads=,debug=]
	dev-libs/libuna[nls=,unicode=]
	dev-libs/libvhdi[nls=,unicode=,python=,fuse=,threads=,debug=]
	dev-libs/libvmdk[nls=,unicode=,python=,fuse=,threads=,debug=]
	dev-libs/libwrc[nls=,unicode=,python=,threads=,debug=]
"
