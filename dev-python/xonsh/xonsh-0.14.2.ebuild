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
RESTRICT="test"
#IUSE="test"
#RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/prompt-toolkit-3.0.29[${PYTHON_USEDEP}]
	dev-python/pyperclip[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/setproctitle[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
"

#BDEPEND="
#	${RDEPEND}
#	test? (
#		dev-python/legacy-cgi[${PYTHON_USEDEP}]
#		dev-python/pyte[${PYTHON_USEDEP}]
#		dev-python/virtualenv[${PYTHON_USEDEP}]
#	)
#"

#EPYTEST_PLUGINS=( pytest-{mock,timeout,subprocess} )
#EPYTEST_IGNORE=(
#	# has been fixed in futur version https://github.com/xonsh/xonsh/issues/5755
#	tests/test_history_dummy.py
#	# only for dev https://github.com/xonsh/xonsh/issues/5607
#	tests/aliases
#	tests/completers # cf. previous comment too
#	tests/procs # cf. previous comment too
#	tests/test_aliases.py
#	tests/test_completer.py
#	tests/test_ptk_completer.py
#	tests/test_jobs.py
#	tests/test_main.py
#	tests/test_builtins.py
#	tests/test_base_shell.py
#	tests/test_contexts.py
#	tests/test_dirstack_unc.py
#	tests/test_history_sqlite.py
#	tests/test_imphooks.py
#	tests/test_man.py
#	#tests/test_parser.py
#	#tests/test_tools.py
#	#tests/test_pyghooks.py
#	#tests/test_pyghooks.py
#)
#
## has been fixed in futur version https://github.com/xonsh/xonsh/issues/5755
#EPYTEST_DESELECT=(
#	'tests/prompt/test_base.py::TestPromptFromVenvCfg::test_determine_env_name_from_cfg[nothing = here]'
#	'tests/prompt/test_base.py::TestPromptFromVenvCfg::test_determine_env_name_from_cfg[other = fluff\nnothing = here\nmore = fluff]'
#	'tests/test_integrations.py::test_script[case0]'
#	'tests/test_integrations.py::test_script[case1]'
#	'tests/test_integrations.py::test_script[case2]'
#	'tests/test_integrations.py::test_script[case3]'
#	'tests/test_integrations.py::test_script[case4]'
#	'tests/test_integrations.py::test_script[case5]'
#	'tests/test_integrations.py::test_script[case6]'
#	'tests/test_integrations.py::test_script[case7]'
#	'tests/test_integrations.py::test_script[case8]'
#	'tests/test_integrations.py::test_script[case9]'
#	'tests/test_integrations.py::test_script[case10]'
#	'tests/test_integrations.py::test_script[case11]'
#	'tests/test_integrations.py::test_script[case12]'
#	'tests/test_integrations.py::test_script[case13]'
#	'tests/test_integrations.py::test_script[case14]'
#	'tests/test_integrations.py::test_script[case15]'
#	'tests/test_integrations.py::test_script[case16]'
#	'tests/test_integrations.py::test_script[case17]'
#	'tests/test_integrations.py::test_script[case18]'
#	'tests/test_integrations.py::test_script[case19]'
#	'tests/test_integrations.py::test_script[case20]'
#	'tests/test_integrations.py::test_script[case21]'
#	'tests/test_integrations.py::test_script[case22]'
#	'tests/test_integrations.py::test_script[case23]'
#	'tests/test_integrations.py::test_script[case25]'
#	'tests/test_integrations.py::test_script[case26]'
#	'tests/test_integrations.py::test_script[case27]'
#	'tests/test_integrations.py::test_script[case28]'
#	'tests/test_integrations.py::test_script_stderr[case0]'
#	"tests/test_integrations.py::test_ampersand_argument"
#	'tests/test_integrations.py::test_loading_correctly'
#	"tests/test_pretty.py::test_pretty_fn[1-re.compile(r'1', re.UNICODE)]"
#	'tests/test_tools.py::test_env_path_add_pathlib'
#	'tests/test_virtualenv_activator.py::test_xonsh_activator'
#	'tests/test_xonfig.py::TestXonfigWeb::test_colors_get'
#	'tests/test_xonfig.py::TestXonfigWeb::test_prompts_get'
#	'tests/test_xontribs.py::test_xshxontrib'
#	'tests/test_xontribs.py::test_xontrib_load'
#	'tests/test_xontribs.py::test_xontrib_load_dashed'
#
#	# only for dev https://github.com/xonsh/xonsh/issues/5607
#	'tests/prompt/test_base.py::test_format_prompt'
#	'tests/prompt/test_base.py::test_format_prompt_with_format_spec'
#	'tests/prompt/test_base.py::test_format_prompt_with_broken_template'
#	'tests/prompt/test_base.py::test_format_prompt_with_broken_template_in_func'
#	'tests/prompt/test_base.py::test_format_prompt_with_invalid_func'
#	'tests/prompt/test_base.py::test_format_prompt_with_func_that_raises'
#	'tests/prompt/test_base.py::test_format_prompt_with_no_env'
#	'tests/prompt/test_base.py::test_format_prompt_with_various_envs'
#	'tests/prompt/test_base.py::test_format_prompt_with_various_prepost'
#	'tests/prompt/test_base.py::test_noenv_with_disable_set'
#	'tests/prompt/test_base.py::TestEnvNamePrompt::test_no_prompt'
#	'tests/prompt/test_base.py::TestEnvNamePrompt::test_search_order'
#	'tests/prompt/test_base.py::test_custom_env_overrides_default'
#	'tests/prompt/test_base.py::test_promptformatter_cache'
#	'tests/prompt/test_base.py::test_promptformatter_clears_cache'
#	'tests/prompt/test_cwd.py::test_cwd_escapes_curly_brackets_with_more_curly_brackets'
#	'tests/prompt/test_gitstatus.py::test_gitstatus_dirty'
#	'tests/prompt/test_gitstatus.py::test_gitstatus_clean'
#	'tests/prompt/test_gitstatus.py::test_no_git'
#	'tests/prompt/test_job.py::test_current_job'
#	'tests/prompt/test_vc.py::test_no_repo'
#	'tests/prompt/test_vc.py::test_vc_get_branch[git]'
#	'tests/prompt/test_vc.py::test_current_branch_calls_locate_binary_for_empty_cmds_cache'
#	'tests/prompt/test_vc.py::test_current_branch_does_not_call_locate_binary_for_non_empty_cmds_cache'
#	'tests/prompt/test_vc.py::test_dirty_working_directory[git]'
#	'tests/prompt/test_vc.py::test_git_dirty_working_directory_includes_untracked'
#	'tests/test_parser.py::test_macro_call_one_trailing'
#	'tests/test_parser.py::test_macro_call_one_trailing_space'
#	'tests/test_parser.py::test_macro_call_one_arg'
#	'tests/test_parser.py::test_macro_call_empty'
#	'tests/test_parser.py::test_macro_call_two_args'
#	'tests/test_parser.py::test_macro_call_three_args'
#	'tests/test_tools.py::test_expandvars'
#	'tests/test_tools.py::test_expand_path'
#	'tests/test_pyghooks.py::test_colorize_file'
#	'tests/test_pyghooks.py::test_colorize_file_symlink'
#	'tests/test_tools.py::test_get_logical_line'
#	'tests/test_tools.py::test_replace_logical_line'
#	'tests/test_tools.py::test_iglobpath_no_dotfiles'
#	'tests/test_tools.py::test_iglobpath_dotfiles'
#	'tests/test_tools.py::test_iglobpath_no_dotfiles_recursive'
#	'tests/test_tools.py::test_iglobpath_dotfiles_recursive'
#	'tests/test_tools.py::test_iglobpath_empty_str'
#	'tests/test_tools.py::test_env_path_getitem'
#	'tests/test_tools.py::test_env_path_multipath'
#	'tests/test_tools.py::test_env_path_with_pathlib_path_objects'
#	'tests/test_parser.py::test_int_literal'
#	'tests/test_parser.py::test_int_literal_underscore'
#	'tests/test_parser.py::test_float_literal'
#	'tests/test_parser.py::test_float_literal_underscore'
#	'tests/test_parser.py::test_imag_literal'
#	'tests/test_parser.py::test_float_imag_literal'
#	'tests/test_parser.py::test_complex'
#	'tests/test_parser.py::test_str_literal'
#	'tests/test_parser.py::test_bytes_literal'
#	'tests/test_parser.py::test_raw_literal'
#	'tests/test_parser.py::test_f_literal'
#	'tests/test_parser.py::test_string_literal_concat'
#	'tests/test_parser.py::test_f_env_var'
#	'tests/test_parser.py::test_fstring_adaptor'
#	'tests/test_parser.py::test_raw_bytes_literal'
#	'tests/test_parser.py::test_unary_plus'
#	'tests/test_parser.py::test_unary_minus'
#	'tests/test_parser.py::test_unary_invert'
#	'tests/test_parser.py::test_binop_plus'
#	'tests/test_parser.py::test_binop_minus'
#	'tests/test_parser.py::test_binop_times'
#	'tests/test_parser.py::test_binop_matmult'
#	'tests/test_parser.py::test_binop_div'
#	'tests/test_parser.py::test_binop_mod'
#	'tests/test_parser.py::test_binop_floordiv'
#	'tests/test_parser.py::test_binop_pow'
#	'tests/test_parser.py::test_plus_pow'
#	'tests/test_parser.py::test_plus_plus'
#	'tests/test_parser.py::test_plus_minus'
#	'tests/test_parser.py::test_minus_plus'
#	'tests/test_parser.py::test_minus_minus'
#	'tests/test_parser.py::test_minus_plus_minus'
#	'tests/test_parser.py::test_times_plus'
#	'tests/test_parser.py::test_plus_times'
#	'tests/test_parser.py::test_times_times'
#	'tests/test_parser.py::test_times_div'
#	'tests/test_parser.py::test_times_div_mod'
#	'tests/test_parser.py::test_times_div_mod_floor'
#	'tests/test_parser.py::test_str_str'
#	'tests/test_parser.py::test_str_str_str'
#	'tests/test_parser.py::test_str_plus_str'
#	'tests/test_parser.py::test_str_times_int'
#	'tests/test_parser.py::test_int_times_str'
#	'tests/test_parser.py::test_group_plus_times'
#	'tests/test_parser.py::test_plus_group_times'
#	'tests/test_parser.py::test_group'
#	'tests/test_parser.py::test_lt'
#	'tests/test_parser.py::test_gt'
#	'tests/test_parser.py::test_eq'
#	'tests/test_parser.py::test_le'
#	'tests/test_parser.py::test_ge'
#	'tests/test_parser.py::test_ne'
#	'tests/test_parser.py::test_in'
#	'tests/test_parser.py::test_is'
#	'tests/test_parser.py::test_not_in'
#	'tests/test_parser.py::test_is_not'
#	'tests/test_parser.py::test_lt_lt'
#	'tests/test_parser.py::test_lt_lt_lt'
#	'tests/test_parser.py::test_not'
#	'tests/test_parser.py::test_or'
#	'tests/test_parser.py::test_or_or'
#	'tests/test_parser.py::test_and'
#	'tests/test_parser.py::test_and_and'
#	'tests/test_parser.py::test_and_or'
#	'tests/test_parser.py::test_or_and'
#	'tests/test_parser.py::test_group_and_and'
#	'tests/test_parser.py::test_group_and_or'
#	'tests/test_parser.py::test_if_else_expr'
#	'tests/test_parser.py::test_if_else_expr_expr'
#	'tests/test_parser.py::test_subscription_syntaxes'
#	'tests/test_parser.py::test_subscription_special_syntaxes'
#	'tests/test_parser.py::test_subscription_special_syntaxes_2 XFAIL    [1629/3154]'
#	'tests/test_parser.py::test_str_idx'
#	'tests/test_parser.py::test_str_slice'
#	'tests/test_parser.py::test_str_step'
#	'tests/test_parser.py::test_str_slice_all'
#	'tests/test_parser.py::test_str_slice_upper'
#	'tests/test_parser.py::test_str_slice_lower'
#	'tests/test_parser.py::test_str_slice_other'
#	'tests/test_parser.py::test_str_slice_lower_other'
#	'tests/test_parser.py::test_str_slice_upper_other'
#	'tests/test_parser.py::test_str_2slice'
#	'tests/test_parser.py::test_str_2step'
#	'tests/test_parser.py::test_str_2slice_all'
#	'tests/test_parser.py::test_str_2slice_upper'
#	'tests/test_parser.py::test_str_2slice_lower'
#	'tests/test_parser.py::test_str_2slice_lowerupper'
#	'tests/test_parser.py::test_str_2slice_other'
#	'tests/test_parser.py::test_str_2slice_lower_other'
#	'tests/test_parser.py::test_str_2slice_upper_other'
#	'tests/test_parser.py::test_str_3slice'
#	'tests/test_parser.py::test_str_3step'
#	'tests/test_parser.py::test_str_3slice_all'
#	'tests/test_parser.py::test_str_3slice_upper'
#	'tests/test_parser.py::test_str_3slice_lower'
#	'tests/test_parser.py::test_str_3slice_lowerlowerupper'
#	'tests/test_parser.py::test_str_3slice_lowerupperlower'
#	'tests/test_parser.py::test_str_3slice_lowerupperupper'
#	'tests/test_parser.py::test_str_3slice_upperlowerlower'
#	'tests/test_parser.py::test_str_3slice_upperlowerupper'
#	'tests/test_parser.py::test_str_3slice_upperupperlower'
#	'tests/test_parser.py::test_str_3slice_other'
#	'tests/test_parser.py::test_str_3slice_lower_other'
#	'tests/test_parser.py::test_str_3slice_upper_other'
#	'tests/test_parser.py::test_str_slice_true'
#	'tests/test_parser.py::test_str_true_slice'
#	'tests/test_parser.py::test_list_empty'
#	'tests/test_parser.py::test_list_one'
#	'tests/test_parser.py::test_list_one_comma'
#	'tests/test_parser.py::test_list_two'
#	'tests/test_parser.py::test_list_three'
#	'tests/test_parser.py::test_list_three_comma'
#	'tests/test_parser.py::test_list_one_nested'
#	'tests/test_parser.py::test_list_list_four_nested'
#	'tests/test_parser.py::test_list_tuple_three_nested'
#	'tests/test_parser.py::test_list_set_tuple_three_nested'
#	'tests/test_parser.py::test_list_tuple_one_nested'
#	'tests/test_parser.py::test_tuple_tuple_one_nested'
#	'tests/test_parser.py::test_dict_list_one_nested'
#	'tests/test_parser.py::test_dict_list_one_nested_comma'
#	'tests/test_parser.py::test_dict_tuple_one_nested'
#	'tests/test_parser.py::test_dict_tuple_one_nested_comma'
#	'tests/test_parser.py::test_dict_list_two_nested'
#	'tests/test_parser.py::test_set_tuple_one_nested'
#	'tests/test_parser.py::test_set_tuple_two_nested'
#	'tests/test_parser.py::test_tuple_empty'
#	'tests/test_parser.py::test_tuple_one_bare'
#	'tests/test_parser.py::test_tuple_two_bare'
#	'tests/test_parser.py::test_tuple_three_bare'
#	'tests/test_parser.py::test_tuple_three_bare_comma'
#	'tests/test_parser.py::test_tuple_one_comma'
#	'tests/test_parser.py::test_tuple_two'
#	'tests/test_parser.py::test_tuple_three'
#	'tests/test_parser.py::test_tuple_three_comma'
#	'tests/test_parser.py::test_bare_tuple_of_tuples'
#	'tests/test_parser.py::test_set_one'
#	'tests/test_parser.py::test_set_one_comma'
#	'tests/test_parser.py::test_set_two'
#	'tests/test_parser.py::test_set_two_comma'
#	'tests/test_parser.py::test_set_three'
#	'tests/test_parser.py::test_dict_empty'
#	'tests/test_parser.py::test_dict_one'
#	'tests/test_parser.py::test_dict_one_comma'
#	'tests/test_parser.py::test_dict_two'
#	'tests/test_parser.py::test_dict_two_comma'
#	'tests/test_parser.py::test_dict_three'
#	'tests/test_parser.py::test_dict_from_dict_one'
#	'tests/test_parser.py::test_dict_from_dict_one_comma'
#	'tests/test_parser.py::test_dict_from_dict_two_xy'
#	'tests/test_parser.py::test_dict_from_dict_two_x_first'
#	'tests/test_parser.py::test_dict_from_dict_two_x_second'
#	'tests/test_parser.py::test_dict_from_dict_two_x_none'
#	'tests/test_parser.py::test_dict_from_dict_three_xyz'
#	'tests/test_parser.py::test_many_subprocbang'
#	'tests/test_parser.py::test_withbang_single_suite'
#	'tests/test_parser.py::test_withbang_as_single_suite'
#	'tests/test_parser.py::test_withbang_single_suite_trailing'
#	'tests/test_parser.py::test_withbang_single_simple'
#	'tests/test_parser.py::test_withbang_single_simple_opt'
#	'tests/test_parser.py::test_withbang_as_many_suite'
#	'tests/test_parser.py::test_subproc_raw_str_literal'
#)
#
#distutils_enable_tests pytest
