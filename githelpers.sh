# shellcheck shell=sh
# shellcheck disable=SC2039
 _git-friendly-ref() {
  if [[ "${SCM_GIT_GITSTATUS_RAN}" == "true" ]]; then
    _git-branch || _git-tag || _git-short-sha # there is no tag based describe output in gitstatus
  else
    _git-branch || _git-tag || _git-commit-description || _git-short-sha
  fi
}

_git-branch() {
    git symbolic-ref -q --short HEAD 2> /dev/null || return 1
}

_git-tag() {
    git describe --tags --exact-match 2> /dev/null
}

_git-commit-description() {
  git describe --contains --all 2> /dev/null
}

_git-short-sha() {
    git rev-parse --short HEAD
}