# shellcheck shell=sh
# shellcheck disable=SC2039

# variables setup
###
  # @description: set up color
  # @param: fg $color | bg $color | bfg $color | ibg $color | blod | underline | reset
  # @param: $color => black | red | green | yellow | bule | magenta | cyan | white
  # @example1: ___X_CMD_THEME_COLOR fg bule
  # @example2: ___X_CMD_THEME_COLOR blod
  # @example3: ___X_CMD_THEME_COLOR => ___X_CMD_THEME_COLOR reset
###
## Enable our easy to read Colour Flags as long as --no-colors hasn't been passed or the NO_COLOR Env Variable is set.
## NOTE: the NO_COLOR env variable is from: https://no-color.org/

# Section: ___X_CMD_THEME_COLOR zsh version
# zsh https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Visual-effects
# TODO: here
if [[ ! "$*" = *--no-color* ]] && [ -z "${NO_COLOR}" ]; then

___X_CMD_THEME_COLOR() {
      autoload -U colors && colors
      case "$1" in
        fg)           printf "%s" "%{\$fg[$2]%}" ;;
        bfg)          printf "%s" "%{\$fg_bold[$2]%}" ;;
        bg)           printf "%s" "%{\$bg[$2]%}" ;;
        ibg)          printf "%s" "%{\$bg_no_bold[$2]%}" ;;
        bold)         printf "%s" "%B" ;;
        underline)    printf "%s" "%U" ;;
        reset)        printf "%s" "%{\$reset_color%}" ;;
        *)            printf "%s" "%{\$reset_color%}" ;;
    esac
}
fi
# EndSection

###
  # @description: set up color
###
# TODO: set function

___X_CMD_THEME_USER='%n'
# Date                                       # Path
___X_CMD_THEME_DATE='%D';                    ___X_CMD_THEME_PATH='%1d';
___X_CMD_THEME_TIME_24_H_M_S='%*';           ___X_CMD_THEME_FULL_PATH='%~';
___X_CMD_THEME_TIME_12_H_M_S='%D{%L:%M:%S}'; # Host
___X_CMD_THEME_TIME_24_H_M='%T';             ___X_CMD_THEME_HOST='%m';
___X_CMD_THEME_TIME_12_H_M='%@';             ___X_CMD_THEME_FULL_HOST='%M';

