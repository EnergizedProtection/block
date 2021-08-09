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
headerLogo="#    _____  _________  _____________  _______\n#   / __/ |/ / __/ _ \/ ___/  _/_  / / __/ _ \ \n#  / _// ,  / _// , _/ (_ // /  / /_/ _// // /\n# /___/_/|_/___/_/|_|\___/___/ /___/___/____/\n#\n#    P   R   O   T   E   C   T   I   O   N\n# $dividerTiny\n#          ad.porn.malware blocking.\n#                   ------\n#      Merged collection of hosts from\n#             reputable sources.\n# $dividerTiny\n#               energized.pro\n#    github.com/EnergizedProtection/block\n# $dividerTiny\n#\n#        Let's make an annoyance free\n#      better open internet. Altogether.\n#                  ------\n#"
date=$(date +"%a, %d %b %y %H:%M:%S %Z")
filter=filter
hosts=$filter/hosts.temp
temp=$filter/temp
atemp=$filter/a.temp
btemp=b.temp
wtemp=w.temp
xtemp=x.temp



#-------------------------------------------------------------------------------#
#------------------------------- W E B S I T E ---------------------------------#
#-------------------------------------------------------------------------------#
tableFile=table.php
tableFileBck=table.php.bck
tableTemp=table.temp
cp $tableFile $tableFileBck
rm -f $tableTemp

#-------------------------------------------------------------------------------#
#----------------------------------- T O K E N ---------------------------------#
#-------------------------------------------------------------------------------#
echo $W"[+] Enter Whitelist Directory: $dirW"$N
read dirW

#-------------------------------------------------------------------------------#
#----------------------------- W H I T E L I S T -------------------------------#
#-------------------------------------------------------------------------------#
whitelist=$dirW
clear		
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
# Remove temps
rm -f "$wtemp" "$xtemp"
# Count Whitelist Domains
totalwhites=$(awk 'END{print NR}' $whitelist)

#-------------------------------------------------------------------------------#
#--------------------------------- E C H O S -----------------------------------#
#-------------------------------------------------------------------------------#
# Echo Pack, Domains and Size
echo $Y"!    _____  _________  _____________  _______\n!   / __/ |/ / __/ _ \/ ___/  _/_  / / __/ _ \ \n!  / _// ,  / _// , _/ (_ // /  / /_/ _// // /\n! /___/_/|_/___/_/|_|\___/___/ /___/___/____/\n!\n!    P   R   O   T   E   C   T   I   O   N"$N
echo $Y"! $dividerTiny"$N
echo $Y"! F I L T E R I N G  H O S T S"$N
echo $Y"! $dividerTiny"$N
echo $G"! Inactive/Dead/False Domains: "$N$Y"$totalwhites"$N
echo $Y"! $dividerTiny"$N
echo ''
#-------------------------------------------------------------------------------#
#------------------------------ R E A D  J S O N -------------------------------#
#-------------------------------------------------------------------------------#
# Check JSON
sourceList=$(jq -c '.sources|map(select(.enabled))' "sources.json")
sourceCount=$(printf -- '%s' "$sourceList" | jq '.|length-1')

