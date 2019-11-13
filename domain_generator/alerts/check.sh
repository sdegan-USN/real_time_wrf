#!/bin/bash
if cat *.eml | grep -q "Alert Confidence: HIGH"; then
  grep Latitude *.eml | awk {'print $5'} > ../namelists/domain.asc
  grep Longitude *.eml | awk {'print $5'} >> ../namelists/domain.asc
  grep 'Mean Object Date' *.eml | awk {'print $4'} >> ../namelists/domain.asc
  grep 'Mean Object Date' *.eml | awk {'print $5'} >> ../namelists/domain.asc
  grep 'Maximum Height' *.eml | awk {'print $4'} >> ../namelists/domain.asc 
  awk '/Volcanoes \(meeting alert/{getline; print}' *.eml >> ../namelists/domain.asc
  cp ../namelists/domain.asc ../volc_info
  mv *.eml ./archived
  cd /center1/VOLCWRF/VOLCWRF/operational_v2
  sbatch Operational_WPS.slurm
else
  echo "Nope"
fi
