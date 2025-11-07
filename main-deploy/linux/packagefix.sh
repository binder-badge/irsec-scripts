#! /bin/bash
#script from here https://github.com/JasperNelson/IRSEC2025

os="$(cat /etc/os-release | grep '^ID=' | cut -d '=' -f 2 | tr -d '\"')"
