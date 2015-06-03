#!/bin/bash
cd /home/skyb/werstener-biene
git pull
jekyll build
rsync -rctv --delete /home/skyb/werstener-biene/_site/ /var/www/virtual/skyb/werstener-biene.de/