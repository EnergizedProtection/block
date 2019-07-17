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
whitelistURL="https://raw.githubusercontent.com/AdroitAdorKhan/Energized/master/core/filter/whitelist-porn"
formats=formats
hosts=$formats/hosts
hostsTXT=$formats/hosts.txt
hostsV6=$formats/hosts-ipv6.txt
domains=$formats/domains.txt
filter=$formats/filter
dnsMasq=$formats/dnsmasq.conf
dnsMasqIPV6=$formats/dnsmasq-ipv6.conf
unbound=$formats/unbound.conf
rpz=$formats/rpz.txt
oneline=$formats/one-line.txt
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
pack="unified"
dividerTiny="--------------------------------------------"
headerLogo="#    _____  _________  _____________  _______\n#   / __/ |/ / __/ _ \/ ___/  _/_  / / __/ _ \ \n#  / _// ,  / _// , _/ (_ // /  / /_/ _// // /\n# /___/_/|_/___/_/|_|\___/___/ /___/___/____/\n#\n#    P   R   O   T   E   C   T   I   O   N\n# $dividerTiny\n#          ad.porn.malware blocking.\n#                   ------\n#      Merged collection of hosts from\n#             reputable sources.\n# $dividerTiny\n#               energized.pro\n#    github.com/EnergizedProtection/block\n# $dividerTiny\n#\n#        Let's make an annoyance free\n#      better open internet. Altogether.\n#                  ------\n#"
headerLogoAB="!    _____  _________  _____________  _______\n!   / __/ |/ / __/ _ \/ ___/  _/_  / / __/ _ \ \n!  / _// ,  / _// , _/ (_ // /  / /_/ _// // /\n! /___/_/|_/___/_/|_|\___/___/ /___/___/____/\n!\n!    P   R   O   T   E   C   T   I   O   N\n! $dividerTiny\n!          ad.porn.malware blocking.\n!                   ------\n!      Merged collection of hosts from\n!             reputable sources.\n! $dividerTiny\n!               energized.pro\n!    github.com/EnergizedProtection/block\n! $dividerTiny\n!\n!        Let's make an annoyance free\n!      better open internet. Altogether.\n!                  ------\n!"
headerLogoRPZ=";    _____  _________  _____________  _______\n;   / __/ |/ / __/ _ \/ ___/  _/_  / / __/ _ \ \n;  / _// ,  / _// , _/ (_ // /  / /_/ _// // /\n; /___/_/|_/___/_/|_|\___/___/ /___/___/____/\n;\n;    P   R   O   T   E   C   T   I   O   N\n; $dividerTiny\n;          ad.porn.malware blocking.\n;                   ------\n;      Merged collection of hosts from\n;             reputable sources.\n; $dividerTiny\n;               energized.pro\n;    github.com/EnergizedProtection/block\n; $dividerTiny\n;\n;        Let's make an annoyance free\n;      better open internet. Altogether.\n;                  ------\n;"
localHost="# $dividerTiny\n# L O C A L  H O S T\n# $dividerTiny\n127.0.0.1 localhost\n127.0.0.1 localhost.localdomain\n127.0.0.1 local\n255.255.255.255 broadcasthost\n::1 localhost\n::1 ip6-localhost\n::1 ip6-loopback\nfe80::1%lo0 localhost\nff00::0 ip6-localnet\nff00::0 ip6-mcastprefix\nff02::1 ip6-allnodes\nff02::2 ip6-allrouters\nff02::3 ip6-allhosts\n0.0.0.0 0.0.0.0\n# $dividerTiny"
localHostRPZ="; $dividerTiny\n; R P Z\n; $dividerTiny\n\$TTL 2h\n@ IN SOA localhost. root.localhost. (1 6h 1h 1w 2h)\n  IN NS  localhost.\n; $dividerTiny"
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
packName="Energized Unified Protection"
packDesc="Flagship Full Protection Pack from Energized Protection."
buildVersion=$(date +%y.%m.%j)
releaseVersion=$(date +%j)
packCode="EU91F13D-P"
license="MIT, https://energized.pro/license"
raw="https://github.com/EnergizedProtection/block/raw/master/$pack/formats"
updateDate=$(date +"%a, %d %b %y %H:%M:%S")
expiry="7 days (update frequency)"
echo -n "# $dividerTiny\n# E N E R G I Z E D  E N D S\n# $dividerTiny\n#\n# - - - -  S T A Y  E N E R G I Z E D  - - - -" >> $footer
echo -n "! $dividerTiny\n! E N E R G I Z E D  E N D S\n! $dividerTiny\n!\n! - - - -  S T A Y  E N E R G I Z E D  - - - -" >> $footerAB
echo -n "; $dividerTiny\n; E N E R G I Z E D  E N D S\n; $dividerTiny\n;\n; - - - -  S T A Y  E N E R G I Z E D  - - - -" >> $footerRPZ
echo -n "\n# $dividerTiny\n# E N E R G I Z E D  E N D S\n# $dividerTiny\n#\n# - - - -  S T A Y  E N E R G I Z E D  - - - -" >> $footerOL

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
{ wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/1hosts.cf.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/280blocker.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adaway.org.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/ador-energized.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/ador-energized-porn.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adblock-nocoin-list.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adguard-dns.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adguard-english-filter.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adguard-japanese-filter.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adguard-mobile-ads.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adguard-mobile-ads-filter.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adguard-mobile-specific.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adguard-mobile-spyware.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adguard-russian-filter.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adguard-safari.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adguard-spyware.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adguard-spyware-firstparty.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adguard-tracking.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/adware-filters.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/airelle-pub.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/airelle-rsk.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/airelle-sex.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/airelle-trc.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/all-in-one-adblocklist.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/antipopads.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/anudeep-adservers.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/anudeep-coinminer.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/barbblock.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/better-fyi-trackers.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/bjornstar-hosts.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/blockzilla.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/cameleon.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/clefspeare-pornhosts.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/cybercrime.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/disconnect.me-ad.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/disconnect.me-malvertising.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/disconnect.me-tracking.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/dshield.org-high.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/dshield.org-low.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/dshield.org-medium.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/easylist.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/easylist-adservers.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/easylist-adult-adservers.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/easylist-adult-specific.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/easylist-adult-thirdparty.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/easylist-china.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/easylist-russian.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/easyprivacy.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/easyprivacy-specific.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/easyprivacy-thirdparty.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/easyprivacy-tracking-servers.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/eth-phishing-detect.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/fademind-add.2o7net.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/fademind-add.dead.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/fademind-add.risk.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/fademind-add.spam.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/fanboy-annoyance.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/fanboy-complete.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/fanboy-cookiemonster.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/fanboy-enhanced-stats.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/gasb-pe.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/gnuzilla.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/hexxium-creations-threat-list.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/hosts-file.net-ats.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/hosts-file.net-emd.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/hosts-file.net-exp.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/hosts-file.net-grm.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/hosts-file.net-hjk.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/hosts-file.net-mmt.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/hosts-file.net-psh.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/kadhosts.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/lightswitch-hosts-extended.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/mailborder-phishing-bad-sites.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/malwaredomainlist.com.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/malwaredomains.com-immortaldomains.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/malwaredomains.com-justdomains.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/matomo.org-spammers.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/mitchellkrogza-badd-boyz-hosts.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/mobile-ad-trackers.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/molinero-hblock.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/neohost.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/notracking.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/openphish.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/pgl.yoyo.org.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/phishing-hosts.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/pornaway.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/porn-top1million.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/prigent-ads.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/prigent-malware.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/prigent-phishing.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/quidsup-notrack.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/quidsup-notrack-malware.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/ransomwaretracker.abuse.ch.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/sinfonietta-snuff.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/sinfonietta-porn.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/someonewhocares.org.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/spam404.com-adblocklist.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/squidblacklist-dg-ads.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/squidblacklist-dg-malicious.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/sbc.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/stopforumspam.com.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/streaming-ads.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/uassets-annoyances.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/uassets-badware.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/uassets-filters.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/uassets-privacy.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/unchecky-ads.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/urlvir-malicious.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/vokins-yhosts.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/windows-spy-blocker.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/winhelp2002.mvps.org.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/wowdude-pornlist.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/youslist.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/zerodot1-coinblockerlists.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/zerodot1-coinblockerlists-browser.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/zerodot1-coinblockerlists-optional.txt; \
wget -qO- https://raw.githubusercontent.com/EnergizedProtection/block/master/assets/active/filter/zeustracker.abuse.ch.txt; \
} > $file

