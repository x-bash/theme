# shellcheck shell=sh
# shellcheck disable=SC2039

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
if [[ ! $* == *--no-color* && -z "${NO_COLOR}" ]]
then
  if [ -n "$ZSH_VERSION" ]; then
  # zsh color set up
  # zsh https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Visual-effects
  ___X_CMD_THEME_COLOR() {
        autoload -U colors && colors
        # Set up our Colour Holders.
        local ___X_CMD_THEME_COL_PRE='%{'
        local ___X_CMD_THEME_COL_SUF='%}'
        # Text Reset
        local ___X_CMD_THEME_RESET=$___X_CMD_THEME_COL_PRE"$reset_color"$___X_CMD_THEME_COL_SUF
        local ___X_CMD_THEME_BOLD="%B";    local ___X_CMD_THEME_UNDERLINE="%U"

        # Regular                                                                                     Bold
        local ___X_CMD_THEME_FG_BLACK=$___X_CMD_THEME_COL_PRE"$fg[black]"$___X_CMD_THEME_COL_SUF;     local ___X_CMD_THEME_BFG_BLACK=$___X_CMD_THEME_COL_PRE"$fg_bold[black]"$___X_CMD_THEME_COL_SUF;
        local ___X_CMD_THEME_FG_RED=$___X_CMD_THEME_COL_PRE"$fg[red]"$___X_CMD_THEME_COL_SUF;         local ___X_CMD_THEME_BFG_RED=$___X_CMD_THEME_COL_PRE"$fg_bold[red]"$___X_CMD_THEME_COL_SUF;
        local ___X_CMD_THEME_FG_GREEN=$___X_CMD_THEME_COL_PRE"$fg[green]"$___X_CMD_THEME_COL_SUF;     local ___X_CMD_THEME_BFG_GREEN=$___X_CMD_THEME_COL_PRE"$fg_bold[green]"$___X_CMD_THEME_COL_SUF;
        local ___X_CMD_THEME_FG_YELLOW=$___X_CMD_THEME_COL_PRE"$fg[yellow]"$___X_CMD_THEME_COL_SUF;   local ___X_CMD_THEME_BFG_YELLOW=$___X_CMD_THEME_COL_PRE"$fg_bold[yellow]"$___X_CMD_THEME_COL_SUF;
        local ___X_CMD_THEME_FG_BLUE=$___X_CMD_THEME_COL_PRE"$fg[blue]"$___X_CMD_THEME_COL_SUF;       local ___X_CMD_THEME_BFG_BLUE=$___X_CMD_THEME_COL_PRE"$fg_bold[blue]"$___X_CMD_THEME_COL_SUF;
        local ___X_CMD_THEME_FG_MAGENTA=$___X_CMD_THEME_COL_PRE"$fg[magenta]"$___X_CMD_THEME_COL_SUF; local ___X_CMD_THEME_BFG_MAGENTA=$___X_CMD_THEME_COL_PRE"$fg_bold[magenta]"$___X_CMD_THEME_COL_SUF;
        local ___X_CMD_THEME_FG_CYAN=$___X_CMD_THEME_COL_PRE"$fg[cyan]"$___X_CMD_THEME_COL_SUF;       local ___X_CMD_THEME_BFG_CYAN=$___X_CMD_THEME_COL_PRE"$fg_bold[cyan]"$___X_CMD_THEME_COL_SUF;
        local ___X_CMD_THEME_FG_WHITE=$___X_CMD_THEME_COL_PRE"$fg[white]"$___X_CMD_THEME_COL_SUF;     local ___X_CMD_THEME_BFG_WHITE=$___X_CMD_THEME_COL_PRE"$fg_bold[white]"$___X_CMD_THEME_COL_SUF;

        # Background                                                                                  High Intensity Backgrounds
        local ___X_CMD_THEME_BG_BLACK=$___X_CMD_THEME_COL_PRE"$bg[black]"$___X_CMD_THEME_COL_SUF;     local ___X_CMD_THEME_IBG_BLACK=$___X_CMD_THEME_COL_PRE"$bg_no_bold[black]"$___X_CMD_THEME_COL_SUF;
        local ___X_CMD_THEME_BG_RED=$___X_CMD_THEME_COL_PRE"$bg[red]"$___X_CMD_THEME_COL_SUF;         local ___X_CMD_THEME_IBG_RED=$___X_CMD_THEME_COL_PRE"$bg_no_bold[red]"$___X_CMD_THEME_COL_SUF;
        local ___X_CMD_THEME_BG_GREEN=$___X_CMD_THEME_COL_PRE"$bg[green]"$___X_CMD_THEME_COL_SUF;     local ___X_CMD_THEME_IBG_GREEN=$___X_CMD_THEME_COL_PRE"$bg_no_bold[green]"$___X_CMD_THEME_COL_SUF;
        local ___X_CMD_THEME_BG_YELLOW=$___X_CMD_THEME_COL_PRE"$bg[yellow]"$___X_CMD_THEME_COL_SUF;   local ___X_CMD_THEME_IBG_YELLOW=$___X_CMD_THEME_COL_PRE"$bg_no_bold[yellow]"$___X_CMD_THEME_COL_SUF;
        local ___X_CMD_THEME_BG_BLUE=$___X_CMD_THEME_COL_PRE"$bg[blue]"$___X_CMD_THEME_COL_SUF;       local ___X_CMD_THEME_IBG_BLUE=$___X_CMD_THEME_COL_PRE"$bg_no_bold[blue]"$___X_CMD_THEME_COL_SUF;
        local ___X_CMD_THEME_BG_MAGENTA=$___X_CMD_THEME_COL_PRE"$bg[magenta]"$___X_CMD_THEME_COL_SUF; local ___X_CMD_THEME_IBG_MAGENTA=$___X_CMD_THEME_COL_PRE"$bg_no_bold[magenta]"$___X_CMD_THEME_COL_SUF;
        local ___X_CMD_THEME_BG_CYAN=$___X_CMD_THEME_COL_PRE"$bg[cyan]"$___X_CMD_THEME_COL_SUF;       local ___X_CMD_THEME_IBG_CYAN=$___X_CMD_THEME_COL_PRE"$bg_no_bold[cyan]"$___X_CMD_THEME_COL_SUF;
        local ___X_CMD_THEME_BG_WHITE=$___X_CMD_THEME_COL_PRE"$bg[white]"$___X_CMD_THEME_COL_SUF;     local ___X_CMD_THEME_IBG_WHITE=$___X_CMD_THEME_COL_PRE"$bg_no_bold[white]"$___X_CMD_THEME_COL_SUF;

        case "$1" in
        fg)
          case "$2" in
            black)
              printf "%s" $___X_CMD_THEME_FG_BLACK
            ;;
            red)
              printf "%s" $___X_CMD_THEME_FG_RED
            ;;
            green)
              printf "%s" $___X_CMD_THEME_FG_GREEN
            ;;
            yellow)
              printf "%s" $___X_CMD_THEME_FG_YELLOW
            ;;
            bule)
              printf "%s" $___X_CMD_THEME_FG_BLUE
            ;;
            magenta)
              printf "%s" $___X_CMD_THEME_FG_MAGENTA
            ;;
            cyan)
              printf "%s" $___X_CMD_THEME_FG_CYAN
            ;;
            white)
              printf "%s" $___X_CMD_THEME_FG_WHITE
            ;;
            *)
              printf "%s" $___X_CMD_THEME_RESET
            ;;
          esac
        ;;
        bfg)
          case "$2" in
            black)
              printf "%s" $___X_CMD_THEME_BFG_BLACK
            ;;
            red)
              printf "%s" $___X_CMD_THEME_BFG_RED
            ;;
            green)
              printf "%s" $___X_CMD_THEME_BFG_GREEN
            ;;
            yellow)
              printf "%s" $___X_CMD_THEME_BFG_YELLOW
            ;;
            bule)
              printf "%s" $___X_CMD_THEME_BFG_BLUE
            ;;
            magenta)
              printf "%s" $___X_CMD_THEME_BFG_MAGENTA
            ;;
            cyan)
              printf "%s" $___X_CMD_THEME_BFG_CYAN
            ;;
            white)
              printf "%s" $___X_CMD_THEME_BFG_WHITE
            ;;
            *)
              printf "%s" $___X_CMD_THEME_RESET
            ;;
          esac
        ;;
        bg)
          case "$2" in
            black)
              printf "%s" $___X_CMD_THEME_BG_BLACK
            ;;
            red)
              printf "%s" $___X_CMD_THEME_BG_RED
            ;;
            green)
              printf "%s" $___X_CMD_THEME_BG_GREEN
            ;;
            yellow)
              printf "%s" $___X_CMD_THEME_BG_YELLOW
            ;;
            bule)
              printf "%s" $___X_CMD_THEME_BG_BLUE
            ;;
            magenta)
              printf "%s" $___X_CMD_THEME_BG_MAGENTA
            ;;
            cyan)
              printf "%s" $___X_CMD_THEME_BG_CYAN
            ;;
            white)
              printf "%s" $___X_CMD_THEME_BG_WHITE
            ;;
            *)
              printf "%s" $___X_CMD_THEME_RESET
            ;;
          esac
        ;;
        ibg)
          case "$2" in
            black)
              printf "%s" $___X_CMD_THEME_IBG_BLACK
            ;;
            red)
              printf "%s" $___X_CMD_THEME_IBG_RED
            ;;
            green)
              printf "%s" $___X_CMD_THEME_IBG_GREEN
            ;;
            yellow)
              printf "%s" $___X_CMD_THEME_IBG_YELLOW
            ;;
            bule)
              printf "%s" $___X_CMD_THEME_IBG_BLUE
            ;;
            magenta)
              printf "%s" $___X_CMD_THEME_IBG_MAGENTA
            ;;
            cyan)
              printf "%s" $___X_CMD_THEME_IBG_CYAN
            ;;
            white)
              printf "%s" $___X_CMD_THEME_IBG_WHITE
            ;;
            *)
              printf "%s" $___X_CMD_THEME_RESET
            ;;
          esac
        ;;
        bold)
          printf "%s" $___X_CMD_THEME_BOLD
        ;;
        underline)
          printf "%s" $___X_CMD_THEME_UNDERLINE
        ;;
        reset)
          printf "%s" $___X_CMD_THEME_RESET
        ;;
        *)
          printf "%s" $___X_CMD_THEME_RESET
        ;;
      esac
  }
  fi
  # bash color set up
  ___X_CMD_THEME_COLOR() {
        # Set up our Colour Holders.
        local ___X_CMD_THEME_LCP="\033["
        # Text Reset
        local ___X_CMD_THEME_RESET="$___X_CMD_THEME_LCP"'0m'
        local ___X_CMD_THEME_BOLD="$___X_CMD_THEME_LCP"'1m';          local ___X_CMD_THEME_UNDERLINE="$___X_CMD_THEME_LCP"'4m'

        # Regular                                               Bold
        local ___X_CMD_THEME_FG_BLACK="$___X_CMD_THEME_LCP"'0;30m';   local ___X_CMD_THEME_BFG_BLACK="$___X_CMD_THEME_LCP"'1;30m';
        local ___X_CMD_THEME_FG_RED="$___X_CMD_THEME_LCP"'0;31m';     local ___X_CMD_THEME_BFG_RED="$___X_CMD_THEME_LCP"'1;31m';
        local ___X_CMD_THEME_FG_GREEN="$___X_CMD_THEME_LCP"'0;32m';   local ___X_CMD_THEME_BFG_GREEN="$___X_CMD_THEME_LCP"'1;32m';
        local ___X_CMD_THEME_FG_YELLOW="$___X_CMD_THEME_LCP"'0;33m';  local ___X_CMD_THEME_BFG_YELLOW="$___X_CMD_THEME_LCP"'1;33m';
        local ___X_CMD_THEME_FG_BLUE="$___X_CMD_THEME_LCP"'0;34m';    local ___X_CMD_THEME_BFG_BLUE="$___X_CMD_THEME_LCP"'1;34m';
        local ___X_CMD_THEME_FG_MAGENTA="$___X_CMD_THEME_LCP"'0;35m'; local ___X_CMD_THEME_BFG_MAGENTA="$___X_CMD_THEME_LCP"'1;35m';
        local ___X_CMD_THEME_FG_CYAN="$___X_CMD_THEME_LCP"'0;36m';    local ___X_CMD_THEME_BFG_CYAN="$___X_CMD_THEME_LCP"'1;36m';
        local ___X_CMD_THEME_FG_WHITE="$___X_CMD_THEME_LCP"'0;37m';   local ___X_CMD_THEME_BFG_WHITE="$___X_CMD_THEME_LCP"'1;37m';

        # Background                                            High Intensity Backgrounds
        local ___X_CMD_THEME_BG_BLACK="$___X_CMD_THEME_LCP"'40m';     local ___X_CMD_THEME_IBG_BLACK="$___X_CMD_THEME_LCP"'0;100m';
        local ___X_CMD_THEME_BG_RED="$___X_CMD_THEME_LCP"'41m';       local ___X_CMD_THEME_IBG_RED="$___X_CMD_THEME_LCP"'0;101m';
        local ___X_CMD_THEME_BG_GREEN="$___X_CMD_THEME_LCP"'42m';     local ___X_CMD_THEME_IBG_GREEN="$___X_CMD_THEME_LCP"'0;102m';
        local ___X_CMD_THEME_BG_YELLOW="$___X_CMD_THEME_LCP"'43m';    local ___X_CMD_THEME_IBG_YELLOW="$___X_CMD_THEME_LCP"'0;103m';
        local ___X_CMD_THEME_BG_BLUE="$___X_CMD_THEME_LCP"'44m';      local ___X_CMD_THEME_IBG_BLUE="$___X_CMD_THEME_LCP"'0;104m';
        local ___X_CMD_THEME_BG_MAGENTA="$___X_CMD_THEME_LCP"'45m';   local ___X_CMD_THEME_IBG_MAGENTA="$___X_CMD_THEME_LCP"'0;105m';
        local ___X_CMD_THEME_BG_CYAN="$___X_CMD_THEME_LCP"'46m';      local ___X_CMD_THEME_IBG_CYAN="$___X_CMD_THEME_LCP"'0;106m';
        local ___X_CMD_THEME_BG_WHITE="$___X_CMD_THEME_LCP"'47m';     local ___X_CMD_THEME_IBG_WHITE="$___X_CMD_THEME_LCP"'0;107m';

        case "$1" in
        fg)
          case "$2" in
            black)
              printf $___X_CMD_THEME_FG_BLACK
            ;;
            red)
              printf $___X_CMD_THEME_FG_RED
            ;;
            green)
              printf $___X_CMD_THEME_FG_GREEN
            ;;
            yellow)
              printf $___X_CMD_THEME_FG_YELLOW
            ;;
            bule)
              printf $___X_CMD_THEME_FG_BLUE
            ;;
            magenta)
              printf $___X_CMD_THEME_FG_MAGENTA
            ;;
            cyan)
              printf $___X_CMD_THEME_FG_CYAN
            ;;
            white)
              printf $___X_CMD_THEME_FG_WHITE
            ;;
            *)
              printf $___X_CMD_THEME_RESET
            ;;
          esac
        ;;
        bfg)
          case "$2" in
            black)
              printf $___X_CMD_THEME_BFG_BLACK
            ;;
            red)
              printf $___X_CMD_THEME_BFG_RED
            ;;
            green)
              printf $___X_CMD_THEME_BFG_GREEN
            ;;
            yellow)
              printf $___X_CMD_THEME_BFG_YELLOW
            ;;
            bule)
              printf $___X_CMD_THEME_BFG_BLUE
            ;;
            magenta)
              printf $___X_CMD_THEME_BFG_MAGENTA
            ;;
            cyan)
              printf $___X_CMD_THEME_BFG_CYAN
            ;;
            white)
              printf $___X_CMD_THEME_BFG_WHITE
            ;;
            *)
              printf $___X_CMD_THEME_RESET
            ;;
          esac
        ;;
        bg)
          case "$2" in
            black)
              printf $___X_CMD_THEME_BG_BLACK
            ;;
            red)
              printf $___X_CMD_THEME_BG_RED
            ;;
            green)
              printf $___X_CMD_THEME_BG_GREEN
            ;;
            yellow)
              printf $___X_CMD_THEME_BG_YELLOW
            ;;
            bule)
              printf $___X_CMD_THEME_BG_BLUE
            ;;
            magenta)
              printf $___X_CMD_THEME_BG_MAGENTA
            ;;
            cyan)
              printf $___X_CMD_THEME_BG_CYAN
            ;;
            white)
              printf $___X_CMD_THEME_BG_WHITE
            ;;
            *)
              printf $___X_CMD_THEME_RESET
            ;;
          esac
        ;;
        ibg)
          case "$2" in
            black)
              printf $___X_CMD_THEME_IBG_BLACK
            ;;
            red)
              printf $___X_CMD_THEME_IBG_RED
            ;;
            green)
              printf $___X_CMD_THEME_IBG_GREEN
            ;;
            yellow)
              printf $___X_CMD_THEME_IBG_YELLOW
            ;;
            bule)
              printf $___X_CMD_THEME_IBG_BLUE
            ;;
            magenta)
              printf $___X_CMD_THEME_IBG_MAGENTA
            ;;
            cyan)
              printf $___X_CMD_THEME_IBG_CYAN
            ;;
            white)
              printf $___X_CMD_THEME_IBG_WHITE
            ;;
            *)
              printf $___X_CMD_THEME_RESET
            ;;
          esac
        ;;
        bold)
          printf $___X_CMD_THEME_BOLD
        ;;
        underline)
          printf $___X_CMD_THEME_UNDERLINE
        ;;
        reset)
          printf $___X_CMD_THEME_RESET
        ;;
        *)
          printf $___X_CMD_THEME_RESET
        ;;
      esac
  }
fi
