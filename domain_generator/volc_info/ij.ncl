load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"  
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl" 
;file="geo_em.d01.nc"
;a=addfile("geo_em.d01.nc","r")
file_name="/center1/VOLCWRF/VOLCWRF/operational_v2/WPS/geo_em.d01.nc" 
;lat=-19.613333 
;lon=63.62
a=addfile(file_name,"r")
ij=wrf_user_ll_to_ij(a,lon,lat,False)
;print("WRF i = "+ij(0))
;print("WRF j = "+ij(1)) 
print(ij(0)+"")
print(ij(1)+"")
