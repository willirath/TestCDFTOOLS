#!/bin/bash

# path to script (everything else defined relative to this one)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# test data is in
data_path=${DIR}/../data/ORCA05.L46-TEST01
sections_path=${DIR}/../data/sections

# output data goes to
output_path=${DIR}/../output/cdf_xtrac_brokenline_001/ORCA05.L46-TEST01
mkdir -p ${output_path}

# CDFTOOL (if defined, remove trailing / if present)
[ -z ${CDFTOOLPATH} ] || CDFTOOLPATH=${CDFTOOLPATH%/}
cdftool=${CDFTOOLPATH}/cdf_xtrac_brokenline

# data file names
T_file=ORCA05.L46-TEST01_1m_18500101_18501231_grid_T.nc
U_file=ORCA05.L46-TEST01_1m_18500101_18501231_grid_U.nc
V_file=ORCA05.L46-TEST01_1m_18500101_18501231_grid_V.nc
ice_file=ORCA05.L46-TEST01_1m_18500101_18501231_icemod.nc

# link all section files

# go to output dir, link data files, metrics files, section files and run
# cdftool

cd ${output_path}

ln -s ${data_path}/${T_file} .
ln -s ${data_path}/${U_file} .
ln -s ${data_path}/${V_file} .
ln -s ${data_path}/${ice_file} .

ln -s ${data_path}/m*nc .

ln -s ${sections_path}/section_*.dat .
sections_files=`ls -m section_* | sed -e 's/, /,/g'`

${cdftool} ${T_file} ${U_file} ${V_file} ${ice_file} \
    -f ${sections_files} \
    -verbose -ssh -mld -fulluv
