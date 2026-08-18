EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

MY_PN="asn1tools"
MY_COMMIT="44277cdb34959196f317b6a02af20a4a1c3c4e2d"
DESCRIPTION="ASN.1 parsing, encoding and decoding - OSMOCOM patched"
HOMEPAGE="https://github.com/osmocom/asn1tools"
SRC_URI="https://github.com/osmocom/${MY_PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	!dev-python/asn1tools
	>=dev-python/pyparsing-3.0.6[${PYTHON_USEDEP}]
	dev-python/bitstruct[${PYTHON_USEDEP}]
	dev-python/diskcache[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
# Disable tests that are too sensitive for pyparsing version. E.g. depends
# on the exception text string, etc.
EPYTEST_DESELECT=(
	'tests/test_codecs_consistency.py::Asn1ToolsCodecsConsistencyTest::test_c_source'
	'tests/test_command_line.py::Asn1ToolsCommandLineTest::test_command_line_generate_c_source_oer'
	'tests/test_command_line.py::Asn1ToolsCommandLineTest::test_command_line_generate_c_source_uper'
	'tests/test_command_line.py::Asn1ToolsCommandLineTest::test_command_line_generate_rust_source_uper'
	'tests/test_compile.py::Asn1ToolsCompileTest::test_missing_parameterized_value'
	'tests/test_oer.py::Asn1ToolsOerTest::test_c_source'
	'tests/test_parse.py::Asn1ToolsParseTest::test_parse_error_late_extension_additions'
	'tests/test_parse.py::Asn1ToolsParseTest::test_parse_error_missing_union_member_beginning'
	'tests/test_parse.py::Asn1ToolsParseTest::test_parse_error_missing_union_member_end'
	'tests/test_parse.py::Asn1ToolsParseTest::test_parse_error_missing_union_member_middle'
	'tests/test_parse.py::Asn1ToolsParseTest::test_parse_error_sequence_missing_member_name'
	'tests/test_parse.py::Asn1ToolsParseTest::test_parse_error_sequence_missing_type'
	'tests/test_parse.py::Asn1ToolsParseTest::test_parse_error_too_many_extension_markers'
	'tests/test_parse.py::Asn1ToolsParseTest::test_parse_parameterization'
)
distutils_enable_tests pytest
