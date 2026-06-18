# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python-powered, cross-platform, Unix-gazing shell"
HOMEPAGE="https://pypi.org/project/xonsh/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/prompt-toolkit-3.0.29[${PYTHON_USEDEP}]
	dev-python/pyperclip[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/setproctitle[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
"

BDEPEND="
	${RDEPEND}
	test? (
		dev-python/pyte[${PYTHON_USEDEP}]
		dev-python/virtualenv[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-{mock,timeout,subprocess} )
EPYTEST_IGNORE=(
	# too long
	tests/xintegration/test_stress.py
)
EPYTEST_DESELECT=(
	# error
	'tests/test_tools.py::test_iglobpath_empty_str'
	# failed, to be investigated
	'tests/completers/test_bash_completer.py::test_bash_completer[command_context0-completions0-5]'
	'tests/completers/test_bash_completer.py::test_bash_completer[command_context1-completions1-0]'
	'tests/completers/test_bash_completer.py::test_bash_completer[command_context2-completions2-2]'
	'tests/completers/test_bash_completer.py::test_bash_completer[command_context3-completions3-1]'
	'tests/completers/test_bash_completer.py::test_quote_handling[command_context0-completions0-4]'
	'tests/completers/test_bash_completer.py::test_quote_handling[command_context1-completions1-5]'
	'tests/completers/test_bash_completer.py::test_quote_handling[command_context2-completions2-5]'
	'tests/completers/test_bash_completer.py::test_quote_handling[command_context3-completions3-6]'
	'tests/completers/test_bash_completer.py::test_quote_handling[command_context4-completions4-10]'
	'tests/completers/test_bash_completer.py::test_quote_handling[command_context5-completions5-4]'
	'tests/completers/test_bash_completer.py::test_quote_handling[command_context6-completions6-5]'
	'tests/completers/test_bash_completer.py::test_quote_handling[command_context7-completions7-5]'
	'tests/completers/test_bash_completer.py::test_quote_handling[command_context8-completions8-6]'
	'tests/completers/test_bash_completer.py::test_bash_completer_empty_prefix'
	'tests/completers/test_bash_completer.py::test_equal_sign_arg[command_context0-completions0-3-False]'
	'tests/completers/test_bash_completer.py::test_equal_sign_arg[command_context1-completions1-3-True]'
	'tests/completers/test_bash_completer.py::test_equal_sign_arg[command_context2-completions2-2-True]'
	'tests/completers/test_bash_completer.py::test_equal_sign_arg[command_context3-completions3-3-False]'
	'tests/completers/test_bash_completer.py::test_equal_sign_arg[command_context4-completions4-8-True]'
	'tests/completers/test_pip_completer.py::test_completions[pip-c-exp0]'
	'tests/completers/test_pip_completer.py::test_completions[pip show--pip_installed]'
	'tests/completers/test_pip_completer.py::test_xpip_completions'
	'tests/prompt/test_base.py::TestPromptFromVenvCfg::test_determine_env_name_from_cfg[nothing = here]'
	'tests/prompt/test_base.py::TestPromptFromVenvCfg::test_determine_env_name_from_cfg[other = fluff\nnothing = here\nmore = fluff]'
	'tests/test_dirstack.py::test_cdpath_events'
	'tests/test_dirstack.py::test_cd_autopush'
	'tests/test_dirstack.py::test_cd_home'
	'tests/test_man.py::test_man_completion[yes-exp0]'
	'tests/test_man.py::test_man_completion[man-exp1]'
	'tests/xintegration/test_integrations.py::test_forwarding_sighup'
	'tests/xintegration/test_integrations.py::test_on_postcommand_waiting'
)

distutils_enable_tests pytest

# no doc, it has some dependencies that are not in pentoo nor gentoo overlay
