#!/bin/bash
# Energized - Mirror
#
PUB=http://rlwpx.free.fr/WPFF/hpub.7z
RSK=http://rlwpx.free.fr/WPFF/hrsk.7z
SEX=http://rlwpx.free.fr/WPFF/hsex.7z
TRC=http://rlwpx.free.fr/WPFF/htrc.7z

echo "[+] Saving Airelles"
wget -O hpub.7z $PUB
wget -O hrsk.7z $RSK
wget -O hsex.7z $SEX
wget -O htrc.7z $TRC

# Decompress 7z
7z x hpub.7z
7z x hrsk.7z
7z x hsex.7z
7z x htrc.7z
# Copy as Txt File
cp Hosts.pub airelle-pub.txt
cp Hosts.rsk airelle-rsk.txt
cp Hosts.sex airelle-sex.txt
cp Hosts.trc airelle-trc.txt
# Remove Temp RSK File
rm -rf *.pub
rm -rf *.rsk
rm -rf *.sex
rm -rf *.trc
rm -f hpub.7z
rm -f hrsk.7z
rm -f hsex.7z
rm -f htrc.7z
# Remove first 6 Lines from RSK
sed -i '1,6d' airelle-pub.txt
sed -i '1,6d' airelle-rsk.txt
sed -i '1,6d' airelle-sex.txt
sed -i '1,6d' airelle-trc.txt