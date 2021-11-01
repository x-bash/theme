# shellcheck shell=sh
# shellcheck disable=SC2039

# Section: ___X_CMD_THEME_COLOR bash/ash/dash/... version
# TODO: here
if [[ ! "$*" = *--no-color* ]] && [ -z "${NO_COLOR}" ]; then

___X_CMD_THEME_COLOR_CODE(){
    case "$1" in
        black)      printf 0 ;;
        red)        printf 1 ;;
        green)      printf 2 ;;
        yellow)     printf 3 ;;
        blue)       printf 4 ;;
        magenta)    printf 5 ;;
        cyan)       printf 6 ;;
        white)      printf 7 ;;
    esac
}


___X_CMD_THEME_COLOR() {
      # Set up our Colour Holders.
      case "$1" in
        fg)         printf "\033[0;3$(___X_CMD_THEME_COLOR_CODE "$2")m" ;;
        bfg)        printf "\033[1;3$(___X_CMD_THEME_COLOR_CODE "$2")m" ;;
        bg)         printf "\033[0;4$(___X_CMD_THEME_COLOR_CODE "$2")m" ;;
        ibg)        printf "\033[0;10'$(___X_CMD_THEME_COLOR_CODE "$2")m" ;;
        bold)       printf "\033[1m" ;;
        underline)  printf "\033[4m" ;;
        reset)      printf "\033[0m" ;;
        *)          printf "\033[0m" ;;
    esac
}
fi
# EndSection

###
# @description: set up color
###
# TODO: set function
___X_CMD_THEME_NEWLINE=$'\n'
___X_CMD_THEME_USER='\u'

# Path
___X_CMD_THEME_PATH='\W';
___X_CMD_THEME_FULL_PATH='\w';

# Date
___X_CMD_THEME_DATE='\d';
___X_CMD_THEME_TIME_24_H_M_S='\t';
___X_CMD_THEME_TIME_12_H_M_S='\T';
___X_CMD_THEME_TIME_24_H_M='\A';
___X_CMD_THEME_TIME_12_H_M='\@';

# Host
___X_CMD_THEME_HOST='\h';
___X_CMD_THEME_FULL_HOST='\H';
