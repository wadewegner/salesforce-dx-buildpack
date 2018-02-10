#!/usr/bin/env bash

source common.sh
source <(curl -s --retry 3 https://lang-common.s3.amazonaws.com/buildpack-stdlib/v7/stdlib.sh)

header "Running release.sh"

log "Config vars ..."
log "-- DEV_HUB_SFDX_AUTH_URL: $DEV_HUB_SFDX_AUTH_URL"
log "-- STAGE: $STAGE"
log "-- SFDX_AUTH_URL: $SFDX_AUTH_URL"

whoami=$(whoami)
log "-- WHOAMI: $whoami"

# if [ "$STAGE" == "PROD" ]; then

sfdx version

# fi