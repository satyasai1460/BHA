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

sudo apt-get update

sudo find / -name '*go*' -exec rm -rf {} \;

wget https://go.dev/dl/go1.21.3.linux-amd64.tar.gz
echo ""
rm -rf /usr/local/go && tar -C /usr/local -xzf go*

# Define the Go Lang variables you want to remove
go_variables=("GOPATH" "GOROOT" "PATH")

# Loop through the variables and remove them from ~/.bashrc
for var in "${go_variables[@]}"; do
    sed -i "/export $var=/d" ~/.bashrc
done

#echo "Go Lang variables removed from ~/.bashrc."

# Source ~/.bashrc to apply the changes immediately
source ~/.bashrc

# Define Go Lang PATH Variables
GOPATH=/root/go
GOROOT=/usr/local/go

if grep -q "GOPATH=" ~/.bashrc || grep -q "GOROOT=" ~/.bashrc; then
    echo "GOPATH and/or GOROOT already set in ~/.bashrc."
    exit
fi

# Append Go Lang PATH Variables to ~/.bashrc
echo "export GOPATH=$GOPATH" >>~/.bashrc
echo "export GOROOT=$GOROOT" >>~/.bashrc
echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >>~/.bashrc
echo""

echo -e "Enter ${GREEN}source ~/.bashrc${RESET} command to continue :" $bashrc
read bashrc
if [ $? -eq 0 ]; then
    echo "Success"
else
    [ $? -ne 0 ]
    echo "Failed....Exiting"
    exit 0
fi
sleep 1
source ~/.bashrc
sleep 2
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
