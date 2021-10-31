# shellcheck shell=sh
# shellcheck disable=SC2039
 ___X_CMD_THEME_GET_GIT_FRIENDLY_REF() {
   ___X_CMD_THEME_GET_GIT_BRANCH || ___X_CMD_THEME_GET_GIT_TAG || ___X_CMD_THEME_GET_SHORT_SHA
}

___X_CMD_THEME_GET_GIT_BRANCH() {
    git symbolic-ref -q --short HEAD 2> /dev/null || return 1
}

___X_CMD_THEME_GET_GIT_TAG() {
    git describe --tags --exact-match 2> /dev/null || return 1
}

___X_CMD_THEME_GET_SHORT_SHA() {
    git rev-parse --short HEAD 2> /dev/null
}