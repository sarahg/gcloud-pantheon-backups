#!/bin/bash

set -eou pipefail

terminus auth:login --machine_token=${TERMINUS_TOKEN}

# Instead of an env var for $SITES, maybe pull a site list that filters by a tag?
# Or just cover all unfrozen sandboxes?

for site in ${SITES//,/ }
do
    echo "Creating backups for ${site}..."
    ENVS="$(terminus env:list "$site" --filter='initialized=1' --field=ID)"
    for ENV in ${ENVS}
    do
      terminus -n backup:create "${site}"."${ENV}"
    done
done