#-------------------------------------------------------------------------------#
#--------------------------- P R O C E S S  P A C K ----------------------------#
#-------------------------------------------------------------------------------#
# Remove 0.0.0.0
sed 's/0.0.0.0 //' -i $file
# Remove Headers & Comments
sed '/#/d' -i $file
# Remove Blog Domains and Unwanted Craps
sed '/.blogspot./d;/.wixsite./d;/.wordpress./d;/\//d;/:/d;/(/d;/|/d;/\[/d;/\]/d' -i $file
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
# Build Diff Formats
awk '$0="0.0.0.0 "$0' $file > $hosts
awk '$0="0.0.0.0 "$0' $file > $hostsTXT
awk '$0=":: "$0' $file > $hostsV6
awk '$0=$0' $file > $domains
awk '$0="||"$0"^"' $file > $filter
awk '$0="address=/"$0"/0.0.0.0/"' $file > $dnsMasq
awk '$0="address=/"$0"/::1/"' $file > $dnsMasqIPV6
awk '$0="local-zone: \""$0"\" static"' $file > $unbound
awk '$0=$0" CNAME ."' $file > $rpz
awk 'FNR!=1{print l}{l=$0};END{ORS="";print l}' ORS=',' $file > $oneline

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
echo $G"! Domains: "$N$W"$totaldomains"$N
echo $G"! Version: "$N$W"$buildVersion"$N
echo $Y"! $dividerTiny"$N

