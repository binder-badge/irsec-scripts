#! /bin/bash
os="$(cat /etc/os-release | grep '^ID=' | cut -d '=' -f 2 | tr -d '\"')"

if [ "$os" = "rocky" ] || [ "$os" = "fedora" ]; then
    sudo firewall-cmd --zone=work --add-rich-rule='rule family="ipv4" source address='$1'  protocol="tcp" drop'
    sudo firewall-cmd --zone=work --add-rich-rule='rule family="ipv4" source address='$1'  protocol="udp" drop'
elif [ "$os" = "ubuntu" ] || [ "$os" = "debian" ]; then
    sudo ufw reject from $1 to any
    sudo ufw deny proto tcp from $1 to any
    sudo ufw deny proto udp from $1 to any
fi