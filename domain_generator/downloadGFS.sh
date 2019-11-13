#!/bin/bash

rm -f /center1/VOLCWRF/sdegan/operational_v2/WPS/GFS/*
cd /center1/VOLCWRF/sdegan/operational_v2/WPS/GFS/
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date -d "yesterday" +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f000
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date -d "yesterday" +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f003
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date -d "yesterday" +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f006
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date -d "yesterday" +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f009
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date -d "yesterday" +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f012
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date -d "yesterday" +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f015
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date -d "yesterday" +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f018
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date -d "yesterday" +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f021
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date -d "yesterday" +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f024
mv gfs.t00z.pgrb2.0p50.f000 agfs.t00z.pgrb2.0p50.f000
mv gfs.t00z.pgrb2.0p50.f003 agfs.t00z.pgrb2.0p50.f003
mv gfs.t00z.pgrb2.0p50.f006 agfs.t00z.pgrb2.0p50.f006
mv gfs.t00z.pgrb2.0p50.f009 agfs.t00z.pgrb2.0p50.f009
mv gfs.t00z.pgrb2.0p50.f012 agfs.t00z.pgrb2.0p50.f012
mv gfs.t00z.pgrb2.0p50.f015 agfs.t00z.pgrb2.0p50.f015
mv gfs.t00z.pgrb2.0p50.f018 agfs.t00z.pgrb2.0p50.f018
mv gfs.t00z.pgrb2.0p50.f021 agfs.t00z.pgrb2.0p50.f021
mv gfs.t00z.pgrb2.0p50.f024 agfs.t00z.pgrb2.0p50.f024
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f000
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f003
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f006
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f009
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f012
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f015
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f018
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f021
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f024
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f027
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f030
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f033
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f036
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f039
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f042
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f045
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f048
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f051
wget http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.`date +"%Y%m%d"`/00/gfs.t00z.pgrb2.0p50.f054
