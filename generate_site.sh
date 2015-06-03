#!/bin/bash
cd /home/skyb/werstener-biene
echo "Aktualisiere aus git Repository …"
git pull
echo "Erzeuge Seite neu …"
jekyll build
echo "Aktualisiere Inhalte …"
rsync -rctv --delete --exclude nosyncfiles.txt /home/skyb/werstener-biene/_site/ /var/www/virtual/skyb/werstener-biene.de/
echo "Fertig"