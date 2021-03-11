# shellcheck shell=sh
# shellcheck disable=SC2039
source ../githelpers.sh
source ../lib/helpers.sh
scm_prompt_info() {
	local SCM SCM_CHECK=${SCM_CHECK:=true} SCM_NONE='NONE' SCM_GIT='git' GIT_EXE P4_EXE SCM_P4='p4'
	local HG_EXE SVN_EXE SCM_HG='hg' SCM_SVN='svn' SCM_THEME_CHAR_PREFIX=''
	GIT_EXE=$(which git 2>/dev/null || true)
	P4_EXE=$(which p4 2>/dev/null || true)
	HG_EXE=$(which hg 2>/dev/null || true)
	SVN_EXE=$(which svn 2>/dev/null || true)
	if [[ "$CHECK_IS_ENTRANCE" = true ]]; then
		scm_prompt_char
	else
		scm
		scm_prompt_char
		scm_prompt_info_common
	fi
}

scm() {
	if [[ "$SCM_CHECK" = false ]]; then
		SCM=$SCM_NONE
	elif [[ -f .git/HEAD ]] && [[ -x "$GIT_EXE" ]]; then
		SCM=$SCM_GIT
	elif [[ -x "$GIT_EXE" ]] && [[ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
		SCM=$SCM_GIT
	elif [[ -x "$P4_EXE" ]] && [[ -n "$(p4 set P4CLIENT 2>/dev/null)" ]]; then
		SCM=$SCM_P4
	elif [[ -d .hg ]] && [[ -x "$HG_EXE" ]]; then
		SCM=$SCM_HG
	elif [[ -x "$HG_EXE" ]] && [[ -n "$(hg root 2>/dev/null)" ]]; then
		SCM=$SCM_HG
	elif [[ -d .svn ]] && [[ -x "$SVN_EXE" ]]; then
		SCM=$SCM_SVN
	elif [[ -x "$SVN_EXE" ]] && [[ -n "$(svn info --show-item wc-root 2>/dev/null)" ]]; then
		SCM=$SCM_SVN
	else
		SCM=$SCM_NONE
	fi
}

scm_prompt_char() {
	if [[ -z $SCM ]]; then scm; fi
	if [[ $SCM == "$SCM_GIT" ]]; then
		SCM_CHAR='±'
	elif [[ $SCM == "$SCM_P4" ]]; then
		SCM_CHAR='⌛'
	elif [[ $SCM == "$SCM_HG" ]]; then
		SCM_CHAR='☿'
	elif [[ $SCM == "$SCM_SVN" ]]; then
		SCM_CHAR='⑆'
	else
		SCM_CHAR='○'
	fi
}

scm_prompt_info_common() {
	local SCM_BRANCH
	local SCM_GIT_SHOW_MINIMAL_INFO=${SCM_GIT_SHOW_MINIMAL_INFO:=true}
	if [[ ${SCM} == "${SCM_GIT}" ]]; then
		git_prompt_minimal_info
		return
	fi

	# TODO: consider adding minimal status information for hg and svn
	{ [[ ${SCM} == "${SCM_P4}" ]] && p4_prompt_info && return; } || true
	{ [[ ${SCM} == "${SCM_HG}" ]] && hg_prompt_info && return; } || true
	{ [[ ${SCM} == "${SCM_SVN}" ]] && svn_prompt_info && return; } || true
}

git_prompt_minimal_info() {
	# _git-hide-status && return
	SCM_BRANCH="\$(_git-friendly-ref)"

	# Output the git prompt
	echo -e "${SCM_BRANCH}"
}

scm_char() {
	local CHECK_IS_ENTRANCE=true
	scm_prompt_info
	echo -e "${SCM_THEME_CHAR_PREFIX}${SCM_CHAR}${SCM_THEME_CHAR_SUFFIX}"
}
safe_append_prompt_command() {
	local prompt_re
	if [ "${__bp_imported}" == "defined" ]; then
		# We are using bash-preexec
		if ! __check_precmd_conflict "${1}"; then
			precmd_functions+=("${1}")
		fi
	else
		# Set OS dependent exact match regular expression
		if [[ ${OSTYPE} == darwin* ]]; then
			# macOS
			prompt_re="[[:<:]]${1}[[:>:]]"
		else
			# Linux, FreeBSD, etc.
			prompt_re="\<${1}\>"
		fi

		if [[ ${PROMPT_COMMAND} =~ ${prompt_re} ]]; then
			return
		elif [[ -z ${PROMPT_COMMAND} ]]; then
			PROMPT_COMMAND="${1}"
		else
			PROMPT_COMMAND="${1};${PROMPT_COMMAND}"
		fi
	fi
}
