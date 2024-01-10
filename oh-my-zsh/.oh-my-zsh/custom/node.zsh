# nscripts for "node scripts"
nscripts() {
  cat package.json | jq '.scripts'
}
