#! /bin/bash
filesToRestore=("/etc/profile" "/etc/crontab" "/etc/sudoers" "/etc/shadow" "/etc/group" "~/.bashrc" "~/.bash_history" "~/.bash_logout" "~/.vimrc")
backupDir="/media/.backup/"
for i in "${filesToRestore[@]}"
do
    echo "restoring $i"
    basename=$(basename $i)
    cp $backupDir/$basename $i  
done