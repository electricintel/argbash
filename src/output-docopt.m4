

m4_define([_CAPITALIZE], [m4_translit([[$1]], [a-z], [A-Z])])

m4_define([_SYNOPSIS_OF_OPTIONAL_ARGS], [m4_lists_foreach_optional([_ARGS_LONG,_ARGS_SHORT,_ARGS_CATH], [_argname,_arg_short,_arg_type], [m4_do(
	[ @<:@],
	[m4_case(_arg_type,
		[bool], [_FORMAT_OPTIONAL_ARGUMENT_FOR_HELP_MESSAGE(_argname, )],
		[arg], [_FORMAT_OPTIONAL_ARGUMENT_FOR_HELP_MESSAGE(_argname, , _CAPITALIZE(_argname))],
		[repeated], [_FORMAT_OPTIONAL_ARGUMENT_FOR_HELP_MESSAGE(_argname, , _CAPITALIZE(_argname))...],
		[_FORMAT_OPTIONAL_ARGUMENT_FOR_HELP_MESSAGE(_argname, )])],
	[@:>@],
)])])


dnl
dnl $1: Long + short
dnl $2: Padding of $1
dnl $3: Help (optional)
dnl $4: Default (optional)
m4_define([_FORMAT_DOCOPT_OPTION], [m4_do(
	[m4_format([[  %-$2s]]m4_ifnblank([$3$4], [[[  %s]]])m4_ifnblank([$4], [[[ [default: %s]]]])._ENDL, [$1], [$3], [$4])],
)])


dnl
dnl $1: argname
dnl $2: short
dnl $3: cathegory
dnl $4: defaults
dnl $5: help
m4_define([_APPEND_TO_LISTS], [m4_do(
	[m4_list_append([_LIST_LOCAL_HELP], [$5])],
	[m4_list_append([LIST_DOCOPT_OPTIONALS_SPECS], m4_case(_arg_type,
		[bool], [_FORMAT_OPTIONAL_ARGUMENT_FOR_HELP_MESSAGE([$1], [$2], , [, ])],
		[action], [_FORMAT_OPTIONAL_ARGUMENT_FOR_HELP_MESSAGE([$1], [$2], , [, ])],
		[_FORMAT_OPTIONAL_ARGUMENT_FOR_HELP_MESSAGE([$1], [$2], _CAPITALIZE([$1]), [, ])]))],
	[m4_list_append([_LIST_LOCAL_DEFAULTS], m4_case(_arg_type,
		[bool], [$4],
		[action], [],
		[$4]))],
)])


dnl
dnl $1: The macro call (the caller is supposed to pass [$0($@)])
dnl What is also part of the API: The line
dnl ### START OF CODE GENERATED BY Argbash vx.y.z one line above ###
m4_define([ARGBASH_GO_BASE], [m4_do(
	[[$1
]],
	[dnl ASSERT_THAT_BASENAME_IS_KNOWN
],
	[m4_define([_BASENAME], m4_dquote(INFERRED_BASENAME([m4_fatal([We need to know the basename, and we couldn't infer it. It is likely that you read from stdin and write to stdout, please use at least one filename either for input or for output.])])))],
	[_IF_SOME_ARGS_ARE_DEFINED([m4_do(
		[Usage: _BASENAME],
		[_MAKE_HELP_SYNOPSIS
],
		_IF_HAVE_OPTIONAL_ARGS([m4_do([
Options:
],
		[m4_lists_foreach_optional([_ARGS_LONG,_ARGS_SHORT,_ARGS_CATH,_ARGS_DEFAULT,_ARGS_HELP], [_argname,_arg_short,_arg_type,_arg_default,_arg_help],
			[_APPEND_TO_LISTS(_argname,_arg_short,_arg_type,_arg_default,_arg_help)])],
		[m4_errprintn(m4_list_len([LIST_DOCOPT_OPTIONALS_SPECS]))],
		[m4_errprintn(m4_list_len([_LIST_LOCAL_HELP]))],
		[m4_errprintn(m4_list_len([_LIST_LOCAL_DEFAULTS]))],
		[m4_lists_foreach([LIST_DOCOPT_OPTIONALS_SPECS,_LIST_LOCAL_HELP,_LIST_LOCAL_DEFAULTS], [spec,_arg_help,_arg_default], [m4_dquote(_FORMAT_DOCOPT_OPTION(spec, _LIST_LONGEST_TEXT_LENGTH([LIST_DOCOPT_OPTIONALS_SPECS]), _arg_help, _arg_default))])],
		)])
	)])],
)])


dnl
dnl Identify the Argbash version (this is part of the API)
m4_define([_ARGBASH_ID],
	[### START OF CODE GENERATED BY Argbash v]_ARGBASH_VERSION[ one line above ###])

