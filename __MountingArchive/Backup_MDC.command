# Daily Backup
# Offical Creat on 10/04/17
# Being run on 192.168.8.11 in crontab - Root 11/09/18
# System running the script MUST be connected to both the StorNext San and the Media Grid. - NEROTAS

# Ghost file removal added on 10/16/17 - NEROTAS
find ${Deep Storage Location} -name ".DS_Store" -exec rm {} \;
find ${Deep Storage Location} -name "*._*" -exec rm {} \;
find ${Deep Storage Location} -name "Thumbs.db" -exec rm {} \;

# Folder removal added on 10/16/17. Run before rsync to avoid copying unneeded folders. - NEROTAS
find ${Deep Storage Location}*/*/* -depth -type d -empty -exec rmdir "{}" \;


# Sudo permission given in order ensure script has full access to all assets on grid.
sudo chmod -R 777 ${Deep Storage Location}

rsync --log-file-format="%i %o %f B:%''l %C" --log-file=/stornext/Archive/_rsync_logs_deepstorage/$(date +"%F_%H%M")-backup.log --progress --remove-source-files --checksum -COruvth ${Deep Storage Location} /stornext/Archive/

# Folder removal added on 10/16/17. Run after rsync to clean up empty folders left over by rsync. - NEROTAS
find ${Deep Storage Location}*/*/* -depth -type d -empty -exec rmdir "{}" \;

# Made log more verbose 01/29/17 - NEROTAS