my_git_prompt_status() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  INDEX=$(command git status --porcelain -b 2> /dev/null)
  STATUS=""
  INDEXED=""
  WORKING=""

  # index counters
  local count_added=$(echo "$INDEX" | grep -c '^A')
  local count_modified=$(echo "$INDEX" | grep -c -E '^[MR]')
  local count_deleted=$(echo "$INDEX" | grep -c '^D')
  local count_conflict=$(echo "$INDEX" | grep -c '^U')
  # working tree counters
  local count_untracked=$(echo "$INDEX" | grep -c -E '^[\?A][\?A] ')
  local count_modified_=$(echo "$INDEX" | grep -c -E '^[A-Z ][MR] ')
  local count_deleted_=$(echo "$INDEX" | grep -c -E '^[A-Z ]D ')
  local count_conflict_=$(echo "$INDEX" | grep -c '^[A-Z ]U ')

  # index
  if $(echo "$INDEX" | grep '^A' &> /dev/null) || $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    INDEXED=" +$count_added"
  fi
  if $(echo "$INDEX" | grep '^[MR]' &> /dev/null); then
    INDEXED="$INDEXED ~$count_modified"
  fi
  if $(echo "$INDEX" | grep '^D' &> /dev/null); then
    INDEXED="$INDEXED -$count_deleted"
  fi
  if $(echo "$INDEX" | grep '^U' &> /dev/null); then
    INDEXED="$INDEXED !$count_conflict"
  fi

  # working directory
  if $(echo "$INDEX" | grep -E '^[\?A][\?A] ' &> /dev/null); then
    WORKING=" +$count_untracked"
  fi
  if $(echo "$INDEX" | grep -E '^[A-Z ][MR] ' &> /dev/null); then
    WORKING="$WORKING ~$count_modified_"
  fi
  if $(echo "$INDEX" | grep -E '^[A-Z ]D ' &> /dev/null); then
    WORKING="$WORKING -$count_deleted_"
  fi
  if $(echo "$INDEX" | grep '^[A-Z ]U ' &> /dev/null); then
    WORKING="$WORKING !$count_conflict_"
  fi

  if [[ $count_untracked > 0 ]]; then
    WORKING="$WORKING !"
  fi

  if [[ $INDEXED != "" ]]; then
    INDEXED="$rt_green$INDEXED"
  fi

  if [[ $WORKING != "" ]]; then
    WORKING="$rt_red$WORKING"
  fi

  if [[ $INDEXED != "" && $WORKING != "" ]]; then
    STATUS="$INDEXED $rt_orange|$WORKING"
  else
    STATUS="$INDEXED$WORKING"
  fi

  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    STATUS="$STATUS $rt_orange*"
  fi

  echo "$STATUS$rt_orange]"
}

PROMPT='%(?,%{$fg[green]%},%{$fg[red]%}) λ '
# RPS1='%{$fg[blue]%}%~%{$reset_color%} '
RPS1='%{$fg[white]%}%2~$(git_prompt_info)$(my_git_prompt_status) %{$fg_bold[blue]%}%m%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} ⚡%{$fg[yellow]%} "
