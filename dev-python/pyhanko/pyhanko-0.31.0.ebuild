# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Tools for stamping and signing PDF files"
HOMEPAGE="https://github.com/MatthiasValvekens/pyhanko"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

#IUSE="opentype qr image-support pkcs11 async-http etsi"

RDEPEND="
	>=dev-python/asn1crypto-1.5.1[${PYTHON_USEDEP}]
	>=dev-python/tzlocal-4.3[${PYTHON_USEDEP}]
	>=dev-python/pyhanko-certvalidator-0.29.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.31.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-43.0.3[${PYTHON_USEDEP}]
	>=dev-python/lxml-5.4.0[${PYTHON_USEDEP}]
"
#    opentype? (
#        dev-python/fonttools[${PYTHON_USEDEP}]
#    )
#    qr? (
#        dev-python/pypng[${PYTHON_USEDEP}]
#        dev-python/qrcodegen[${PYTHON_USEDEP}]
#    )
#    image-support? (
#        dev-python/pillow[${PYTHON_USEDEP}]
#        dev-python/miniapp[${PYTHON_USEDEP}]
#        dev-python/qrcode[${PYTHON_USEDEP}]
#    )
#    pkcs11? (
#        dev-python/cryptoki[${PYTHON_USEDEP}]
#    )
#    async-http? (
#        dev-python/httpx[${PYTHON_USEDEP}]
#    )
#    etsi? (
#        dev-python/python-iso7816[${PYTHON_USEDEP}]
#    )

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
