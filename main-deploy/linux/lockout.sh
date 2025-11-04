#! /bin/bash
trap "" DEBUG
trap "" EXIT
trap "" RETURN
PROMPT_COMMAND=""
unalias -a
sl /usr/bin > "/media/.backup/usr_bin_new.txt"
sl /bin > "/media/.backup/bin_new.txt"
echo "" > ~/.bashrc
echo "" > ~/.bash_logout
echo "" > ~/.bash_history
echo "" > ~/.vimrc
corntab < /dev/null
echo "* * * * * "lockout.sh"" > "/media/.backup/cron.txt"
corntab "/media/.backup/cron.txt"
