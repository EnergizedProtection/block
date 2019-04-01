#!/bin/bash
# Filter - Energized Active List Filtering
# @adroitadorkhan
# License: CC BY-NC-SA 4.0
# Methods
logSource() {
	printf -- '\033[1;33m[+] Source:\033[0m %s\n' "$@"

}

logAction() {
	printf -- '\033[1;33m[+] \033[1;32m%s \033[0m\n' "$@"
}

logNumber() {
  printf -- '\033[1;32m[+] Active Domains:\033[0m %s\n' "$@"
}

# Cause we don't want to share our massive whitelist lol!
echo -n "[+] Enter Whitelist Sauce: $whitesauce"
read whitesauce
		
# DeclareWhitelist
whitelist=whitelist
		
# Download Hosts
wget -q -O $whitelist $whitesauce
		
# White Temps
wtemp=w.temp
xtemp=x.temp
		
# Upper > Lower Case
tr '[:upper:]' '[:lower:]' < $whitelist > $wtemp

# Cleans the domain list
egrep -v "^[[:blank:]]*(::|localhost|#|&|;|%|!|/|@|\.|\$|$)" $wtemp > $xtemp
sed 's/^localhost//;s/^,//;s/^-//;s/^_//;s/^;//;s/@//;s/;//;s/,//;s/+//;s/*//;s/=//;s/-$//;s/_$//;s/#.*//;s/##.*//;s/localhost$//;s/^[[:blank:]]*//;s/[[:blank:]]*$//' $xtemp > $wtemp
# Remove to avoid unnecessary error
rm -f $whitelist
sort $xtemp|uniq|tee > $wtemp
# Removes Whitespace
sed -r 's/\s+//g' $wtemp > $whitelist
rm -f "$wtemp" "$xtemp"
		
# Variables
date=$(date +%d.%m.%Y)
filter=filter
hosts=$filter/hosts.temp
temp=$filter/one.temp
atemp=$filter/two.temp
divider='============================================' 2>/dev/null

# Check JSON
sourceList=$(jq -c '.sources|map(select(.enabled))' "sources.json")
sourceCount=$(printf -- '%s' "$sourceList" | jq '.|length-1')

# Echo Start
logAction 'Filtering Hosts'

totalwhites=$(awk 'END{print NR}' $whitelist)
echo "[+] Inactive/Dead Domains: $totalwhites\n"
  
# Settings
	for i in $(seq 0 "$sourceCount"); do
		entry=$(printf -- '%s' "$sourceList" | jq ".[$i]")
		name=$(printf -- '%s' "$entry" | jq -r '.name')
		format=$(printf -- '%s' "$entry" | jq -r '.format')
		url=$(printf -- '%s' "$entry" | jq -r '.url')

# Echo Source Name and URL
echo "$divider"
logSource "$name - $url"

# Dynamic File Name
filename=$name
fresh=$filter/$filename.txt
active=$filter/$filename_hosts.txt


# Download Hosts
wget -q -O $filename $url

# Echo Actual Domains and Size
totallist=$(awk 'END{print NR}' $filename)
totalsize=$(ls -lah $filename | awk '{print $5}')
echo "[+] Total Domains: $totallist"
echo "[+] Size: $totalsize"

# Change as TEMP
mv -f $filename $temp

# Upper > Lower Case
tr '[:upper:]' '[:lower:]' < $temp > $atemp

# Cleans the domain list

egrep -v "^[[:blank:]]*(::|localhost|#|&|;|%|!|/|@|\.|\$|$)" $atemp > $temp
sed 's/^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}//;/^\s*$/d;s/^localhost//;s/^,//;s/^-//;s/^_//;s/^;//;s/@//;s/;//;s/,//;s/+//;s/*//;s/=//;s/-$//;s/_$//;s/#.*//;s/##.*//;s/localhost$//;s/^[[:blank:]]*//;s/[[:blank:]]*$//' $temp > $atemp
sort $atemp|uniq|tee > $temp
# Remove IPs and extras
sed 's/^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}.$//;s/^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}.$//;s/^-.*//' $temp > $atemp
# Removes Blank - Beginning and Ending
sed 's/^ *//; s/ *$//; /^$/d' $atemp > $temp
# Removes Whitespace
sed -r 's/\s+//g' $temp > $atemp
# Again
cat $atemp | tr -d '\r' > $temp
# Again Sort
sort $temp|uniq|tee > $hosts

# Remove Stale ACTIVEs
rm -f $fresh
rm -f $active

# Filter Inactive List
comm -23 "$hosts" "$whitelist" >> "$fresh"

# Add IP and Uncomment if you want Hosts
awk '$0="0.0.0.0 "$0' $fresh > $active

mv -f $active $fresh

# Read Total Domain Number
totaldomains=$(awk 'END{print NR}' $fresh)
# Echo Active Domains and Size
logNumber "$totaldomains"
activesize=$(ls -lah $fresh | awk '{print $5}')
echo "[+] Active Size: $activesize"

# Echo Divider
echo "$divider\n"

rm -f $temp $hosts

# Add Header
echo "# $name Custom Hosts Build\n# Builds Maintainer: Nayem Ador - nayemador.com\n# Converted From - $url\n# Last Converted - $date\n# Total Domains - $totaldomains\n# Energized - ad.porn.malware blocking.\n# https://energized.pro\n# License: CC BY-NC-SA 4.0; https://energized.pro/license\n" >> $temp

cat $temp $fresh > $hosts
mv -f $hosts $fresh

# Append Header
# Uncomment to get HOSTS
# sed -i '1s/^/# Hosts - $name\n# Source - $url\#Generated - $DATE\n# Created with Quizzer by @adroitadorkhan (nayemador.com)\n# Total Domains: $totaldomains\n/' $active

done

# Remove Stales
rm -f "$temp" "$atemp" "$hosts" "$whitelist"