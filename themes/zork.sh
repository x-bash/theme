# shellcheck shell=sh
# shellcheck disable=SC2039
source ../theme.sh
case $TERM in
xterm*)
    TITLEBAR="\[\033]0;\w\007\]"
    ;;
*)
    TITLEBAR=""
    ;;
esac

PS3=">> "


modern_scm_prompt() {
    local CHAR SCM_NONE_CHAR='○'
    CHAR=$(scm_char)
    if [ "$CHAR" = "$SCM_NONE_CHAR" ]; then
        return
    else
        echo "[$(scm_prompt_info)]"
    fi
}

# show chroot if exist
chroot() {
    if [ -n "$debian_chroot" ]; then
       local my_ps_chroot="\[\e[36;1m\]$debian_chroot\[\e[0m\]"
        echo "($my_ps_chroot)"
    fi
}

prompt() {
    local my_ps_host="\[\e[0;32m\]\h\[\e[0m\]"
    local my_ps_host_root="\[\e[0;32m\]\h\[\e[0m\]"
    local my_ps_host_time="\t"

    case "$(id -u)" in
    0)
        PS1="${TITLEBAR}┌─$(chroot)[${my_ps_host_time}][$my_ps_host_root]$(modern_scm_prompt)[\[\e[0;36m\]\w\[\e[0m\]]
└─▪ "
        ;;
    *)
        PS1="${TITLEBAR}┌─$(chroot)[${my_ps_host_time}][$my_ps_host]$(modern_scm_prompt)[\[\e[0;36m\]\w\[\e[0m\]]
└─▪ "
        ;;
    esac
}

PS2="└─▪ "

safe_append_prompt_command prompt
