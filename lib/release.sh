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

log "Parse .salesforcex.yml values ..."

# Parse .salesforcedx.yml file into env
#BUG: not parsing arrays properly
eval $(parse_yaml .salesforcedx.yml)

debug "scratch-org-def: $scratch_org_def"
debug "assign-permset: $assign_permset"
debug "permset-name: $permset_name"
debug "run-apex-tests: $run_apex_tests"
debug "apex-test-format: $apex_test_format"
debug "delete-scratch-org: $delete_scratch_org"
debug "open-path: $open_path"
debug "data-plans: $data_plans"

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