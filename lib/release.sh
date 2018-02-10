
source common.sh

header "Running release.sh"

BUILD_DIR=${1:-}
CACHE_DIR=${2:-}
ENV_DIR=${3:-}
BP_DIR=$(cd $(dirname ${0:-}); cd ..; pwd)

log "BUILD_DIR $BUILD_DIR"
log "CACHE_DIR $CACHE_DIR"
log "ENV_DIR $ENV_DIR"
log "BP_DIR $BP_DIR"