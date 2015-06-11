#!/bin/bash
cat asciibee.txt
cd /home/skyb/werstener-biene

prompt() {
    echo "Was willst Du tun?"
    echo "(1) git update"
    echo "(2) build site"
    echo "(3) deploy site"
    echo "(4) update cdn"
    read -p "Deine Wahl: " action
    echo
}
trap prompt SIGINT

while true;
  do
    case "$action" in
     1)
        echo
        echo "---------------------------------"
        echo "Aktualisiere aus git Repository …"
        git pull
        echo "---------------------------------"
        ;;
     2)
        echo "---------------------------------"
        echo "Erzeuge Seite neu …"
        jekyll build --lsi
        echo "---------------------------------"
        ;;
     3)
        echo "---------------------------------"
        echo "Aktualisiere lokale Inhalte …"
        rsync -rctv --delete --exclude nosyncfiles.txt /home/skyb/werstener-biene/_site/ /var/www/virtual/skyb/werstener-biene.de/
        echo "---------------------------------"
        ;;
    4)
        echo "---------------------------------"
        echo "Aktualisiere S3 Inhalte …"
        s3copy
        echo "Fertig"
        echo "---------------------------------"
        ;;
    0)
        echo "quit"
        exit 1
        ;;
   esac
   prompt
  done

s3copy() {
cat s3copy.txt | while read line
            s3cmd --acl-public --cf-invalidate put "/home/skyb/werstener-biene/_site/$line" "s3://werstener-biene/$line"
            done
}