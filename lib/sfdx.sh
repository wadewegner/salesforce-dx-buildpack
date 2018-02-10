# <DIR> <SFDX_AUTH_URL> <d|s> <alias>
auth() {
  
  SFDX_AUTH_URL_FILE="$1/sfdxurl"
  echo "$2" > $SFDX_AUTH_URL_FILE
  sfdx force:auth:sfdxurl:store -f $SFDX_AUTH_URL_FILE -$3 -a $4

}

# <run_apex_tests> <apex_test_format>
tests() {

  if [ "$1" == "true" ]; then
    sfdx force:apex:test:run -r $2 -u targetorg
  fi

}