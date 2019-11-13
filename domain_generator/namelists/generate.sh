#!/bin/bash
python genWPSNamelist.py
python genWRSnamelist.py
mv namelist.wps /center1/VOLCWRF/VOLCWRF/operational_v2/WPS/namelist.wps
mv domain.ncl /center1/VOLCWRF/VOLCWRF/operational_v2/WPS/domain.ncl
mv namelist.input.day0 /center1/VOLCWRF/VOLCWRF/operational_v2/WRFV3/case/em_real/ 
mv namelist.input.day1chem /center1/VOLCWRF/VOLCWRF/operational_v2/WRFV3/case/em_real/
cd /center1/VOLCWRF/VOLCWRF/operational_v2/WPS/
/center1/VOLCWRF/VOLCWRF/operational_v2/WPS/runWPS.sh
