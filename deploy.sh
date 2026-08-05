#!/usr/bin/env bash
set -euo pipefail

DEST="web2_cloud:/opt/websites/werstenerbiene.de/html"

echo "==> Build (JEKYLL_ENV=production)"
JEKYLL_ENV=production bundle exec jekyll build

echo "==> Deploy nach ${DEST}"
rsync -ac --delete --progress _site/ "${DEST}/"

echo "==> Fertig."
