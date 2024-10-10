# bitwarden
function bwfind() {
  bw list items --search $1 | jq '.[] | .name,.login'
}
alias bwf="bwfind"

function bwsession() {
  export BW_SESSION=$(bw unlock --raw)
}
alias bws="bwsession"

# node utils
function nscripts() {
  cat package.json | jq '.scripts'
}

# shell helpers
# make directory and cd into it
function mkdircd() {
  mkdir -p $1 && cd $_
}

function travel() {
    local options=()
    # Get recent directories and create an array of local options.
    # Can't directly `select` over $(dirs -p) due to formatting
    while read -r dir; do
        options+=("$dir")
    done < <(dirs -p)

    select dir in "${options[@]}"; do test -n "$dir" && break; echo "Invalid Selection"; done
    eval cd "$dir"
}
