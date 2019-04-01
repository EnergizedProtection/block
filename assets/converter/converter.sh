#!/bin/bash
# Filter - Energized Converter
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
# Change as TEMP
mv -f $filename $temp
# Upper > Lower Case
tr '[:upper:]' '[:lower:]' < $temp > $atemp
# Remove Headers and Comments
sed '/!/d; /^\[/d;' -i $atemp
# Remove Exceptions
sed '/@@/d; ' -i $atemp
# Only Domains
sed -n '/^||/p; ' -i $atemp
# sed  '/^##/d; ' -i $filename
egrep -v "\*|\/" $atemp > $temp
mv -f $temp $atemp
# Only First-Party
sed 's/$domain.*,//; s/$domain.*$//;' -i $atemp
sed 's/,domain.*,//; s/,domain.*$//;' -i $atemp
sed '/\$inline-script/d' -i $atemp
# Always Allow First-Party
sed '/~third-party/d' -i $atemp
sed '/third-party/!s/$/$third-party/'  -i $atemp
sed 's/\$/___tmp___/; s/\$/,/; s/___tmp___/$/' -i $atemp
sed '/^|http/d' -i $atemp
# Remove Symbols & Everything After String Matches 
sed 's/\^.*//;s/\/.*//;s/:.*//' -i $atemp
# Remove Craps
sed 's/^localhost//;s/^||//;s/-$third-party//;s/\^$third-party//;s/?$third-party//;s/$otherthird-party//;s/$websocketthird-party//;s/$popupthird-party//;s/$third-party//;s/^,//;s/^-//;s/^_//;s/^;//;s/@//;s/;//;s/,//;s/+//;s/*//;s/=//;s/-$//;s/_$//;s/#.*//;s/##.*//;s/localhost$//;s/^[[:blank:]]*//;s/[[:blank:]]*$//' -i $atemp
#sed 's/^localhost//;s/^||//;s/$third-party//;s/?//;s/\^//;s/^,//;s/^-//;s/^_//;s/^;//;s/@//;s/;//;s/,//;s/+//;s/*//;s/=//;s/-$//;s/_$//;s/#.*//;s/##.*//;s/localhost$//;s/^[[:blank:]]*//;s/[[:blank:]]*$//' -i $filename
sed 's/^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}.$//;s/^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}.$//' -i $atemp
# Removes Blank - Beginning and Ending
sed 's/^ *//; s/ *$//; /^$/d' $atemp > $temp
# Again
cat $atemp | tr -d '\r' > $temp
# Again Sort
sort $temp|uniq|tee > $hosts
# remove blnk
sed -i '/^$/d' $hosts
# Remove Line Matching
sed -i '/\$/d' $hosts
# Remove Craps
sed 's/^localhost//;s/^||//;s/-$third-party//;s/\^$third-party//;s/?$third-party//;s/$otherthird-party//;s/$websocketthird-party//;s/$popupthird-party//;s/$third-party//;s/$scriptthird-party//;s/$popupimportantthird-party//;s/^,//;s/^-//;s/^_//;s/^;//;s/@//;s/;//;s/,//;s/+//;s/*//;s/=//;s/-$//;s/_$//;s/#.*//;s/##.*//;s/localhost$//;s/^[[:blank:]]*//;s/[[:blank:]]*$//' -i $hosts
rm -f $fresh $active $temp $atemp
# Grep Domains Only
egrep "([a-z0-9|-]+\.)*[a-z0-9|-]+\.[a-z]+" $hosts > $temp
# Removes Blank - Beginning and Ending
sed 's/^ *//; s/ *$//; /^$/d' $temp > $atemp
# Again
cat $atemp | tr -d '\r' > $temp
# Again Sort
sort $temp|uniq|tee > $hosts
# remove blnk
sed -i '/^$/d' $hosts
# Echo Actual Domains and Size
totallist=$(awk 'END{print NR}' $hosts)
totalsize=$(ls -lah $hosts | awk '{print $5}')
echo "[+] Total Domains: $totallist"
echo "[+] Size: $totalsize"
# Add IP and Uncomment if you want Hosts
awk '$0="0.0.0.0 "$0' $hosts > $active
mv -f $active $fresh
# Read Total Domain Number
totaldomains=$(awk 'END{print NR}' $fresh)
rm -f $temp $atemp $hosts
# Add Header
echo "# $name Custom Hosts Build\n# Builds Maintainer: Nayem Ador - nayemador.com\n# Converted From - $url\n# Last Converted - $date\n# Total Domains - $totallist\n# Energized - ad.porn.malware blocking.\n# https://energized.pro\n# License: CC BY-NC-SA 4.0; https://energized.pro/license\n" >> $temp
cat $temp $fresh > $hosts
mv -f $hosts $fresh
done

# Remove Stales
rm -f "$temp" "$atemp" "$hosts"