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
echo "Aktualisiere lokale Inhalte …"
rsync -rctv --delete --exclude nosyncfiles.txt /home/skyb/werstener-biene/_site/ /var/www/virtual/skyb/werstener-biene.de/
echo "Aktualisiere S3 Inhalte …"
cat s3copy.txt | while read line
do
    s3cmd put "/home/skyb/werstener-biene/_site/$line" "s3://werstener-biene/$line"
#s3cmd put /home/skyb/werstener-biene/_site/images/site/Slider1_progressive_90.jpg s3://werstener-biene/images/site/Slider1_progressive_90.jpg
done
echo "Fertig"