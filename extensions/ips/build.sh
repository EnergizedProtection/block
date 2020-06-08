#!/bin/bash
#-------------------------------------------------------------------------------#
#-------------------------- I N F O  &  L I C E N S E --------------------------#
#-------------------------------------------------------------------------------#
# Energized Protection - ad.porn.malware blocking.
# Packs Building Script
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
date=$(date +%d.%m.%Y)
whitelist=whitelist
whitelistURL="https://raw.githubusercontent.com/AdroitAdorKhan/Energized/master/core/filter/whitelist-ips"
formats=formats
ips=$formats/list.txt
file=list
fileTemp=list.temp
urls=urls
footer=$formats/footer
footerAB=$formats/footerAB
footerRPZ=$formats/footerRPZ
footerOL=$formats/footerOL
temp=$formats/temp
atemp=$formats/a.temp
wtemp=$formats/w.temp
divider='------------------------------------------------------------' 2>/dev/null

#-------------------------------------------------------------------------------#
#--------------------------- P A C K  D E T A I L S ----------------------------#
#-------------------------------------------------------------------------------#
#----------------------------- FILL THE INFO HERE ------------------------------#
#-------------------------------------------------------------------------------#
pack="ips"
dividerTiny="--------------------------------------------"
headerLogo="#    _____  _________  _____________  _______\n#   / __/ |/ / __/ _ \/ ___/  _/_  / / __/ _ \ \n#  / _// ,  / _// , _/ (_ // /  / /_/ _// // /\n# /___/_/|_/___/_/|_|\___/___/ /___/___/____/\n#\n#    P   R   O   T   E   C   T   I   O   N\n# $dividerTiny\n#          ad.porn.malware blocking.\n#                   ------\n#      Merged collection of hosts from\n#             reputable sources.\n# $dividerTiny\n#               energized.pro\n#    github.com/EnergizedProtection/block\n# $dividerTiny\n#\n#        Let's make an annoyance free\n#      better open internet. Altogether.\n#                  ------\n#"
f1="_hosts based: based on Hosts file."
f2="_any device: compatible with all devices."
f3="_blockings: strictly blocks web annoyances."
f4="_formats: most used formats."
f5="_speed: reduces page loading time."
f6="_privacy: increases privacy."
f7="_saves expense: decreases data consumption."
f8="_clean: no extra abracadabra!"
ador="@AdroitAdorKhan - Head Developer & Maintainer"
avinash="@AvinashReddy3108 - Developer"
badmojr="@badmojr - Maintainer"
packName="Energized IP List Extension"
packDesc="Malicious IP Protection."
buildVersion=$(date +%y.%m.%j)
releaseVersion=$(date +%j)
packCode="EX1P5-P"
license="MIT, https://energized.pro/license"
raw="https://block.energized.pro/extensions/$pack/formats"
updateDate=$(date +"%a, %d %b %y %H:%M:%S")

echo -n "# $dividerTiny\n# E N E R G I Z E D  E N D S\n# $dividerTiny\n#\n# - - - -  S T A Y  E N E R G I Z E D  - - - -" >> $footer


#-------------------------------------------------------------------------------#
#--------------------------- W H I T E L I S T I N G ---------------------------#
#-------------------------------------------------------------------------------#
wget -qO $whitelist $whitelistURL
# Remove Headers & Comments
sed '/#/d' -i $whitelist
# Remove Blank/Empty Lines
sed '/^$/d' -i $whitelist
# Removes Whitespace
cat $whitelist | tr -d '\r' >> $temp
# Sort, Remove Duplicate and Write
sed -i 's/ *$//' $temp && sort $temp |uniq |tee > $whitelist
# Clear Cache
rm -f $temp

#-------------------------------------------------------------------------------#
#-------------------------------- S O U R C E S --------------------------------#
#-------------------------------------------------------------------------------# 
{ wget -qO- https://malc0de.com/bl/IP_Blacklist.txt; \
wget -qO- https://pgl.yoyo.org/adservers/iplist.php?ipformat=plain&showintro=1&mimetype=plaintext; \
wget -qO- https://blocklist.greensnow.co/greensnow.txt; \
wget -qO- https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset; \
wget -qO- https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level2.netset; \
wget -qO- https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level3.netset; \
wget -qO- https://raw.githubusercontent.com/stamparm/ipsum/master/levels/1.txt; \
wget -qO- https://raw.githubusercontent.com/stamparm/ipsum/master/levels/2.txt; \
wget -qO- https://raw.githubusercontent.com/stamparm/ipsum/master/levels/3.txt; \
wget -qO- https://raw.githubusercontent.com/stamparm/ipsum/master/levels/4.txt; \
wget -qO- https://raw.githubusercontent.com/stamparm/ipsum/master/levels/5.txt; \
wget -qO- https://raw.githubusercontent.com/stamparm/ipsum/master/levels/6.txt; \
wget -qO- https://raw.githubusercontent.com/stamparm/ipsum/master/levels/7.txt; \
} > $file

