# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit python-r1 python-utils-r1

DESCRIPTION="Fast, correct Python JSON library supporting dataclasses, datetimes, and numpy"
HOMEPAGE="https://github.com/ijl/orjson"
SRC_URI="
	amd64? (
	https://files.pythonhosted.org/packages/ea/e0/916840ad7082d0fd30b344a81c21380421f1b50461c994f7377a520b2c58/orjson-3.5.4-cp310-cp310-manylinux_2_24_x86_64.whl -> ${P}_x86_64.zip
	)
	arm64? (
	https://files.pythonhosted.org/packages/36/cb/745cbd1f16ee64da14e3fe08e3e0528e3901a6265afe52de16bf3e2d20cc/orjson-3.5.4-cp310-cp310-manylinux_2_24_aarch64.whl -> ${P}_aarch64.zip
	)

	"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="test"

S="${WORKDIR}/"

pkg_setup() {
	python_setup
}

src_install(){
	insinto "$(python_get_sitedir)"
	if use amd64; then
		doins orjson.cpython-310-x86_64-linux-gnu.so
		dosym  $(python_get_sitedir)/orjson.cpython-310-x86_64-linux-gnu.so $(python_get_sitedir)/orjson.cpython-39-x86_64-linux-gnu.so
		dosym  $(python_get_sitedir)/orjson.cpython-310-x86_64-linux-gnu.so $(python_get_sitedir)/orjson.cpython-38-x86_64-linux-gnu.so
		dosym  $(python_get_sitedir)/orjson.cpython-310-x86_64-linux-gnu.so $(python_get_sitedir)/orjson.cpython-37-x86_64-linux-gnu.so
	elif use arm64; then
		doins orjson.cpython-310-aarch64-linux-gnu.so
		dosym  $(python_get_sitedir)/orjson.cpython-310-aarch64-linux-gnu.so $(python_get_sitedir)/orjson.cpython-39-aarch64-linux-gnu.so
		dosym  $(python_get_sitedir)/orjson.cpython-310-aarch64-linux-gnu.so $(python_get_sitedir)/orjson.cpython-38-aarch64-linux-gnu.so
		dosym  $(python_get_sitedir)/orjson.cpython-310-aarch64-linux-gnu.so $(python_get_sitedir)/orjson.cpython-37-aarch64-linux-gnu.so
	fi
}
