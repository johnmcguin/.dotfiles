bwfind() {
  bw list items --search $1 | jq '.[] | .name,.login'
}
alias bwf="bwfind"

bwsession() {
  export BW_SESSION=$(bw unlock --raw)
}
alias bws="bwsession"