# Get Info from JSON
for i in $(seq 0 "$sourceCount"); do
	entry=$(printf -- '%s' "$sourceList" | jq ".[$i]")
	sourceName=$(printf -- '%s' "$entry" | jq -r '.source')
	homePage=$(printf -- '%s' "$entry" | jq -r '.homepage')
	maintainer=$(printf -- '%s' "$entry" | jq -r '.maintainer')
	name=$(printf -- '%s' "$entry" | jq -r '.name')
	latestUpdate=$(printf -- '%s' "$entry" | jq -r '.update')
	activeFilter=$(printf -- '%s' "$entry" | jq -r '.filter')
	format=$(printf -- '%s' "$entry" | jq -r '.format')
	url=$(printf -- '%s' "$entry" | jq -r '.url')
	
	# Echo Source Name and URL
	echo $Y"! $dividerTiny"$N
	echo $G"! Source: "$N$Y"$sourceName"$N
	echo $G"! Maintainer: "$N$Y"$maintainer"$N
	echo $G"! Homepage: "$N$Y"$homePage"$N
	echo $G"! URL: "$N$W"$url"$N
	
	# Dynamic File Name Variables
	filename=$name
	fresh=$filter/$filename.txt
	active=$filter/$filename_hosts.txt
	# Make Fresh Copy of Current 
	cp $fresh $btemp 2>/dev/null
	
	if [ "$latestUpdate" = "latest" ]
	then
	   
		# Download Source
		curl -s -f -L -o $filename --connect-timeout 5 --max-time 10 --retry 5 --retry-delay 0 --retry-max-time 40 -A "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36" $url
		
		# If file has been loaded
		if [ ! -s $filename ]
		then
		
		    echo $R"! Dead Link..."$N
			echo $G"! Using Last Update..."$N
		    mv -f $btemp $filename 2>/dev/null
			
		fi
		
		echo $G"! Source Available."$N
		
	else 
	
	    echo $G"! Using Last Update..."$N
	    mv -f $btemp $filename 2>/dev/null
	    
	fi
	
	# Check If the New Downloaded File is available
	if [ -s $filename ]
	then
	
		# Echo File Size
		totalsize=$(ls -lah $filename | awk '{print $5}')
		echo $G"! Size: "$N$Y"$totalsize"$N
		
		# Converts adblock format to domains
		if [ "$format" = "adblock" ]
		then
			
			
			# Echo Source Format
			echo $G"! Format: "$N$Y"$format"$N
				
			# Change as TEMP
			mv -f $filename $temp
			# Only domains
			sed -ne '/^||/p' -i $temp
			sed '/\*/d;/~/d;/\//d;/xmlhttprequest/d;/.domain.name/d;' -i $temp
			sed 's/^localhost//;s/^||//;s/-$third-party//;s/\^$third-party//;s/?$third-party//;s/$otherthird-party//;s/$websocketthird-party//;s/$popupthird-party//;s/$third-party//;s/^,//;s/^-//;s/^_//;s/^;//;s/@//;s/;//;s/,//;s/+//;s/*//;s/=//;s/-$//;s/_$//;s/#.*//;s/##.*//;s/localhost$//;s/^[[:blank:]]*//;s/[[:blank:]]*$//' -i $temp
			# Upper > Lower Case
			tr '[:upper:]' '[:lower:]' < $temp > $atemp
			# Remove Headers and Comments
			sed '/!/d; /^\[/d; /^\./d;' -i $atemp
			# Remove Exceptions
			sed '/@@/d; ' -i $atemp
			# Remove symbols & everything after string matches 
			sed 's/\^.*//;s/\/.*//;s/:.*//' -i $atemp
			# Removes Blank - Beginning and Ending
			sed 's/^ *//; s/ *$//; /^$/d' $atemp > $temp
			# Again
			cat $atemp | tr -d '\r' > $temp
			# Again Sort
			sort $temp|uniq|tee > $hosts
			# Remove blnk
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
			# Attempts to remove entries with backslashes
			sed -i '/\\/d' $temp
			# Attempts to remove entries ending with periods
			sed -i '/\.$/d' $temp
			# Removes Blank - Beginning and Ending
			sed 's/^ *//; s/ *$//; /^$/d' $temp > $atemp
			# Again
			cat $atemp | tr -d '\r' > $temp
			# Again Sort
			sort $temp|uniq|tee > $hosts
			# Remove blank
			sed -i '/^$/d' $hosts
			
			# Echo Actual Domains and Size
			rawList=$(awk '!/^#/ && !/^$/{c++}END{print c}' $hosts | awk '{ len=length($0); res=""; for (i=0;i<=len;i++) { res=substr($0,len-i+1,1) res; if (i > 0 && i < len && i % 3 == 0) { res = "," res } }; print res }')
			echo $G"! Total Domains: "$N$Y"$rawList"$N
				 
		else
                
			# Echo Source Format
			echo $G"! Format: "$N$Y"$format"$N
				
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
			# Remove non UTF-8
			perl -i -nle 'print if m{^[[:ascii:]]+$}' $temp
			# Removes Craps
			sed '/.blogspot./d;/.wixsite./d;/.domain.name/d;/.wordpress./d;/\//d;/:/d;/::/d;/(/d;/|/d;/\[/d;/\]/d' -i $temp
			# Removes this - [[:blank:]].domain.xyz.com
			sed -i '/^\./d' $temp
			# Removes lines without any single dot
			sed -i '/\./!d' $temp
			# Attempts to remove entries with backslashes
			sed -i '/\\/d' $temp
			# Attempts to remove entries ending with periods
			sed -i '/\.$/d' $temp
			# Removes Whitespace
			sed -r 's/\s+//g' $temp > $atemp
			# Again
			cat $atemp | tr -d '\r' > $temp
			# Again Sort
			sort $temp|uniq|tee > $hosts
			
			# Echo Actual Domains and Size
			rawList=$(awk '!/^#/ && !/^$/{c++}END{print c}' $hosts | awk '{ len=length($0); res=""; for (i=0;i<=len;i++) { res=substr($0,len-i+1,1) res; if (i > 0 && i < len && i % 3 == 0) { res = "," res } }; print res }')
			echo $G"! Total Domains: "$N$Y"$rawList"$N
				   
        fi 
		
		
		# Remove Stale ACTIVEs
		rm -f $fresh
		rm -f $active
		
				
		# Check Active Filtering
		if [ "$activeFilter" = "active" ]
		then
				
			echo $G"! Filtering."$N
					
			# Filter Inactive List
			comm -23 "$hosts" "$whitelist" >> "$fresh"
					
			# Add IP and Uncomment if you want Hosts
			awk '$0="0.0.0.0 "$0' $fresh > $active
					
			mv -f $active $fresh
					
		else
				
			echo $W"! Not filtering."$N
					
					
			# Add IP and Uncomment if you want Hosts
			awk '$0="0.0.0.0 "$0' $hosts > $fresh
				
		fi
		
		
		# Read total domain number and size
		echo $Y"! $dividerTiny"$N
		totaldomains=$(awk '!/^#/ && !/^$/{c++}END{print c}' $fresh | awk '{ len=length($0); res=""; for (i=0;i<=len;i++) { res=substr($0,len-i+1,1) res; if (i > 0 && i < len && i % 3 == 0) { res = "," res } }; print res }')
		echo $G"! Active Domains: "$N$W"$totaldomains"$N
		activesize=$(ls -lah $hosts | awk '{print $5}')
		echo $G"! Size: "$N$W"$activesize"$N
		echo $Y"! $dividerTiny"$N
		echo ''
				
	fi
			
			
	
			
	
	rm -f $temp $hosts
			
	# Add Header
	echo "$headerLogo Title: $name Custom Hosts Build\n# Builds Maintainer: Nayem Ador - nayemador.com\n# Source: $sourceName\n# Source URL: $url\n# Modified: $date\n# Entries: $totaldomains\n# Energized Protection - ad.porn.malware blocking.\n# https://energized.pro\n# License: MIT; https://energized.pro/license\n" >> $temp
			
	cat $temp $fresh > $hosts
	mv -f $hosts $fresh
	
	# Build Table
	echo "<tr><td><a href='$homePage' target='_blank'>$sourceName</a></td><td>$maintainer</td><td>$totaldomains</td><td><a href='filter/$name.txt' title='Filtered Source' target='_blank'>LINK</a></td></tr>" >> $tableTemp
			
	    
		
		
	
	
done

mv -f $tableTemp $tableFile


echo ''
echo $G"! Done Filtering."$N
echo ''

# Remove Stales
rm -f "$temp" "$atemp" "$btemp" "$hosts" "$tableFileBck" "$tableTemp" #"$whitelist"
