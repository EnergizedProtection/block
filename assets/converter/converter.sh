#!/bin/bash
#-------------------------------------------------------------------------------#
#-------------------------- I N F O  &  L I C E N S E --------------------------#
#-------------------------------------------------------------------------------#
# Energized Protection - ad.porn.malware blocking.
# Hosts Filtering Script
# Git: http://go.energized.pro/github
# WEB: https://energized.pro
# @adroitadorkhan
# License: CC BY-NC-SA 4.0

#-------------------------------------------------------------------------------#
#--------------------------------- C O L O R S ---------------------------------#
#-------------------------------------------------------------------------------#
BL='\033[1;30m' # Black
R='\033[1;31m'  # Red
G='\033[1;32m'  # Green
Y='\033[1;33m'  # Yellow
B='\033[1;34m'  # Blue
P='\033[1;35m'  # Purple
C='\033[1;36m'  # Cyan
W='\033[1;37m'  # White
N='\033[0m'     # No Color


#-------------------------------------------------------------------------------#
#------------------------------ V A R I A B L E S ------------------------------#
#-------------------------------------------------------------------------------#
divider='------------------------------------------------------------' 2>/dev/null
dividerTiny="--------------------------------------------"
date=$(date +%d.%m.%Y)
filter=filter
hosts=$filter/hosts.temp
temp=$filter/temp
atemp=$filter/a.temp
btemp=b.temp
wtemp=w.temp
xtemp=x.temp


#-------------------------------------------------------------------------------#
#--------------------------------- E C H O S -----------------------------------#
#-------------------------------------------------------------------------------#
# Echo Pack, Domains and Size
echo $Y"!    _____  _________  _____________  _______\n!   / __/ |/ / __/ _ \/ ___/  _/_  / / __/ _ \ \n!  / _// ,  / _// , _/ (_ // /  / /_/ _// // /\n! /___/_/|_/___/_/|_|\___/___/ /___/___/____/\n!\n!    P   R   O   T   E   C   T   I   O   N"$N
echo $Y"! $dividerTiny"$N
echo $Y"! F I L T E R I N G  H O S T S"$N
echo $Y"! $dividerTiny"$N
echo ''

#-------------------------------------------------------------------------------#
#------------------------------ R E A D  J S O N -------------------------------#
#-------------------------------------------------------------------------------#
# Check JSON
sourceList=$(jq -c '.sources|map(select(.enabled))' "sources.json")
sourceCount=$(printf -- '%s' "$sourceList" | jq '.|length-1')


# Settings
	for i in $(seq 0 "$sourceCount"); do
		entry=$(printf -- '%s' "$sourceList" | jq ".[$i]")
		name=$(printf -- '%s' "$entry" | jq -r '.name')
		format=$(printf -- '%s' "$entry" | jq -r '.format')
		url=$(printf -- '%s' "$entry" | jq -r '.url')

# Echo Source Name and URL
echo $Y"! $dividerTiny"$N
echo $G"! Hosts: "$N$Y"$name"$N
echo $G"! URL: "$N$W"$url"$N

# Dynamic File Name
filename=$name
fresh=$filter/$filename.txt
active=$filter/$filename_hosts.txt
# Make Fresh Copy of Current 
cp $fresh $btemp

# Download Hosts
#wget -q -O $filename $url
curl -s -f -L -o $filename --connect-timeout 5 --max-time 10 --retry 5 --retry-delay 0 --retry-max-time 40 $url


# Check If the New Downloaded File
if [ -s $filename ]
then

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
  sed 's/^localhost//;s/^||//;s/-$third-party//;s/\^$third-party//;s/?$third-party//;s/$otherthird-party//;s/$websocketthird-party//;s/$popupthird-party//;s/$third-party//;s/$scriptthird-party//;s/$popupimportantthird-party//;s/^,//;s/^-//;s/^_//;s/^;//;s/＾//;s/@//;s/;//;s/,//;s/+//;s/*//;s/=//;s/-$//;s/_$//;s/#.*//;s/##.*//;s/localhost$//;s/^[[:blank:]]*//;s/[[:blank:]]*$//' -i $hosts
  rm -f $fresh $active $temp $atemp
  # Grep Domains Only
  egrep "([a-z0-9|-]+\.)*[a-z0-9|-]+\.[a-z]+" $hosts > $temp
  # Removes this - domain.xyz.[[:blank:]]
  sed -i '/\.[.*]*$/d' $temp
  # Removes Blank - Beginning and Ending
  sed 's/^ *//; s/ *$//; /^$/d' $temp > $atemp
  
  # Again
  cat $atemp | tr -d '\r' > $temp
  # Again Sort
  sort $temp|uniq|tee > $hosts
  # Remove blank
   sed -i '/^$/d' $hosts
  
  
  # Add IP and Uncomment if you want Domains
  awk '$0="0.0.0.0 "$0' $hosts > $active
  mv -f $active $fresh
  # Read Total Domain Number
  totaldomains=$(awk 'END{print NR}' $fresh)
  echo $Y"! $dividerTiny"$N
  totaldomains=$(awk 'END{print NR}' $fresh)
  echo $G"! Domains: "$N$W"$totaldomains"$N
  activesize=$(ls -lah $fresh | awk '{print $5}')
  echo $G"! Size: "$N$W"$activesize"$N
  echo $Y"! $dividerTiny"$N
  echo ''
  
  # Read Total Domain Number
  totallist=$(awk 'END{print NR}' $fresh)
  rm -f $temp $atemp $hosts
  # Add Header
  echo "# $name Custom Hosts Build\n# Builds Maintainer: Nayem Ador - nayemador.com\n# Converted From - $url\n# Last Converted - $date\n# Total Domains - $totallist\n# Energized - ad.porn.malware blocking.\n# https://energized.pro\n# License: MIT; https://energized.pro/license\n" >> $temp
  cat $temp $fresh > $hosts
  mv -f $hosts $fresh
  
else
  echo $Y"! $dividerTiny"$N
  echo $R"! Dead Link..."$N
  echo $G"! Saving Last Update..."$N
  echo $G"! Done"$N
  echo $Y"! $dividerTiny"$N
  echo ''
  rm -f $fresh
  mv -f $btemp $fresh
fi


done
echo ''
echo $G"! Done Converting."$N
echo ''

# Remove Stales
rm -f "$temp" "$atemp" "$btemp" "$hosts"