#-------------------------------------------------------------------------------#
#-------------------------- B U I L D  F O R M A T S ---------------------------#
#-------------------------------------------------------------------------------#
# Clear Cache
rm -f $temp $atemp
echo $G"! Building "$N$Y"hosts"$N$G" Format"$N
# Hosts Header
echo "$headerLogo
# $dividerTiny
# P A C K  D E T A I L S
# $dividerTiny
# Title: $packName
# Description: $packDesc
# Format: hosts
# Version: $buildVersion
# Release: $releaseVersion
# Entries: $totaldomains
# Pack Code: $packCode
# License: $license
# Updated: $updateDate
# RAW: $raw/hosts
# $dividerTiny
#
$localHost
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
# Build Hosts
cat $temp $hosts $footer > $atemp
mv -f $atemp $hosts
#-------------------------------------------------------------------------------#
# Clear Cache
rm -f $temp $atemp
echo $G"! Building "$N$Y"hosts text"$N$G" Format"$N
# Hosts.txt Header
echo "$headerLogo
# $dividerTiny
# P A C K  D E T A I L S
# $dividerTiny
# Title: $packName
# Description: $packDesc
# Format: hosts
# Version: $buildVersion
# Release: $releaseVersion
# Entries: $totaldomains
# Pack Code: $packCode
# License: $license
# Updated: $updateDate
# RAW: $raw/hosts.txt
# $dividerTiny
#
$localHost
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
# Build Hosts
cat $temp $hostsTXT $footer > $atemp
mv -f $atemp $hostsTXT
#-------------------------------------------------------------------------------#
# Clear Cache
rm -f $temp $atemp
echo $G"! Building "$N$Y"hosts ipv6"$N$G" Format"$N
# Hosts IPV6 Header
echo "$headerLogo
# $dividerTiny
# P A C K  D E T A I L S
# $dividerTiny
# Title: $packName
# Description: $packDesc
# Format: hosts IPV6
# Version: $buildVersion
# Release: $releaseVersion
# Entries: $totaldomains
# Pack Code: $packCode
# License: $license
# Updated: $updateDate
# RAW: $raw/hosts-ipv6.txt
# $dividerTiny
#
$localHost
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
# Build Hosts
cat $temp $hostsV6 $footer > $atemp
mv -f $atemp $hostsV6
#-------------------------------------------------------------------------------#
# Clear Cache
rm -f $temp $atemp
echo $G"! Building "$N$Y"domain list"$N$G" Format"$N
# Domain List Header
echo "$headerLogo
# $dividerTiny
# P A C K  D E T A I L S
# $dividerTiny
# Title: $packName
# Description: $packDesc
# Format: domain list
# Version: $buildVersion
# Release: $releaseVersion
# Entries: $totaldomains
# Pack Code: $packCode
# License: $license
# Updated: $updateDate
# RAW: $raw/domains.txt
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
cat $temp $domains $footer > $atemp
mv -f $atemp $domains
#-------------------------------------------------------------------------------#
# Clear Cache
rm -f $temp $atemp
echo $G"! Building "$N$Y"adblock filter"$N$G" Format"$N
# Adblock Filter Header
echo "$headerLogoAB
! $dividerTiny
! P A C K  D E T A I L S
! $dividerTiny
! Title: $packName
! Description: $packDesc
! Format: adblock
! Version: $buildVersion
! Release: $releaseVersion
! Expires: $expiry
! Entries: $totaldomains
! Pack Code: $packCode
! License: $license
! Updated: $updateDate
! RAW: $raw/filter
! $dividerTiny
!
! $dividerTiny
! F E A T U R E S
! $dividerTiny
! $f1\n! $f2\n! $f3\n! $f4\n! $f5\n! $f6\n! $f7\n! $f8
! $dividerTiny
!
! $dividerTiny
! T E A M  B O L T Z - meet the team
! $dividerTiny
! $ador\n! $avinash\n! $badmojr
! $dividerTiny
!
! $dividerTiny
! E N E R G I Z E D  B E G I N S
! $dividerTiny" >> $temp
# Build Filter
cat $temp $filter $footerAB > $atemp
mv -f $atemp $filter
#-------------------------------------------------------------------------------#
# Clear Cache
rm -f $temp $atemp
echo $G"! Building "$N$Y"DNSMasq"$N$G" Format"$N
# DNSMasq Header
echo "$headerLogo
# $dividerTiny
# P A C K  D E T A I L S
# $dividerTiny
# Title: $packName
# Description: $packDesc
# Format: dnsmasq
# Version: $buildVersion
# Release: $releaseVersion
# Entries: $totaldomains
# Pack Code: $packCode
# License: $license
# Updated: $updateDate
# RAW: $raw/dnsmasq.conf
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
# Build DNSMasq
cat $temp $dnsMasq $footer > $atemp
mv -f $atemp $dnsMasq
#-------------------------------------------------------------------------------#
# Clear Cache
rm -f $temp $atemp
echo $G"! Building "$N$Y"DNSMasq ipv6"$N$G" Format"$N
# DNSMasq IPV6 Header
echo "$headerLogo
# $dividerTiny
# P A C K  D E T A I L S
# $dividerTiny
# Title: $packName
# Description: $packDesc
# Format: dnsmasq ipv6
# Version: $buildVersion
# Release: $releaseVersion
# Entries: $totaldomains
# Pack Code: $packCode
# License: $license
# Updated: $updateDate
# RAW: $raw/dnsmasq-ipv6.conf
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
# Build DNSMasq IPV6
cat $temp $dnsMasqIPV6 $footer > $atemp
mv -f $atemp $dnsMasqIPV6
#-------------------------------------------------------------------------------#
# Clear Cache
rm -f $temp $atemp
echo $G"! Building "$N$Y"unbound"$N$G" Format"$N
# Unbound Header
echo "$headerLogo
# $dividerTiny
# P A C K  D E T A I L S
# $dividerTiny
# Title: $packName
# Description: $packDesc
# Format: unbound
# Version: $buildVersion
# Release: $releaseVersion
# Entries: $totaldomains
# Pack Code: $packCode
# License: $license
# Updated: $updateDate
# RAW: $raw/unbound.conf
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
# Build Unbound
cat $temp $unbound $footer > $atemp
mv -f $atemp $unbound
#-------------------------------------------------------------------------------#
# Clear Cache
rm -f $temp $atemp
echo $G"! Building "$N$Y"rpz"$N$G" Format"$N
# RPZ Header
echo "$headerLogoRPZ
; $dividerTiny
; P A C K  D E T A I L S
; $dividerTiny
; Title: $packName
; Description: $packDesc
; Format: rpz
; Version: $buildVersion
; Release: $releaseVersion
; Entries: $totaldomains
; Pack Code: $packCode
; License: $license
; Updated: $updateDate
; RAW: $raw/rpz.txt
; $dividerTiny
;
$localHostRPZ
;
; $dividerTiny
; F E A T U R E S
; $dividerTiny
; $f1\n; $f2\n; $f3\n; $f4\n; $f5\n; $f6\n; $f7\n; $f8
; $dividerTiny
;
; $dividerTiny
; T E A M  B O L T Z - meet the team
; $dividerTiny
; $ador\n; $avinash\n; $badmojr
; $dividerTiny
;
; $dividerTiny
; E N E R G I Z E D  B E G I N S
; $dividerTiny" >> $temp
# Build RPZ
cat $temp $rpz $footerRPZ > $atemp
mv -f $atemp $rpz
#-------------------------------------------------------------------------------#
# Clear Cache
rm -f $temp $atemp
echo $G"! Building "$N$Y"one-line"$N$G" Format"$N
# One Line Header
echo "$headerLogo
# $dividerTiny
# P A C K  D E T A I L S
# $dividerTiny
# Title: $packName
# Description: $packDesc
# Format: one-line
# Version: $buildVersion
# Release: $releaseVersion
# Entries: $totaldomains
# Pack Code: $packCode
# License: $license
# Updated: $updateDate
# RAW: $raw/one-line.txt
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
# Build One-Line
cat $temp $oneline $footerOL > $atemp
mv -f $atemp $oneline
#-------------------------------------------------------------------------------#
# Build GZIP Hosts
echo $G"! Building "$N$Y"hosts gzip"$N$G" Format"$N
gzip -9kf $hosts
# Build GZIP Unbound
##gzip -9f $unbound

# Complete
echo $Y"! $dividerTiny"$N
echo $G"! DONE BUILDING PACK & FORMATS."$N
echo $Y"! $dividerTiny"$N

# Remove Stales
rm -f "$temp" "$atemp" "$file" "$whitelist" "$footer" "$footerAB" "$footerRPZ" "$footerOL"

#-------------------------------------------------------------------------------#
#---------------------------------- D O N E  -----------------------------------#
#-------------------------------------------------------------------------------#
