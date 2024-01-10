# bitwarden
bwfind() {
  bw list items --search $1 | jq '.[] | .name,.login'
}
alias bwf="bwfind"

bwsession() {
  export BW_SESSION=$(bw unlock --raw)
}
alias bws="bwsession"

# node utils
nscripts() {
  cat package.json | jq '.scripts'
}

# shell helpers
# make directory and cd into it
function mkdircd() {
  mkdir -p $1 && cd $_
}
