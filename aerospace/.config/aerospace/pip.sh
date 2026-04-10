#!/usr/bin/env bash

ws=${1:-$AEROSPACE_FOCUSED_WORKSPACE}
debug=${AEROSPACE_PIP_DEBUG:-0}
log_file="$HOME/.config/aerospace/pip.log"
sep=$'\x1f'

log() {
  [[ $debug == 1 ]] || return 0
  printf '%s | %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >> "$log_file"
}

all_wins=$(aerospace list-windows --all --format "%{window-id}${sep}%{app-name}${sep}%{window-title}${sep}%{monitor-id}${sep}%{workspace}${sep}%{app-bundle-id}${sep}%{window-parent-container-layout}")
all_ws=$(aerospace list-workspaces --all --format "%{workspace}${sep}%{monitor-id}")

target_mon=''
while IFS="$sep" read -r workspace monitor; do
  [[ $workspace == "$ws" ]] || continue
  target_mon="$monitor"
  break
done <<< "$all_ws"

[[ -n $target_mon ]] || exit 0

log "workspace=$ws target_monitor=$target_mon"
log "windows_start"
while IFS= read -r win; do
  log "window=$win"
done <<< "$all_wins"
log "windows_end"

is_pip_window() {
  local win="$1"
  local _win_id _win_app win_title _win_mon _win_ws win_bundle win_layout
  IFS="$sep" read -r _win_id _win_app win_title _win_mon _win_ws win_bundle win_layout <<< "$win"

  if [[ $win_title == *'Picture in Picture'* ]]; then
    log "pip_match=chrome title=$win_title"
    return 0
  fi

  if [[ $win_bundle == 'com.spotify.client' && $win_layout == 'floating' ]]; then
    log "pip_match=spotify bundle=$win_bundle layout=$win_layout title=$win_title"
    return 0
  fi

  return 1
}

move_win() {
  local win="$1"

  [[ -n $win ]] || return 0

  local win_id win_app _win_title win_mon win_ws _win_bundle _win_layout
  IFS="$sep" read -r win_id win_app _win_title win_mon win_ws _win_bundle _win_layout <<< "$win"

  if [[ $target_mon != $win_mon ]]; then
    log "skip window_id=$win_id reason=monitor_mismatch win_monitor=$win_mon target_monitor=$target_mon"
    return 0
  fi

  if [[ $ws == $win_ws ]]; then
    log "skip window_id=$win_id reason=already_on_workspace workspace=$win_ws"
    return 0
  fi

  log "move window_id=$win_id app=$win_app from_workspace=$win_ws to_workspace=$ws"
  aerospace move-node-to-workspace --window-id "$win_id" "$ws"
}

while IFS= read -r win; do
  is_pip_window "$win" || continue
  move_win "$win"
done <<< "$all_wins"
