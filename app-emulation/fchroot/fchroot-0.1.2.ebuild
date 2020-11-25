# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9,10} )

inherit distutils-r1 eutils

DESCRIPTION="Funtoo's franken-chroot tool. , (chroot to arm/arm64/riscv made easy)"
HOMEPAGE="https://pypi.org/project/fchroot/"
SRC_URI="https://files.pythonhosted.org/packages/f2/04/4db5e98e93207dbb9bb71725767a8d016f9aa1e70c9c7892a5c270c3eac6/fchroot-${PV}.tar.gz"

#fchroot-0.1.2.tar.gz"
## fix python compat to gentoo standards. forked from funtoos core-kit repo. so previously a mess.  use yaml/auto gen version againts funtoos split repos/magic-eclasses 


LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"


RDEPEND="${PYTHON_DEPS}" 
DEPEND="${RDEPEND}"
# qemu_user_targets_aarch64 etc .. arm riscv64 etc. 


src_compile() {
	compile_python() {
		distutils-r1_python_compile --dynamic-linking
	}
	python_foreach_impl compile_python
}

post_install() {

Einfo " this tool was swiped from funtoo,  at worse github.com/multiarch/qemu-user-static/releases/ for a static bin, CP bin to  /mnt/mychroot/usr/local/bin if chrooting from live usb env "
einfo " this tool takes care of qemu-wrapper and mounting   most of the hassels of staging an arm/arm64/riscV " 
einfo " fchroot /mnt/rpi64-gentoo-example  & quick chroot /mnt/rpi64-gentoo-example "
einfo " this tool depends on quemu being built  for qemu_user_targets , arm arm64 or riscV / either ,all / or one you care for.  else you can get static build as mentioned above. "
einfo "to put in you chroot:/usr/local/bin" 
}