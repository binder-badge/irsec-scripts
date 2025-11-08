#! /bin/bash
# get collection of open network port + connections 
sudo netstat -lntuap | grep "ESTABLISHED\|LISTEN"