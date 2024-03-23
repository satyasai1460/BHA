#/bin/bash
GREEN='\033[0;32m'
RESET='\033[0m' # Reset color back to default

rm -rf go1.22.1.linux-amd64.tar.gz*

#Downloading Go Lang
wget https://go.dev/dl/go1.22.1.linux-amd64.tar.gz
echo ""

#Extracting Go Lang
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz

# Define the Go Lang variables you want to remove
go_variables=("GOPATH" "GOROOT" "PATH")

# Loop through the variables and remove them from ~/.bashrc
for var in "${go_variables[@]}"; do
    sed -i "/export $var=/d" ~/.bashrc
done

#echo "Go Lang variables removed from ~/.bashrc."

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
echo""
echo -e "Enter ${GREEN}source ~/.bashrc${RESET} to apply the changes immediately"
