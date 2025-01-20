# **Domain Reconnaissance Script**

This script is designed to automate the reconnaissance phase of penetration testing or bug bounty hunting. It performs domain and subdomain enumeration, port scanning, service enumeration, vulnerability scanning, and live domain analysis. The script uses various tools to streamline the process and outputs results in an organized format.

---

## **Features**
- Subdomain enumeration using:
  - **amass**, **sublist3r**, and **subfinder**
- WHOIS information gathering
- Live subdomain checking with **httx**
- Port scanning using:
  - **masscan** and **naabu**
- Service enumeration using:
  - **whatweb** and **wappalyzer**
- Vulnerability scanning with:
  - **Nikto** and **Nuclei**
- Screenshots of live domains using **Eyewitness**

---

## **Requirements**
Before running the script, ensure you have the following tools installed on your system:
- [amass](https://github.com/OWASP/Amass)
- [sublist3r](https://github.com/aboul3la/Sublist3r)
- [subfinder](https://github.com/projectdiscovery/subfinder)
- [httx](https://github.com/projectdiscovery/httx)
- [masscan](https://github.com/robertdavidgraham/masscan)
- [naabu](https://github.com/projectdiscovery/naabu)
- [whatweb](https://github.com/urbanadventurer/WhatWeb)
- [wappalyzer](https://github.com/wappalyzer/wappalyzer)
- [nikto](https://github.com/sullo/nikto)
- [nuclei](https://github.com/projectdiscovery/nuclei)
- [eyewitness](https://github.com/FortyNorthSecurity/EyeWitness)

---

## **How to Use**
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-directory>


## **Output**
recon_results/
├── all_subdomains.txt
├── live_subdomains.txt
├── whois_info.txt
├── masscan_output_*.txt
├── naabu_output_*.txt
├── whatweb_*.txt
├── wappalyzer_*.json
├── nikto_*.txt
├── nuclei_*.txt
└── eyewitness_results/