#-------------------------------------------------------------------------------#
#--------------------------- P R O C E S S  P A C K ----------------------------#
#-------------------------------------------------------------------------------#
# Remove Craps
sed '/^\s*$/d;s/^localhost//;s/^,//;s/^-//;s/^_//;s/^;//;s/@//;s/;//;s/,//;s/+//;s/*//;s/=//;s/-$//;s/_$//;s/#.*//;s/##.*//;s/localhost$//;s/^[[:blank:]]*//;s/[[:blank:]]*$//' -i $file
# Remove Headers & Comments
sed '/#/d' -i $file
sed '/\/\//d' -i $file
sed '/</d' -i $file
#sed 's/\/.*//' -i $file
# Remove Blank/Empty Lines
sed '/^$/d' -i $file
# Removes Whitespace
cat $file | tr -d '\r' >> $temp
# Sort, Remove Duplicate and Write
sed -i 's/ *$//' $temp && sort $temp |uniq |tee > $file
# Clear Cache
rm -f $temp
# Remove Whitelisted Domains
comm -23 $file $whitelist > $temp
mv -f $temp $file
# Remove Blank/Empty Lines
sed '/^$/d' -i $file
# Build Format
awk '$0=$0' $file > $ips


#-------------------------------------------------------------------------------#
#--------------------------------- E C H O S -----------------------------------#
#-------------------------------------------------------------------------------#
# Read Total Domain Number
totaldomains=$(awk '!/^#/ && !/^$/{c++}END{print c}' $file | awk '{ len=length($0); res=""; for (i=0;i<=len;i++) { res=substr($0,len-i+1,1) res; if (i > 0 && i < len && i % 3 == 0) { res = "," res } }; print res }')
# Echo Pack, Domains and Size
echo $Y"!    _____  _________  _____________  _______\n!   / __/ |/ / __/ _ \/ ___/  _/_  / / __/ _ \ \n!  / _// ,  / _// , _/ (_ // /  / /_/ _// // /\n! /___/_/|_/___/_/|_|\___/___/ /___/___/____/\n!\n!    P   R   O   T   E   C   T   I   O   N"$N
echo $Y"! $dividerTiny"$N
echo $Y"! B U I L D I N G  P A C K S"$N
echo $Y"! $dividerTiny"$N
echo $G"! Pack: "$N$Y"$packName"$N
echo $G"! IPs: "$N$W"$totaldomains"$N
echo $G"! Version: "$N$W"$buildVersion"$N
echo $Y"! $dividerTiny"$N

#-------------------------------------------------------------------------------#
#-------------------------- B U I L D  F O R M A T S ---------------------------#
#-------------------------------------------------------------------------------#
# Clear Cache
rm -f $temp $atemp
echo $G"! Building "$N$Y"IP list"$N$G" Format"$N
# Domain List Header
echo "$headerLogo
# $dividerTiny
# P A C K  D E T A I L S
# $dividerTiny
# Title: $packName
# Description: $packDesc
# Format: ip list
# Version: $buildVersion
# Release: $releaseVersion
# Entries: $totaldomains
# Pack Code: $packCode
# License: $license
# Updated: $updateDate
# RAW: $raw/list.txt
# $dividerTiny
#
# $dividerTiny
# F E A T U R E S
# $dividerTiny
# $f1\n# $f2\n# $f3\n# $f4\n# $f5\n# $f6\n# $f7\n# $f8
# $dividerTiny
#
# $dividerTiny
# T E A M  B O L T Z - meet the team
# $dividerTiny
# $ador\n# $avinash\n# $badmojr
# $dividerTiny
#
# $dividerTiny
# E N E R G I Z E D  B E G I N S
# $dividerTiny" >> $temp
# Build Domain List
cat $temp $ips $footer > $atemp
mv -f $atemp $ips
#-------------------------------------------------------------------------------#

# Remove Stales
rm -f "$temp" "$atemp" "$file" "$whitelist" "$footer" 

#-------------------------------------------------------------------------------#
#---------------------------------- D O N E  -----------------------------------#
#-------------------------------------------------------------------------------#
