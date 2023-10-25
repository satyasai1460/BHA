#!/bin/bash
GREEN='\033[0;32m'
RESET='\033[0m' # Reset color back to default

# Bug Hunting Tools to be Installed
#1.subfinder
#2.assetfinder
#3.amass
#4.ffuf
#5.nuclei
#6.httpx
#7.naabu
#8.waybackurls

go install github.com/tomnomnom/assetfinder@latest
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/owasp-amass/amass/v4/...@master
go install github.com/ffuf/ffuf/v2@latest
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
sudo apt-get install build-essential -y
sudo apt-get install libpcap-dev -y
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install github.com/tomnomnom/waybackurls@latest

cd
cd go/bin
cp subfinder assetfinder amass ffuf nuclei httpx naabu waybackurls /usr/local/go/bin
echo ""
echo ""
echo -e "${GREEN}All Bug Hunting tools are Installed successfully${RESET}"
