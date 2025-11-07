#! /bin/bash
knownUsers=("drwho" "marthymcfly" "arthurdent" "sambeckett" "loki" "riphunter" "theflash" "tonystark" "drstrange" "bartallen")
read -p "Enter new pass: " pass
for i in "${knownUsers[@]}"
do
    echo $pass ;passwd --stdin $user
    echo "replaced password for " $user
done

# allNames=( $( grep -v \/usr\/bin\/nologin /etc/passwd | cut -d ':' -f1 ) )
echo "\nall users:"
cat /etc/passwd | awk -F: '{print $1}'
echo "\nall groups:"
cat /etc/group | awk -F: '{print $1 ":" $4}'