# <SFDX_AUTH_URL> <d|s> <alias>
auth() {
  
  SFDX_AUTH_URL_FILE="$BUILD_DIR/sfdxurl"
  echo "$1" > $SFDX_AUTH_URL_FILE
  sfdx force:auth:sfdxurl:store -f $SFDX_AUTH_URL_FILE -$2 -a $3

}

