# shellcheck shell=sh
# shellcheck disable=SC2039

. /Users/qbenben/project/lteam/x-bash/theme/lib/githelpers.sh

# Set up common variables.
# TODO: set function
___X_CMD_THEME_NEWLINE=$'\n'
___X_CMD_THEME_USER='\u'
# Date                                         # Path
___X_CMD_THEME_DATE='\d';                      ___X_CMD_THEME_PATH='\W';
___X_CMD_THEME_TIME_24_H_M_S='\t';             ___X_CMD_THEME_FULL_PATH='\w';
___X_CMD_THEME_TIME_12_H_M_S='\T';             # Host
___X_CMD_THEME_TIME_24_H_M='\A';               ___X_CMD_THEME_HOST='\h';
___X_CMD_THEME_TIME_12_H_M='\@';               ___X_CMD_THEME_FULL_HOST='\H';

if [ -n "$ZSH_VERSION" ]; then
  ___X_CMD_THEME_USER='%n'
  # Date                                       # Path
  ___X_CMD_THEME_DATE='%D';                    ___X_CMD_THEME_PATH='%1d';
  ___X_CMD_THEME_TIME_24_H_M_S='%*';           ___X_CMD_THEME_FULL_PATH='%~';
  ___X_CMD_THEME_TIME_12_H_M_S='%D{%L:%M:%S}'; # Host
  ___X_CMD_THEME_TIME_24_H_M='%T';             ___X_CMD_THEME_HOST='%m';
  ___X_CMD_THEME_TIME_12_H_M='%@';             ___X_CMD_THEME_FULL_HOST='%M';
fi


# Set up verison variables

___X_CMD_THEME_GET_PROMPT_INFO_EXE() {
	local VALUE_NONE='NONE'
	if [[ -n "$___X_CMD_THEME_NO_CHECK_EXE" && "$___X_CMD_THEME_NO_CHECK_EXE" == true ]]; then
		printf $VALUE_NONE
	fi
	local GIT_EXE P4_EXE HG_EXE SVN_EXE
	local VLAUE_GIT='git' VLAUE_P4='p4' VLAUE_HG='hg' VLAUE_SVN='svn'
	GIT_EXE=$(which git 2>/dev/null || true)
	HG_EXE=$(which hg 2>/dev/null || true)
	P4_EXE=$(which p4 2>/dev/null || true)
	SVN_EXE=$(which svn 2>/dev/null || true)
	if [[ -f .git/HEAD ]] && [[ -x "$GIT_EXE" ]]; then
		printf $VLAUE_GIT 
	elif [[ -x "$GIT_EXE" ]] && [[ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
		printf $VLAUE_GIT
	elif [[ -x "$P4_EXE" ]] && [[ -n "$(p4 set P4CLIENT 2>/dev/null)" ]]; then
		printf $VLAUE_P4
	elif [[ -d .hg ]] && [[ -x "$HG_EXE" ]]; then
		printf $VLAUE_HG
	elif [[ -x "$HG_EXE" ]] && [[ -n "$(hg root 2>/dev/null)" ]]; then
		printf $VLAUE_HG
	elif [[ -d .svn ]] && [[ -x "$SVN_EXE" ]]; then
		printf $VLAUE_SVN
	elif [[ -x "$SVN_EXE" ]] && [[ -n "$(svn info --show-item wc-root 2>/dev/null)" ]]; then
		printf $VLAUE_SVN
	else
		printf $VALUE_NONE
	fi
}

___X_CMD_THEME_GET_PROMPT_INFO_VALUE() {
	local ___PROMPT_INFO_EXE="$(___X_CMD_THEME_GET_PROMPT_INFO_EXE)"
	local VLAUE_GIT='git' VLAUE_P4='p4' VLAUE_HG='hg' VLAUE_SVN='svn'
	if [[ $___PROMPT_INFO_EXE == $VLAUE_GIT ]]; then
    printf "$(___X_CMD_THEME_GET_GIT_FRIENDLY_REF)"
		return
	fi
	printf ""
	# TODO: consider adding minimal status information for hg and svn
	{ [[ $___PROMPT_INFO_EXE == $VLAUE_P4 ]] && p4_prompt_info && return; } || true
	{ [[ $___PROMPT_INFO_EXE == $VLAUE_HG ]] && hg_prompt_info && return; } || true
	{ [[ $___PROMPT_INFO_EXE == $VLAUE_SVN ]] && svn_prompt_info && return; } || true
}