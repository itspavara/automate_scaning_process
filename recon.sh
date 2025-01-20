#!/bin/bash

# Function to check if a tool is installed
check_tool() {
    tool=$1
    if ! command -v $tool &> /dev/null; then
        echo "[!] $tool is not installed. Please install it manually."
        missing_tools=1
    else
        echo "[*] $tool is already installed."
    fi
}

# Check for all required tools
missing_tools=0
echo "[*] Checking required tools..."
check_tool "amass"
check_tool "sublist3r"
check_tool "subfinder"
check_tool "httx"
check_tool "masscan"
check_tool "naabu"
check_tool "whatweb"
check_tool "wappalyzer"
check_tool "nikto"
check_tool "nuclei"
check_tool "eyewitness"

# Exit if any tools are missing
if [ $missing_tools -ne 0 ]; then
    echo "[!] One or more tools are missing. Please install them and rerun the script."
    exit 1
fi

# Validate input
if [ $# -ne 1 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1

# Create a directory to store results
mkdir -p recon_results
cd recon_results

# Domain and Subdomain Enumeration
echo "[*] Starting subdomain enumeration for $DOMAIN"
amass enum -passive -d $DOMAIN -o amass_passive.txt
sublist3r -d $DOMAIN -o sublist3r.txt
subfinder -d $DOMAIN -o subfinder.txt
cat amass_passive.txt sublist3r.txt subfinder.txt | sort -u > all_subdomains.txt
echo "[*] Subdomain enumeration completed. Results saved to all_subdomains.txt"

# WHOIS Information Gathering
echo "[*] Gathering WHOIS information for $DOMAIN"
whois $DOMAIN > whois_info.txt
echo "[*] WHOIS information saved to whois_info.txt"

# Checking for Live Subdomains
echo "[*] Checking for live subdomains using httx"
httx -l all_subdomains.txt -o live_subdomains.txt
echo "[*] Live subdomains check completed. Results saved to live_subdomains.txt"

#  Port Scanning
echo "[*] Starting port scanning"
while IFS= read -r subdomain; do
    echo "[*] Scanning subdomain with Masscan"
    masscan -p1-65535 $subdomain --rate=1000 -oG masscan_output_$subdomain.txt
    echo "[*] Scanning subdomain with Naabu"
    naabu -host $subdomain -o naabu_output_$subdomain.txt
done < live_subdomains.txt
echo "[*] Port scanning completed. Results saved to masscan_output_*.txt and naabu_output_*.txt"

#  Service Enumeration
echo "[*] Starting service enumeration"
while IFS= read -r subdomain; do
    echo "[*] Enumerating services on $subdomain"
    whatweb $subdomain > whatweb_$subdomain.txt
    wappalyzer $subdomain -o wappalyzer_$subdomain.json
done < live_subdomains.txt
echo "[*] Service enumeration completed. Results saved to whatweb_*.txt and wappalyzer_*.json"

#  Vulnerability Scanning
echo "[*] Starting vulnerability scanning"
while IFS= read -r subdomain; do
    echo "[*] Scanning subdomain with Nikto"
    nikto -h $subdomain -o nikto_$subdomain.txt
    echo "[*] Scanning subdomain with Nuclei"
    nuclei -u $subdomain -o nuclei_$subdomain.txt
done < live_subdomains.txt
echo "[*] Vulnerability scanning completed. Results saved to nikto_*.txt, zap_report_*.html, and nuclei_*.txt"

#  Taking Screenshots of Live Domains
echo "[*] Taking screenshots of live domains"
eyewitness --web -f live_subdomains.txt --no-prompt --results eyewitness_results
echo "[*] Screenshots taken and saved in the eyewitness_results directory"

# Completion
echo "[*] Recon workflow completed. All results are saved in the recon_results directory."
