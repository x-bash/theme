# shellcheck shell=sh
# shellcheck disable=SC2039

___X_CMD_THEME_PROMPT_GET_INFO(){

  case "$(___X_CMD_THEME_GET_PROMPT_INFO_EXE)" in
    git)
      # printf "${___X_CMD_THEME_PROMPT_PREFIX}git:${___X_CMD_THEME_FG_CYAN}$(___X_CMD_THEME_GET_PROMPT_INFO_VALUE)${___X_CMD_THEME_RESET} \n"
      printf "%s" "${___X_CMD_THEME_PROMPT_PREFIX}git:$(___X_CMD_THEME_COLOR fg cyan)$(___X_CMD_THEME_GET_PROMPT_INFO_VALUE)$(___X_CMD_THEME_COLOR)"
    ;;
    *)
      return
    ;;
  esac
}

# Prompt format:
___X_CMD_THEME_PROMPT_FORMAT(){
  local ___X_CMD_THEME_PROMPT_PRE_ICON='💠'
  local ___X_CMD_THEME_PROMPT_SYMBOL='ᐅ'
  local ___X_CMD_THEME_PROMPT_USERNAME="$(___X_CMD_THEME_COLOR fg cyan)${___X_CMD_THEME_USER}$(___X_CMD_THEME_COLOR)"
  local ___X_CMD_THEME_PROMPT_PATH="$(___X_CMD_THEME_COLOR bfg yellow)${___X_CMD_THEME_FULL_PATH}$(___X_CMD_THEME_COLOR)"
  local ___X_CMD_THEME_PROMPT_TIME="[${___X_CMD_THEME_TIME_24_H_M_S}]"

  local ___X_CMD_THEME_PROMPT_PREFIX=" $(___X_CMD_THEME_COLOR)on "
  local ___X_CMD_THEME_PROMPT_PREFIX_INFO=":$(___X_CMD_THEME_COLOR fg cyan)"
  local ___X_CMD_THEME_PROMPT_SUFFIX="$(___X_CMD_THEME_COLOR)"
  printf "%s" "
${___X_CMD_THEME_PROMPT_PRE_ICON}${___X_CMD_THEME_PROMPT_USERNAME} ${___X_CMD_THEME_PROMPT_PATH} \$(___X_CMD_THEME_PROMPT_GET_INFO) ${___X_CMD_THEME_PROMPT_TIME}
$(___X_CMD_THEME_COLOR bfg green)${___X_CMD_THEME_PROMPT_SYMBOL}$(___X_CMD_THEME_COLOR) "
}
