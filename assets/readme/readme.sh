#!/bin/sh
# Energized Blu - Readme Creator
# make time stamp update
TIMESTAMP=`date +'%b %d, %Y'`
VERSION=`date +'%y.%m.%j.%H'`
# Directory
spk=../../spark/formats
bsc=../../basic/formats
hblu=../../blu/formats
bGo=../../bluGo/formats
prn=../../porn/formats
ulm=../../ultimate/formats
unf=../../unified/formats
sext=../../extensions/social/formats
pext=../../extensions/porn-lite/formats
xtrm=../../extensions/xtreme/formats
reg=../../extensions/regional/formats
ips=../../extensions/ips/formats

# Entries Count
sparkt=$(egrep 'Entries:' $spk/hosts)
basict=$(egrep 'Entries:' $bsc/hosts)
blut=$(egrep 'Entries: ' $hblu/hosts)
blugot=$(egrep 'Entries: ' $bGo/hosts)
pornt=$(egrep 'Entries: ' $prn/hosts)
ultimatet=$(egrep 'Entries: ' $ulm/hosts)
unifiedt=$(egrep 'Entries: ' $unf/hosts)
# Extensions Count
socialext=$(egrep 'Entries: ' $sext/hosts)
pornext=$(egrep 'Entries: ' $pext/hosts)
xtremeext=$(egrep 'Entries: ' $xtrm/hosts)
regionext=$(egrep 'Entries: ' $reg/hosts)
ipsext=$(egrep 'Entries: ' $ips/list.txt)
# RAW & TXT Size
sparks=$(ls -lah $spk/hosts | awk '{print $5}')
basics=$(ls -lah $bsc/hosts | awk '{print $5}')
blus=$(ls -lah $hblu/hosts | awk '{print $5}')
blugos=$(ls -lah $bGo/hosts | awk '{print $5}')
porns=$(ls -lah $prn/hosts | awk '{print $5}')
ultimates=$(ls -lah $ulm/hosts | awk '{print $5}')
unifieds=$(ls -lah $unf/hosts | awk '{print $5}')
## Extensions Size
socialexts=$(ls -lah $sext/hosts | awk '{print $5}')
pornexts=$(ls -lah $pext/hosts | awk '{print $5}')
xtremeexts=$(ls -lah $xtrm/hosts | awk '{print $5}')
regionexts=$(ls -lah $reg/hosts | awk '{print $5}')
ipsexts=$(ls -lah $ips/list.txt | awk '{print $5}')
# IPV6 Size
spark6=$(ls -lah $spk/hosts-ipv6.txt | awk '{print $5}')
basic6=$(ls -lah $bsc/hosts-ipv6.txt | awk '{print $5}')
blu6=$(ls -lah $hblu/hosts-ipv6.txt | awk '{print $5}')
blugo6=$(ls -lah $bGo/hosts-ipv6.txt | awk '{print $5}')
porn6=$(ls -lah $prn/hosts-ipv6.txt | awk '{print $5}')
ultimate6=$(ls -lah $ulm/hosts-ipv6.txt | awk '{print $5}')
unified6=$(ls -lah $unf/hosts-ipv6.txt | awk '{print $5}')
# Filter Size
sparkabf=$(ls -lah $spk/filter | awk '{print $5}')
basicabf=$(ls -lah $bsc/filter | awk '{print $5}')
bluabf=$(ls -lah $hblu/filter | awk '{print $5}')
blugoabf=$(ls -lah $bGo/filter | awk '{print $5}')
pornabf=$(ls -lah $prn/filter | awk '{print $5}')
ultimateabf=$(ls -lah $ulm/filter | awk '{print $5}')
unifiedabf=$(ls -lah $unf/filter | awk '{print $5}')
# Domains List Size
sparkds=$(ls -lah $spk/domains.txt | awk '{print $5}')
basicds=$(ls -lah $bsc/domains.txt | awk '{print $5}')
bluds=$(ls -lah $hblu/domains.txt | awk '{print $5}')
blugods=$(ls -lah $bGo/domains.txt | awk '{print $5}')
pornds=$(ls -lah $prn/domains.txt | awk '{print $5}')
ultimateds=$(ls -lah $ulm/domains.txt | awk '{print $5}')
unifiedds=$(ls -lah $unf/domains.txt | awk '{print $5}')
# One-Line Size
sparkol=$(ls -lah $spk/one-line.txt | awk '{print $5}')
basicol=$(ls -lah $bsc/one-line.txt | awk '{print $5}')
bluol=$(ls -lah $hblu/one-line.txt | awk '{print $5}')
blugool=$(ls -lah $bGo/one-line.txt | awk '{print $5}')
pornol=$(ls -lah $prn/one-line.txt | awk '{print $5}')
ultimateol=$(ls -lah $ulm/one-line.txt | awk '{print $5}')
unifiedol=$(ls -lah $unf/one-line.txt | awk '{print $5}')
# DNSMasq Size
sparkcs=$(ls -lah $spk/dnsmasq.conf | awk '{print $5}')
basiccs=$(ls -lah $bsc/dnsmasq.conf | awk '{print $5}')
blucs=$(ls -lah $hblu/dnsmasq.conf | awk '{print $5}')
blugocs=$(ls -lah $bGo/dnsmasq.conf | awk '{print $5}')
porncs=$(ls -lah $prn/dnsmasq.conf | awk '{print $5}')
ultimatecs=$(ls -lah $ulm/dnsmasq.conf | awk '{print $5}')
unifiedcs=$(ls -lah $unf/dnsmasq.conf | awk '{print $5}')
# DNSMasq IPV6 Size
sparkc6s=$(ls -lah $spk/dnsmasq-ipv6.conf | awk '{print $5}')
basicc6s=$(ls -lah $bsc/dnsmasq-ipv6.conf | awk '{print $5}')
bluc6s=$(ls -lah $hblu/dnsmasq-ipv6.conf | awk '{print $5}')
blugoc6s=$(ls -lah $bGo/dnsmasq-ipv6.conf | awk '{print $5}')
pornc6s=$(ls -lah $prn/dnsmasq-ipv6.conf | awk '{print $5}')
ultimatec6s=$(ls -lah $ulm/dnsmasq-ipv6.conf | awk '{print $5}')
unifiedc6s=$(ls -lah $unf/dnsmasq-ipv6.conf | awk '{print $5}')
# Unbound Size
sparkus=$(ls -lah $spk/unbound.conf | awk '{print $5}')
basicus=$(ls -lah $bsc/unbound.conf | awk '{print $5}')
bluus=$(ls -lah $hblu/unbound.conf | awk '{print $5}')
blugous=$(ls -lah $bGo/unbound.conf | awk '{print $5}')
pornus=$(ls -lah $prn/unbound.conf | awk '{print $5}')
ultimateus=$(ls -lah $ulm/unbound.conf | awk '{print $5}')
unifiedus=$(ls -lah $unf/unbound.conf | awk '{print $5}')
# RPZ Size
sparkrs=$(ls -lah $spk/rpz.txt | awk '{print $5}')
basicrs=$(ls -lah $bsc/rpz.txt | awk '{print $5}')
blurs=$(ls -lah $hblu/rpz.txt | awk '{print $5}')
blugors=$(ls -lah $bGo/rpz.txt | awk '{print $5}')
pornrs=$(ls -lah $prn/rpz.txt | awk '{print $5}')
ultimaters=$(ls -lah $ulm/rpz.txt | awk '{print $5}')
unifiedrs=$(ls -lah $unf/rpz.txt | awk '{print $5}')
# RuleSet Size
sparkrss=$(ls -lah $spk/filter.dat | awk '{print $5}')
#basicrss=$(ls -lah $bsc/filter.dat | awk '{print $5}')
blurss=$(ls -lah $hblu/filter.dat | awk '{print $5}')
blugorss=$(ls -lah $bGo/filter.dat | awk '{print $5}')
#pornrss=$(ls -lah $prn/filter.dat | awk '{print $5}')
#ultimaterss=$(ls -lah $ulm/filter.dat | awk '{print $5}')
#unifiedrss=$(ls -lah $unf/filter.dat | awk '{print $5}')
# add to readme
sed -e "s/_timestamp_/$TIMESTAMP/g" -e "s/_version_/$VERSION/g" -e "s/_sparkt_/$sparkt/g" -e "s/_basict_/$basict/g" -e "s/_blut_/$blut/g" -e "s/_blugot_/$blugot/g" -e "s/_pornt_/$pornt/g" -e "s/_ultimatet_/$ultimatet/g" -e "s/_unifiedt_/$unifiedt/g" -e "s/_socialext_/$socialext/g" -e "s/_pornext_/$pornext/g" -e "s/_xtremeext_/$xtremeext/g" -e "s/_regionext_/$regionext/g" -e "s/_ipsext_/$ipsext/g" -e "s/_sparks_/$sparks/g" -e "s/_basics_/$basics/g" -e "s/_blus_/$blus/g" -e "s/_blugos_/$blugos/g" -e "s/_porns_/$porns/g" -e "s/_ultimates_/$ultimates/g" -e "s/_unifieds_/$unifieds/g"  -e "s/_socialexts_/$socialexts/g"  -e "s/_pornexts_/$pornexts/g"  -e "s/_xtremeexts_/$xtremeexts/g" -e "s/_regionexts_/$regionexts/g"  -e "s/_ipsexts_/$ipsexts/g" -e "s/_spark6_/$spark6/g" -e "s/_basic6_/$basic6/g" -e "s/_blu6_/$blu6/g" -e "s/_blugo6_/$blugo6/g" -e "s/_porn6_/$porn6/g" -e "s/_ultimate6_/$ultimate6/g" -e "s/_unified6_/$unified6/g" -e "s/_sparkabf_/$sparkabf/g" -e "s/_basicabf_/$basicabf/g" -e "s/_bluabf_/$bluabf/g" -e "s/_blugoabf_/$blugoabf/g" -e "s/_pornabf_/$pornabf/g" -e "s/_ultimateabf_/$ultimateabf/g" -e "s/_unifiedabf_/$unifiedabf/g" -e "s/_sparkds_/$sparkds/g" -e "s/_basicds_/$basicds/g" -e "s/_bluds_/$bluds/g" -e "s/_blugods_/$blugods/g" -e "s/_pornds_/$pornds/g" -e "s/_ultimateds_/$ultimateds/g" -e "s/_unifiedds_/$unifiedds/g" -e "s/_sparkol_/$sparkol/g" -e "s/_basicol_/$basicol/g" -e "s/_bluol_/$bluol/g" -e "s/_blugool_/$blugool/g" -e "s/_pornol_/$pornol/g" -e "s/_ultimateol_/$ultimateol/g" -e "s/_unifiedol_/$unifiedol/g" -e "s/_sparkcs_/$sparkcs/g" -e "s/_basiccs_/$basiccs/g" -e "s/_blucs_/$blucs/g" -e "s/_blugocs_/$blugocs/g" -e "s/_porncs_/$porncs/g" -e "s/_ultimatecs_/$ultimatecs/g" -e "s/_unifiedcs_/$unifiedcs/g" -e "s/_sparkc6s_/$sparkc6s/g" -e "s/_basicc6s_/$basicc6s/g" -e "s/_bluc6s_/$bluc6s/g" -e "s/_blugoc6s_/$blugoc6s/g" -e "s/_pornc6s_/$pornc6s/g" -e "s/_ultimatec6s_/$ultimatec6s/g" -e "s/_unifiedc6s_/$unifiedc6s/g" -e "s/_sparkus_/$sparkus/g" -e "s/_basicus_/$basicus/g" -e "s/_bluus_/$bluus/g" -e "s/_blugous_/$blugous/g" -e "s/_pornus_/$pornus/g" -e "s/_ultimateus_/$ultimateus/g" -e "s/_unifiedus_/$unifiedus/g" -e "s/_sparkrs_/$sparkrs/g" -e "s/_basicrs_/$basicrs/g" -e "s/_blurs_/$blurs/g" -e "s/_blugors_/$blugors/g" -e "s/_pornrs_/$pornrs/g" -e "s/_ultimaters_/$ultimaters/g" -e "s/_unifiedrs_/$unifiedrs/g" -e "s/_sparkrss_/$sparkrss/g" -e "s/_basicrss_/$basicrss/g" -e "s/_blurss_/$blurss/g" -e "s/_blugorss_/$blugorss/g" -e "s/_pornrss_/$pornrss/g" -e "s/_ultimaterss_/$ultimaterss/g" -e "s/_unifiedrss_/$unifiedrss/g" readme.template > ../readme.tmp
echo >> ../readme.tmp
# add to file
cat ../readme.tmp  > ../../README.md
echo "- Adding Date"
echo "- Adding Version"
echo "- Adding Total Entries"
echo "- Adding Sizes"

# remove tmp file
rm -rf ../*.tmp

# remove extra text
echo "- Removing Extras"
sed -i -e 's/# Entries: //g' ../../README.md

echo "[+] Done !"