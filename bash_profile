#----- AWS --------
s3ls(){
aws s3 ls s3://$@
}

s3lsn(){
aws s3 ls s3://$@ --no-sign-request
}

s3cp(){
aws s3 cp s3://$@ --no-sign-request
}

dcache(){
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
}

rdp(){
sudo /etc/init.d/xrdp start
}


brc(){
source ~/.bashrc
}

bp(){
source .bash_profile
}

ipinfo(){
curl http://ipinfo.io/$1
}

mfuzz(){
ffuf -w /root/subdomain_megalist.txt -u 'https://FUZZ.$@' -c  -t 350 -mc all  -fs 0	
}


nfuzz(){
ffuf -c -w /root/fuzz.txt -mc 200,302 -u 'https://$@/FUZZ' -ac
}





















colour gradient 

#17262B

Text Colours in work exp

#FEE5B5

















