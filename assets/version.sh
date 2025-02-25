#!/bin/bash
#-------------------------------------------------------------------------------#
#-------------------------- I N F O  &  L I C E N S E --------------------------#
#-------------------------------------------------------------------------------#
# Energized Protection - ad.porn.malware blocking.
# Packs Versioning Script
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
versionMD=../VERSION.md

#-------------------------------------------------------------------------------#
#------------------------ P R O J E C T  D E T A I L S -------------------------#
#-------------------------------------------------------------------------------#
#----------------------------- FILL THE INFO HERE ------------------------------#
#-------------------------------------------------------------------------------#
project="Energized Protection"
projectDesc="ad.porn.malware blocking."
buildVersion=$(date +%y.%m.%j.%H)
releaseVersion=$(date +%j%H%M)
license="CC BY-NC-SA 4.0, https://energized.pro/license"
git="https://github.com/EnergizedProtection/block"
gitlab="https://gitlab.com/EnergizedProtection/block"
website="https://energized.pro"
updateDate=$(date +"%a, %d %b %y %H:%M:%S %Z")


#-------------------------------------------------------------------------------#
#-------------------------- B U I L D  V E R S I O N ---------------------------#
#-------------------------------------------------------------------------------#
# Remove Previous
rm -f $versionMD
# Echo
echo $G"! Building "$N$Y"VERSION.md"$N
echo "! Project: $project

! Description: $projectDesc

! Version: 6.33.0923.$buildVersion

! Build Version: $buildVersion

! Build Date: $updateDate

! Version Code: $releaseVersion

! License: $license

! Github: $git

! Web: $website" >> $versionMD

#-------------------------------------------------------------------------------#
#---------------------------------- D O N E  -----------------------------------#
#-------------------------------------------------------------------------------#
