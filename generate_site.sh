#!/bin/bash

read -d '' bee <<-"_EOF_"
  .--.               .--.
 /    `.   o   o   .'    \
 \      \   \ /   /      /
 /\_     \ .-"-. /     _/\
(         V ^ ^ V         )
 \_      _| 9_9 |_      _/
  `.    //\__o__/\\    .'
    `._//\=======/\\_.'
     /_/ /\=====/\ \_\
       _// \===/ \\_
      /_/_//`='\\_\_\   hjw
        /_/     \_\
_EOF_

echo $bee
cd /home/skyb/werstener-biene
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