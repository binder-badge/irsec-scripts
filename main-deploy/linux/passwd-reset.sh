#! /bin/bash
knownUsers=()
for i in "${users[@]}"
do
    echo "Changing password for " $i
    # echo $answer1 ; echo $answer2 ;echo $answer2 ;sudo passwd $user
    echo $answer2 ;echo $answer2 ;sudo passwd $user
done
