# took some "light insirpation" from this repo ()
#! /bin/bash
# check if root
if [[ $UID -ne 0 ]];then
	echo "Please run as root"
	exit
fi

# setup back dir
# info about usr/bin and bin to /media/.backup
if ! [[ -d "/media/.backup" ]]; then
	mkdir "/media/.backup"
	ls -lah /usr/bin > "/media/.backup/usr_bin_backup.txt"
	ls -lah /bin > "/media/.backup/bin_backup.txt"
    ls -lah /et/profile.d > "/media/.backup/profile-d.txt"
    
fi

#__Web__
iptables -A INPUT -p TCP --sport 80 -j ACCEPT
iptables -A OUTPUT -p TCP --dport 80 -j ACCEPT
iptables -A INPUT -p TCP --sport 443 -j ACCEPT
iptables -A OUTPUT -p TCP --dport 443 -j ACCEPT

#__DNS__
iptables -A INPUT -p UDP --sport 53 -j ACCEPT
iptables -A OUTPUT -p UDP --dport 53 -j ACCEPT

# prompt for pw for all users
cat /etc/passwd | cut -d ":" -f 1,3 | awk -F ":" '$2 > 1000 {print $1}' > ~/user
read -p "Enter new pass: " answer
while read user;do echo "$answer" | passwd --stdin $user;done < ~/user
rm -f ~/user

# Change root password
echo "$answer" | sudo passwd root --stdin

echo "Done!"

# Back up cronjobs, bashrc, bash history, bash logout, default vimrc,  keybinds
filesToCheck=("/etc/profile" "/etc/crontab" "/etc/sudoers" "/etc/shadow" "/etc/group" "~/.bashrc" "~/.bash_history" "~/.bash_logout" "~/.vimrc")
for i in "${filesToCheck[@]}"
do
    basenameForBackup=$(basename $i)
    cp $i "./result/$basenameForBackup" 
    sha256sum $i >> "/media/.backup/checksums.txt"
done
iptables-save > "/media/.backup/iptables.txt"
bind -p > "/media/.backup/mybind"
# cat /etc/crontab > "/media/.backup/crontab.txt"
# cat /etc/sudoers > "/media/.backup/sudoers.txt"
# cat /etc/shadow > "/media/.backup/shadow.txt"
# cat ~/.bashrc > "/media/.backup/bashrc.txt"
# cat ~/.bash_history > "/media/.backup/history.txt"
# cat ~/.bash_logout > "/media/.backup/logout.txt"
# cat ~/.vimrc > "/media/.backup/vimrc.txt"

# chattr the backup dir, logs
chattr +a -R "/media/.backup"
chattr -R +a /var/log/

# Prevent rootkits
# sudo env | grep -i 'LD'
mv /etc/ld.so.preload /etc/ld.so.null
touch /etc/ld.so.preload && chattr +i /etc/ld.so.preload

dnf update