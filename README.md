# automate_scaning_process
I develop this with bash scripting and I use severel recon tools and bash command such as nmap,nslookup,whatweb,scp and ping 

 
![image](https://github.com/itspavara/automate_scaning_process/assets/111744737/92ce7da0-bf4d-48e9-a22d-36f0ca9f0522)

When we run ./recon.sh without ant IP or URL I make script for give introduction to use this script . Using this script we can gather information about our target, find vulnerabilities, send files for target and send packets to target IP for these tasks I used Nmap, Nslookup, whatweb, Ping and scp.  And I made this script for save every information to specific file.
![image](https://github.com/itspavara/automate_scaning_process/assets/111744737/b3e43afd-e638-4d8c-b859-7bbecb8a38fe)

As first usage ./recon.sh -I <IP>/<URL> use for gather information about target IP or URL first it scan url or ip using nmap if there is open port with http thar target is again scan with whatweb and gather information
![image](https://github.com/itspavara/automate_scaning_process/assets/111744737/7630b773-9d66-457a-8c4d-6a7ce5fa1013)


In second  ./recon.sh -v <IP>/<URL> this use for vulnerability scaning in this I use nmap and vulners.nsa  script for scan vulnerabilities

![image](https://github.com/itspavara/automate_scaning_process/assets/111744737/e8aede21-d50c-49e3-a656-ce7b956274bf)

 
In third ./recon.sh -v <IP> <SOURSE_DIR> <DEST_DIR> I use scp for send files to target IP and I use source directory and destination directory in target and after I check exist of status  
 
![image](https://github.com/itspavara/automate_scaning_process/assets/111744737/b828f657-7b9d-4f6d-b527-6cf928554fbf)

Last I send packets to the target location with ./recon.sh -v <IP> <NUMB_OF_PACKETS> command I sent any number of packets to the target IP for that I use ping and after I send packets I check tha status of ping .
