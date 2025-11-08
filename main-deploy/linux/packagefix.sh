#! /bin/bash
#script from here https://github.com/JasperNelson/IRSEC2025

os="$(cat /etc/os-release | grep '^ID=' | cut -d '=' -f 2 | tr -d '\"')"

if [ "$os" = "rocky" ] || [ "$os" = "fedora" ]; then
    echo "\n---- manually installed packages ----\n"
    dnf repoquery --userinstalled

    echo "\n---- checking package integrity ----\n"
    sudo rpm -qaV
elif [ "$os" = "ubuntu" ] || [ "$os" = "debian" ]; then
    echo "\n---- manually installed packages ----\n"
    apt-mark showmanual
    
    echo "\n---- checking package integrity ----\n"
    sudo debsums -s
fi

echo "Would you like to reinstall important packages? (yes or no)"
read answer
if [$answer = "Y"] || [$answer = "y"] || [$answer = "yes"]; then
    if [ "$os" = "rocky" ] || [ "$os" = "fedora" ]; then
        sudo dnf reinstall kernel kernel-core kernel-devel kernel-headers kernel-modules kernel-modules-core kernel-tools kernel-tools-libs bash coreutils firewalld
    if [ "$os" = "ubuntu" ] || [ "$os" = "debian" ]; then
        sudo dnf reinstall linux linux-base linux-firmware linux-generic bash coreutils passwd ufw
else; then
    echo "not installing apps"
fi