#! /bin/bash
# get collection of open network port + connections 
ss -tulpna | grep "ESTAB" > "ss.txt"