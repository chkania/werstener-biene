#!/bin/bash
cat asciibee.txt
cd /home/werbiene/blog/werstener-biene

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

function s3copy {
    cat s3copy.txt | while read line; do
        s3cmd --acl-public --cf-invalidate put "/home/werbiene/werstener-biene/_site/$line" "s3://werstener-biene/$line"
    done
}

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
        rsync -rctv --delete --exclude nosyncfiles.txt /home/werbiene/blog/werstener-biene/_site/ /home/werbiene/html
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
    q)
        echo "quit"
        exit 1
        ;;
   esac
   prompt
  done
