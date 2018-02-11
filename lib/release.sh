#!/usr/bin/env bash

START_TIME=$SECONDS

source common.sh
source sfdx.sh
source <(curl -s --retry 3 https://lang-common.s3.amazonaws.com/buildpack-stdlib/v7/stdlib.sh)

header "Running release.sh"

log "Config vars ..."
debug "DEV_HUB_SFDX_AUTH_URL: $DEV_HUB_SFDX_AUTH_URL"
debug "STAGE: $STAGE"
debug "SFDX_AUTH_URL: $SFDX_AUTH_URL"

whoami=$(whoami)
debug "WHOAMI: $whoami"

if [ "$STAGE" == "STAGING" ] || [ "$STAGE" == "PROD" ]; then

  log "Detected PROD. Kicking off deployment ..."

  auth . $SFDX_AUTH_URL s targetorg

  sfdx force:source:convert -d mdapiout

  sfdx force:mdapi:deploy -d mdapiout --wait 1000 -u targetorg

  # Run tests
  if [ ! "$STAGE" == "PROD" ] ; then
    tests "$run_apex_tests" "$apex_test_format" targetorg
  fi

fi

header "DONE! Completed in $(($SECONDS - $START_TIME))s"
exit 0