#!/bin/bash
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/home/$USER/Dropbox/kindle-notes-backup/script/log.out 2>&1
# Everything below will go to the file 'log.out':


su $USER -c 'rsync /media/$USER/Kindle/documents/My\ Clippings.txt /home/$USER/Dropbox/kindle-notes-backup/My\ Clippings.txt'

if [ "$?" = "0" ]; then
	su $USER -c 'notify-send -i pda -c transfer  "Kindle" "Notes Copied"' 
else
	su $USER -c 'notify-send -i dialog-error -c transfer.error -u critical "ERROR" "Failed Kindle Backup"'
	exit 1
fi

cd /home/$USER/Dropbox/kindle-notes-backup/

if [ "$?" = "1" ]; then
	su $USER -c 'notify-send -i dialog-error -c transfer.error -u critical "ERROR" "Git: Failed commit (cd)"'
	exit 1
fi

if [ -z "$(su $USER -c 'git status --porcelain')" ]; then 
	su $USER -c 'notify-send -i document-save -c transfer "Git" "No changes in Kindle Notes"'
	exit 0
else
su $USER -c 'git add -A' 
su $USER -c 'git commit -m "Updates Kindle notes"' 
fi

if [ "$?" = "0" ]; then
	su $USER -c 'notify-send -i document-save -c transfer "Git" "Kindle notes committed"'
else
	su $USER -c 'notify-send -i dialog-error -c transfer.error -u critical "ERROR" "Git: Failed commit"'
	exit 1
fi

exit 0
