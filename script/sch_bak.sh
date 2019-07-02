#!/bin/bash
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/home/$USER/Dropbox/kindle-notes-backup/script/log.out 2>&1
# Everything below will go to the file 'log.out':
at now + 1 minutes < /home/$USER/Dropbox/kindle-notes-backup/script/backup.sh

su $USER -c 'notify-send -i pda -c transfer  "Kindle" "Script Initiated"'

exit 0
