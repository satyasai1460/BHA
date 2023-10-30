#!/bin/bash
GREEN='\033[0;32m'
RESET='\033[0m' # Reset color back to default

echo "Enter the Target domain : (example.com)"
read target

#For Finding Subdomains using Subfinder
subfinder -d $target -o $target.txt

#For Finding Subdomains using Assetfinder
assetfinder --subs-only $target | tee $target2.txt

#For Finding Subdomains using amass
amass enum -passive -norecursive -noalts -d $target -o $target3.txt
sleep 1

#Saving all the subdomains into a mainfile
echo "Saving all the Subdomains into a mainfile"
cat $target.txt $target2.txt $target3.txt >>main$target.txt

#Nuclei tool is used to automate and find the Interesting bugs using Nuclei Templates
nuclei -l main$target.txt -t /root/nuclei-templates -o nuclei$target.txt

#Checking for live urls and saving the urls into a file
cat main$target.txt | httpx -mc 200 | tee live$target.txt

# Naabu tool is used to discover the top 1000 ports of a target website
naabu -list live$target.txt -top-ports 1000 -exclude-ports 80,443 -o naabu$target.txt

# Waybackurls used to crawl all the urls and saving into a waybackdata
cat $target.txt | waybackurls | tee $target-waybackdata.txt
echo -e "${GREEN}Task completed${RESET}"
