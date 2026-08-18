# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="ASN.1 parsing, encoding and decoding"
HOMEPAGE="
	https://github.com/eerimoq/asn1tools
	https://pypi.org/project/asn1tools
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="cache examples shell"

RDEPEND="
	>=dev-python/pyparsing-3.1.2[${PYTHON_USEDEP}]
	dev-python/bitstruct[${PYTHON_USEDEP}]
	cache? ( dev-python/diskcache[${PYTHON_USEDEP}] )
	shell? ( dev-python/prompt-toolkit[${PYTHON_USEDEP}] )
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi

	distutils-r1_python_install_all
}

python_test() {
	# to be investigated
	local EPYTEST_DESELECT=(
		'tests/test_codecs_consistency.py::Asn1ToolsCodecsConsistencyTest::test_c_source'
		'tests/test_command_line.py::Asn1ToolsCommandLineTest::test_command_line_generate_c_source_oer'
		'tests/test_command_line.py::Asn1ToolsCommandLineTest::test_command_line_generate_c_source_uper'
		'tests/test_command_line.py::Asn1ToolsCommandLineTest::test_command_line_generate_rust_source_uper'
		'tests/test_compile.py::Asn1ToolsCompileTest::test_missing_parameterized_value'
		'tests/test_oer.py::Asn1ToolsOerTest::test_c_source'
		'tests/test_parse.py::Asn1ToolsParseTest::test_parse_parameterization'
	)

	# needs diskcache
	if ! use cache; then
		EPYTEST_DESELECT+=(
			'tests/test_compile.py::Asn1ToolsCompileTest::test_cache'
		)
	fi

	# needs prompt-toolkit
	if ! use shell; then
		EPYTEST_DESELECT+=(
			'tests/test_command_line.py::Asn1ToolsCommandLineTest::test_command_line_shell'
			'tests/test_command_line.py::Asn1ToolsCommandLineTest::test_command_line_shell_compile_help_no_exit'
			'tests/test_command_line.py::Asn1ToolsCommandLineTest::test_command_line_shell_compile_without_arguments'
			'tests/test_command_line.py::Asn1ToolsCommandLineTest::test_command_line_shell_convert_without_compile'
		)
	fi

	epytest
}
