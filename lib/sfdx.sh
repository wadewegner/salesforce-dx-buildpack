# <SFDX_AUTH_URL> <d|s> <alias>
auth() {
  
  SFDX_AUTH_URL_FILE="$BUILD_DIR/sfdxurl"
  echo "$1" > $SFDX_AUTH_URL_FILE
  sfdx force:auth:sfdxurl:store -f $SFDX_AUTH_URL_FILE -$2 -a $3

}

# <run_apex_tests> <apex_test_format>
tests() {

  if [ "$1" == "true" ]; then
    sfdx force:apex:test:run -r $2 -u targetorg
  fi

}