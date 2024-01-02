
#!/bin/bash

google-chrome --new-tab "https://www.google.com/search?q=filetype:sql intext:password" #This Google dork will search for SQL database files containing passwords. This is a common way for hackers to find login credentials.
google-chrome --new-tab "https://www.google.com/search?q=intitle:index.of “parent directory”" #This Google dork will search for directories that may contain sensitive information, such as backups or configuration files.
google-chrome --new-tab "https://www.google.com/search?q=inurl:/proc/self/environ" #This Google dork will search for environment variables on a website. These variables can contain sensitive information such as database credentials.
google-chrome --new-tab "https://www.google.com/search?q=intext:username= AND intext:password=" #This Google dork will search for login pages that have both a username and password field. This is a common way for hackers to find login credentials.
google-chrome --new-tab "https://www.google.com/search?q=inurl:/wp-content/uploads/" #This Google dork will search for WordPress uploads directories. Hackers can use this to find files that may contain sensitive information such as login credentials or configuration files.
google-chrome --new-tab "https://www.google.com/search?q=inurl:/cgi-bin/" #This Google dork will search for CGI scripts on a website. Hackers can use this to find vulnerabilities in the script and potentially gain access to sensitive information.
google-chrome --new-tab "https://www.google.com/search?q=inurl:/wp-admin/" #This Google dork will search for WordPress admin pages. Hackers can use this to gain access to the admin panel and potentially gain access to sensitive information.
google-chrome --new-tab "https://www.google.com/search?q=intitle:”index of” “config.yml”" #This Google dork will search for configuration files on a website. These files can contain sensitive information such as database credentials.
google-chrome --new-tab "https://www.google.com/search?q=intext:”sql syntax near” | intext:”syntax error has occurred” | intext:”incorrect syntax near” | intext:”unexpected end of SQL command”" #This Google dork will search for SQL errors on a website, which may indicate a vulnerability that could be exploited by hackers.
google-chrome --new-tab "https://www.google.com/search?q=inurl:/phpmyadmin/" #This Google dork will search for phpMyAdmin installations on a website, which could potentially give hackers access to a website’s database.