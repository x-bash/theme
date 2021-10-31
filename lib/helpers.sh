# shellcheck shell=sh
# shellcheck disable=SC2039

_command_exists ()
{
  _about 'checks for existence of a command'
  _param '1: command to check'
  _param '2: (optional) log message to include when command not found'
  _example '$ _command_exists ls && echo exists'
  _group 'lib'
  local msg="${2:-Command "$1" does not exist!}"
  type "$1" &> /dev/null || (_log_warning "$msg" && return 1) ;
}
