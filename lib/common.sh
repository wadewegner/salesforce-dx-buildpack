export_env_dir() {
  whitelist_regex=${2:-$'^(SALESFORCE_|HEROKU_)'}
  blacklist_regex=${3:-'^(PATH|GIT_DIR|CPATH|CPPATH|LD_PRELOAD|LIBRARY_PATH)$'}
  if [ -d "$ENV_DIR" ]; then
    for e in $(ls $ENV_DIR); do
      echo "$e" | grep -E "$whitelist_regex" | grep -qvE "$blacklist_regex" &&
      export $e=$(cat $ENV_DIR/$e)
      :
    done
  fi
}

header() {
  echo "" || true
  echo -e "-----> \e[34m$*\033[0m" || true
  echo "" || true
}

update() {
  echo -e "       $*" || true
}