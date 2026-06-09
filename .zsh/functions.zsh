
function get-colors() {
    for i in {0..255}; do
         print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'};
    done
}


function iterm_tab_color() {
  if [ $# -eq 0 ]; then
    # Reset tab color if called with no arguments
    echo -ne "\033]6;1;bg;*;default\a"
    return 0
  elif [ $# -eq 1 ]; then
    if ( [[ $1 == \#* ]] ); then
      # If single argument starts with '#', skip first character to find hex value
      RED_HEX=${1:1:2}
      GREEN_HEX=${1:3:2}
      BLUE_HEX=${1:5:2}
    else
      # If single argument doesn't start with '#', assume it's hex value
      RED_HEX=${1:0:2}
      GREEN_HEX=${1:2:2}
      BLUE_HEX=${1:4:2}
    fi

    RED=$(( 16#${RED_HEX} ))
    GREEN=$(( 16#${GREEN_HEX} ))
    BLUE=$(( 16#${BLUE_HEX} ))

    echo -ne "\033]6;1;bg;red;brightness;$RED\a"
    echo -ne "\033]6;1;bg;green;brightness;$GREEN\a"
    echo -ne "\033]6;1;bg;blue;brightness;$BLUE\a"

    return 0
  fi

  # If more than 1 argument, assume 3 arguments were passed
  echo -ne "\033]6;1;bg;red;brightness;$1\a"
  echo -ne "\033]6;1;bg;green;brightness;$2\a"
  echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

alias tc='iterm_tab_color'


rtmux() {
  local host="${1:?usage: rtmux host [session] [dir]}"
  local session="${2:-main}"
  local dir="${3:-}"
  local remote_cmd=""
  if [[ -n "$dir" ]]; then
      remote_cmd="cd $(printf %q "$dir") && "
  fi
  remote_cmd="${remote_cmd}tmux new -A -s $(printf %q "$session")"

  local delay=5 max_delay=300 max_retries=10 retries=0

  trap 'return 0' INT

  while true; do
    local start=$SECONDS
    # -a disables ssh-agent forwarding so the remote uses its OWN agent.
    # Forwarded agent dies on disconnect; a cert minted on the devpod survives.
    ssh -a \
        -o "ControlMaster=no" \
        -o "ServerAliveInterval=30" \
        -o "ServerAliveCountMax=3" \
        -o "ExitOnForwardFailure=no" \
        -t "$host" "$remote_cmd"
    local rc=$?

    [[ $rc -eq 0 ]] && break

    # Connection lasted > 60s — was a real session, reset backoff
    if (( SECONDS - start > 60 )); then
      delay=5
      retries=0
    else
      (( retries++ ))
    fi

    if (( retries >= max_retries )); then
      echo "rtmux: gave up after $max_retries consecutive failures" >&2
      return 1
    fi

    echo "rtmux: reconnecting in ${delay}s (attempt $retries/$max_retries)..." >&2
    sleep $delay
    delay=$(( delay * 2 ))
    (( delay > max_delay )) && delay=$max_delay
  done
}