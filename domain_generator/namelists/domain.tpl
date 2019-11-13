;This script plots SO2 column densities derived from WRF-Chem
;output, along with vector plots describing the winds and 
;geopotential heights of the meteorological fields
;Created SDE March-April 2013

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin

; Specify input file

  a = addfile("geo_em.d01.nc","r")   ; Open the next file

; Select a plot type
;  type = "x11"
; type = "pdf"
  type = "png"

; specify output format and filename

  wks = gsn_open_wks(type,"%(volcanoName)s")

  volcLat = %(lat)s
  volcLon = %(lon)s 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; NOW WE DO THE METEOROLOGY COMPUTATIONS FOR THE MET OVERLAYS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    lat = a->XLAT_M(0,:,:)
    lon = a->XLONG_M(0,:,:)   
    dims = dimsizes(lat)
    nlat = dims(0)
    nlon = dims(1)
    print("Lat Max = " + max(lat))
    print("Lat Min = " + min(lat))
    print("Lon Max = " + max(lon))
    print("Lon Min = " + min(lon))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SECTION FOR CREATING SO2 CONTOURS AND MAP OVERLAYS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   gsn_define_colormap(wks,"hotres")
;  gsn_define_colormap(wks,"BlueRed")
;  gsn_define_colormap(wks,"rainbow")
;  gsn_define_colormap(wks,"WhViBlGrYeOrReWh")
  gsn_define_colormap(wks,"WhBlGrYeRe")
  res                         = True
  res@gsnMaximize             = False
  ;res@tfDoNDCOverlay          = True
  res@gsnDraw                 = False        ; Turn off for now.
  res@gsnFrame                = False        ; Will draw later
  ;res@pmTickMarkDisplayMode  = "Always"
  res@tiMainOn                = True 
  res@tiMainString            = "%(volcanoName)s" + " WRF-Chem Domain"
  ;res@tiMainString            = "Popocate~H-13V2F35~B~FV-2H3~petl WRF-Chem Domain"

  pres                        = True
  pres@tiMainOn               = False

  mpres                              = res
  mpres@mpProjection                 = "LambertConformal"
  mpres@mpGridAndLimbOn              = True
  mpres@mpLimitMode                  = "Corners"
  mpres@mpLeftCornerLatF             = lat(0,0)
  mpres@mpLeftCornerLonF             = lon(0,0)
  mpres@mpRightCornerLatF            = lat(nlat-1,nlon-1)
  mpres@mpRightCornerLonF            = lon(nlat-1,nlon-1)
  mpres@mpLambertParallel1F          = a@TRUELAT1
  mpres@mpLambertParallel2F          = a@TRUELAT2
  mpres@mpLambertMeridianF           = a@STAND_LON
  mpres@mpDataBaseVersion            = "MediumRes"
  mpres@mpOutlineBoundarySets        = "GeophysicalAndUSStates"
  mpres@mpFillOn                     = False
  mpres@mpOutlineOn                  = True
  mpres@mpCountyLineThicknessF       = 2.5
  mpres@mpGeophysicalLineThicknessF  = 2.5
  mpres@mpNationalLineThicknessF     = 2.5
  mpres@mpProvincialLineThicknessF   = 2.5
  mpres@mpUSStateLineThicknessF      = 2.5  
  mpres@mpCountyLineColor            = "Black"
  mpres@mpGeophysicalLineColor       = "Black"
  mpres@mpNationalLineColor          = "Black"
  mpres@pmTickMarkDisplayMode        = "Always"
  mpres@mpUSStateLineColor           = "Black"  

  pmres               = True
  pmres@gsMarkerColor = "Red"
  pmres@tiMainOn      = "False"
  pmres@gsMarkerIndex = 7
  pmres@gsMarkerSizeF = 0.01
  pmres@gsMarkerThicknessF = 2.0

  map  = gsn_csm_map(wks,mpres)
  dum  = gsn_add_polymarker(wks, map, volcLon, volcLat, pmres)

  draw(map)   
  frame(wks)

end

