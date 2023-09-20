#!/bin/bash


#check the file exist
if [ ! -d results ]; then
  mkdir results
fi

if [ -z "$1" ]
then
	echo "Usage: ./recon.sh -i <IP>/<URL> for information gatharing"
	echo "Usage: ./recon.sh -v <IP>/<URL> for vulnerabilities"
	echo "Usage: ./recon.sh -f <IP> <SOURCE_DIR> <DEST_DIR> for send file to target ip address"
	echo "Usage: ./recon.sh -p <IP> <NUM_OF_PACKETS> for send packets to target ip address"
	exit 1

 
elif [ $1 == "-i" ]; then

	TARGET_IP="$2"

	echo "Running Nmap..."
	nmap $TARGET_IP | tail -n +5 | head -n -3 >> results/nmap


#scan for web ports
while read line
	do
		if [[ $line == *open* ]] && [[ $line == *http* ]]
		then
		echo "Running WhatWheb..."
		whatweb $TARGET_IP -v > temp
	fi
	done < results/nmap

	#gather information in open http ports
	if [ -e temp ]
	then 
		printf "\n----- WEB -----\n\n" > results/nmap
		cat temp >> results/nmap
		rm temp
	fi
	
	#running nsloockup
	echo "Running Nslookup..."
	printf "\n----- Nslookup -----\n\n" > results/nslookup
	nslookup $TARGET_IP >> results/nslookup
	
	cat results/nmap
	cat results/nslookup

#scaning vulnerabilities
elif [ $1 == "-v" ]; then
	
	TARGET_IP="$2"
	
	echo "Running Nmap..."
	printf "\n----- VULNERBBILITY -----\n\n" > results/vnmap
	sudo nmap -sV -p21-100 --script vulners $TARGET_IP | tail -n +6 | head -n -4 >> results/vnmap
	
	cat results/vnmap

#send files to target IP
elif [ $1 == "-f" ]; then

	TARGET_IP="$2"

	SOURCE_DIR="$3"
	DEST_DIR="$4"

	# Use scp to transfer files
	scp -r "$SOURCE_DIR"/* "$TARGET_IP":"$DEST_DIR"

	# Check the exit status of scp
	if [ $? -eq 0 ]; then
		echo "File transfer successful"
	else
		echo "File transfer failed"
	fi
	
#send packets to the target IP
elif [ $1 == "-p" ]; then
	
	TARGET_IP="$2"
	NUM_PACETS="$3"
	
	# Use ping to send packets
	ping -c "$NUM_PACETS" "$TARGET_IP" 


	if [ $? -eq 0 ]; then
		echo "Packets sent successfully"
	else
		echo "Failed to send packets"
	fi
	


fi



