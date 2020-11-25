# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

## fix python compat to gentoo standards. forked from funtoos core-kit repo. so previously a mess. 

inherit distutils-r1_single_impiled

DESCRIPTION="Funtoo's franken-chroot tool."
HOMEPAGE="https://pypi.org/project/fchroot/"
SRC_URI="https://files.pythonhosted.org/packages/f2/04/4db5e98e93207dbb9bb71725767a8d016f9aa1e70c9c7892a5c270c3eac6/fchroot-${PV}.tar.gz"

#fchroot-0.1.2.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE=""
distutils-r1_python_install_all

#python3.x setup.py install 

#RDEPEND="" # qemu_user_targets_aarch64 etc ..

Einfo " this tool was swiped from funtoo,  at worse github.com/multiarch/qemu-user-static/releases/ for a static bin, CP bin to  /mnt/mychroot/usr/local/bin if chrooting from live usb env "
einfo " this tool takes care of qemu-wrapper and mounting run sys proc etc. , most of the hassels of staging an arm/arm64/riscV  qemu chroots"
einfo " fchroot /mnt/rpi64-gentoo-example  & quick chroot /mnt/rpi64-gentoo-example "
einfo " this tool depends on quemu being built  for qemu_user_targets , arm arm64 or riscV / either ,all / or one you care for.  else you can get static build as mentioned above." 