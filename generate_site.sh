#!/bin/bash
cat asciibee.txt
cd /home/skyb/werstener-biene
echo
echo "---------------------------------"
echo "Aktualisiere aus git Repository …"
git pull
echo "---------------------------------"
echo "Erzeuge Seite neu …"
jekyll build --lsi
echo "---------------------------------"
echo "Aktualisiere Inhalte …"
rsync -rctv --delete --exclude nosyncfiles.txt /home/skyb/werstener-biene/_site/ /var/www/virtual/skyb/werstener-biene.de/
echo "Fertig"