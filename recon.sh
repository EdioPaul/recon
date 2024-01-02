#/bin/bash

figlet -c Recon of Recon

echo Insert URL:
read url
echo
echo
mkdir $url
cd $url
echo $url | anew url;
echo
echo
echo


echo ================"INIT C4NG4R3C0N"================
echo
echo
gau $(cat url) | grep "\.js" | /home/edio/go/bin/./httpx -mc 200 -silent  | anew saida.txt
xargs -a saida.txt -n2 -I{} bash -c "echo -e '\n[URL]: {}\n'; python3 /linkfinder.py -i {} -o cli" | python3 /collector.py output;
echo
echo

echo ================"INIT C4NG4CRAWL"================ | anew allurls
echo
echo
subfinder -d $(cat url) | /home/edio/go/bin/./httpx -silent -threads 1000 | xargs -I@ sh -c 'findomain -t @ -q | /home/edio/go/bin/./httpx -silent | anew | waybackurls | anew allurls';
echo
echo ================"INIT XSS"================ | anew xss
echo
cat allurls | gf xss | anew xss;
echo
echo ================"INIT LFI"================ | anew lfi
echo
cat allurls | gf lfi | anew lfi;
echo
echo ================"INIT REDIRECT"================ | anew redirect
echo
cat allurls | gf redirect | anew redirect;
echo
echo ================"INIT RCE"================ | anew rce
echo
cat allurls | gf rce | anew rce;
echo
echo ================"INIT SSTI"================ | anew ssti
echo
cat allurls | gf ssti | anew ssti;
echo
echo ================"INIT SQLI"================ | anew sqli
echo
cat allurls | gf sqli | anew sqli;
echo
echo ================"INIT IDOR"================ | anew idor
echo
cat allurls | gf idor | anew idor;
echo
echo ================"INIT SSRF"================ | anew ssrf
echo
cat allurls | gf ssrf| anew ssrf;
echo
echo

echo ================"INIT SUBFINDER"================ | anew subfinder
echo
echo
subfinder -d $(cat url) -silent -all | /home/edio/go/bin/./httpx -silent -sc -t 1000 | anew subfinder;
echo
echo
echo

echo ================"INIT HTTP200"================ | anew http200
echo
echo
cat subfinder | egrep 200 | anew http200;
echo
echo
echo

echo ================"INIT HTTP404"================ | anew http404
echo
echo
cat subfinder | egrep 404 | anew http404;
echo
echo
echo

echo ================"INIT DIG"================ | anew dig
echo
while IFS= read -r line; do
    dig "$line" 
done < "http404" | anew dig
echo
echo
echo

echo ================"INIT SUBZYTAKEOVER"================ | anew subzytakeover
echo
echo
subzy run --targets subfinder | egrep -v 'NOT' | egrep -v 'HTTP ERROR' | anew subzytakeover;
echo
echo
echo

echo ================"INIT CORSORIGIN"================ | anew corsorigin
echo
echo
assetfinder $(cat url) | /home/edio/go/bin/./httpx -threads 300 -follow-redirects -silent | /home/edio/go/bin/./rush -j200 'curl -m5 -s -I -H "Origin: evil.com" {} | [[ $(grep -c "evil.com") -gt 0 ]] && printf "\n3[0;32m[VUL TO CORS] 3[0m{}"' 2>/dev/null | anew corsorigin
echo
echo
echo

echo ================"INIT WAYBACKROBOTS"================ | anew wayROBOTS
echo
echo
cat subfinder | waybackrobots -d $(cat url) -raw | anew wayROBOTS;
echo
echo
echo

echo ================"INIT NIKTO"================ | anew nikto
echo
echo
/home/edio/nikto/program/./nikto.pl -h $(cat url) | anew nikto;
echo
echo
echo

echo ================"INIT CRTSH"================ | anew crtsh
echo
echo
curl -s "https://crt.sh/?q=$(cat url)&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | /home/edio/go/bin/./httpx -title -silent | anew crtsh;
echo
echo
echo

echo ================"INIT /.git/HEAD1"================ | anew gitHEAD1
echo
echo
curl -s "https://crt.sh/?q=$(cat url)&output=json" | jq -r '.[].name_value' | assetfinder -subs-only | sed 's#$#/.git/HEAD#g' | /home/edio/go/bin/./httpx -silent -content-length -status-code 301,302 -timeout 3 -retries 0 -ports 80,8080,443 -threads 500 -title | grep 200 | anew gitHEAD1
echo
echo
echo

echo ================"INIT /.git/HEAD2"================ | anew gitHEAD2
echo
echo
curl -s "https://crt.sh/?q=$(cat url)&output=json" | jq -r '.[].name_value' | assetfinder -subs-only | /home/edio/go/bin/./httpx -silent -path /.git/HEAD -content-length -status-code 301,302 -timeout 3 -retries 0 -ports 80,8080,443 -threads 500 -title | grep 200 | anew gitHEAD2;
echo
echo
echo

echo ================"INIT WHATWEB"================ | anew whatweb
echo
echo
whatweb $(cat url) | anew whatweb;
echo
echo
echo
