#!/bin/bash

set -eou pipefail

terminus auth:login --machine-token="${TERMINUS_TOKEN}"

for site in $(terminus org:site:list "${PANTHEON_ORG_ID}" --tag=backups-bot --field=Name --format=list)
do
    echo "Creating backups for ${site}..."
    for ENV in $(terminus env:list "$site" --filter='initialized=1' --field=ID)
    do
      terminus -n backup:create "${site}"."${ENV}"
    done
done