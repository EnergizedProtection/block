#!/bin/bash
# Energized Protection - Mirror
# https://energized.pro

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

echo "[+] Saving UT1"
ut1Adult=ftp://ftp.ut-capitole.fr/pub/reseau/cache/squidguard_contrib/adult.tar.gz
ut1Cryptojacking=ftp://ftp.ut-capitole.fr/pub/reseau/cache/squidguard_contrib/cryptojacking.tar.gz
ut1Gambling=ftp://ftp.ut-capitole.fr/pub/reseau/cache/squidguard_contrib/gambling.tar.gz
ut1Phishing=ftp://ftp.ut-capitole.fr/pub/reseau/cache/squidguard_contrib/phishing.tar.gz
ut1Publicite=ftp://ftp.ut-capitole.fr/pub/reseau/cache/squidguard_contrib/publicite.tar.gz
ut1Social=ftp://ftp.ut-capitole.fr/pub/reseau/cache/squidguard_contrib/social_networks.tar.gz
wget $ut1Adult
wget $ut1Cryptojacking
wget $ut1Gambling
wget $ut1Malware
wget $ut1Phishing
wget $ut1Publicite
wget $ut1Social


# Untar tar.gz
tar -zxvf adult.tar.gz "adult/domains"
cd adult/
mv -f domains ../ut1-adult.txt
cd ../
rm -r adult/
tar -zxvf cryptojacking.tar.gz "cryptojacking/domains"
cd cryptojacking/
mv -f domains ../ut1-cryptojacking.txt
cd ../
rm -r cryptojacking
tar -zxvf gambling.tar.gz "gambling/domains"
cd gambling/
mv -f domains ../ut1-gambling.txt
cd ../
rm -r gambling
tar -zxvf phishing.tar.gz "phishing/domains"
cd phishing/
mv -f domains ../ut1-phishing.txt
cd ../
rm -r phishing
tar -zxvf publicite.tar.gz "publicite/domains"
cd publicite
mv -f domains ../ut1-publicite.txt
cd ../
rm -r publicite
tar -zxvf social_networks.tar.gz "social_networks/domains"
cd social_networks/
mv -f domains ../ut1-social-networks.txt
cd ../
rm -r social_networks

rm -f *.tar.gz