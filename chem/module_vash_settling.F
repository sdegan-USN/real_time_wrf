Module module_volc_emiss_driver
CONTAINS

!subroutine volcemiss(emis_vol,ims,ime,kms,kme,jms,jme,num_emis_vol,ni,nj,julday_wrf,curr_secs,xlong,xlat,z,i,j,kts,dx,p_e_vash1,p_e_vash2,p_e_vash3,p_e_vash4,p_e_vash5,p_e_vash6,p_e_vash7,p_e_vash8,p_e_vash9,p_e_vash10,p_e_vso2,p_ke_h2o,z_at_w,gmt,config_flags) !Added h2o - SDE 1NOV18
 subroutine volcemiss(emis_vol,ims,ime,kms,kme,jms,jme,num_emis_vol,ni,nj,julday_wrf,curr_secs,xlong,xlat,z,i,j,kts,dx,p_e_vash1,p_e_vash2,p_e_vash3,p_e_vash4,p_e_vash5,p_e_vash6,p_e_vash7,p_e_vash8,p_e_vash9,p_e_vash10,p_e_vso2,p_ke_h2o,z_at_w,gmt,emissoptvol) !Added h2o - SDE 1NOV18
!USE module_configure ! Added for config_flags - SDE 1NOV18
! USE module_configure,only:  grid_config_rec_type
IMPLICIT NONE
! integer :: ims,ime,kms,kme,jms,jme,num_emis_vol,ni,nj,julday_wrf
integer :: ims,ime,kms,kme,jms,jme,num_emis_vol,ni,nj,julday_wrf,emissoptvol
real :: emis_vol(ims:ime,kms:kme,jms:jme,num_emis_vol),xlong(ims:ime,jms:jme),xlat(ims:ime,jms:jme)
real :: z(ims:ime,kms:kme,jms:jme)
real(kind=8) :: curr_secs,secs
REAL :: kcurr_time
integer :: k,i,j,kts
!TYPE(grid_config_rec_type), INTENT(IN  ) :: config_flags

INTEGER :: hgt,timestep,ntimestep
REAL,ALLOCATABLE :: ASH(:,:),SO2(:,:),ASH_EMIS(:),SO2_EMIS(:),H2O_EMIS(:)
INTEGER,ALLOCATABLE :: DATE(:),TIME(:),JULDAY(:),DURATION(:),TIMEW(:)
REAL,ALLOCATABLE :: HEIGHT(:)
! SDE HEIGHT_OFFSETS are the multipliers used to develop the differnt hegihts
REAL,ALLOCATABLE :: HEIGHT_OFFSETS(:)
! Added SDE DEC2019 - heights above and below k_final, which is the 
! plume height specified in volc_d01.asc ASCII file
integer :: k_u1,k_u2,k_d1,k_d2
integer :: year,month,day
integer :: timestep_curr

integer :: nlevels,ref_date
integer :: nr_abschnitte_top,nr_abschnitte_unten
real :: volc_top,volc_unten
REAL,ALLOCATABLE :: VOLC_HEIGHTS_TOP(:),VOLC_HEIGHTS_BOTTOM(:)
REAL,ALLOCATABLE :: hohe_wrf_top(:),hohe_wrf_middle(:),hohe_wrf_unten(:),volc_emiss_wrf(:)
REAL :: total_mass_extern,total_mass_wrf,mass_wrf_k
REAL :: total_mass_extern_so2,total_mass_wrf_so2,mass_wrf_k_so2
INTEGER :: kk
LOGICAL :: level_check
REAL :: HEIGHT_SURFACE
REAL :: area
REAL :: dx
INTEGER :: p_e_vash1,p_e_vash2,p_e_vash3,p_e_vash4,p_e_vash5,p_e_vash6,p_e_vash7,p_e_vash8,p_e_vash9,p_e_vash10,p_e_vso2,p_ke_h2o ! Added h20 - SDE 1NOV18
INTEGER :: bi

INTEGER :: time_before_volc,time_wrf,time_after_volc
REAL :: OFFSET_EXT_WRF

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
REAL :: percen_mass_umbrel,base_umbrel,curr_hours
INTEGER :: ivolcano
REAL :: gmt
INTEGER :: gmtm,gmtp
REAL :: begday,beghr,begmin,endday,endhr,endmin
REAL,ALLOCATABLE :: erup_beg(:,:,:), erup_end(:,:,:),erup_hgt(:,:,:),erup_ash(:,:,:)!,erup_so2(:,:,:),erup_h2o(:,:,:) !!!!!
INTEGER :: ki
REAL :: so2_mass,h2o_flux,emiss_ash_mass
REAL :: emiss_ash_height,eh,erup_so2,erup_h2o
REAL :: ashz_above_vent
REAL :: z_at_w(ims:ime,kms:kme,jms:jme )
INTEGER :: k_final,k_initial
INTEGER :: kk4,x1,ko,kl
!REAL :: vert_mass_dist(kts:kme)
INTEGER :: p_ksbin1,p_ksbin2,p_ksbin3,p_ksbin4,p_ksbin5,p_ksbin6,p_ksbin7,p_ksbin8,p_ksbin9,p_ksbin10 
REAL :: VOLC_HOUR,VOLC_MIN,VOLC_SEC,VOLC_TIME
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!SDE  READ IN volc.asc BEG
WRITE(*,*) "z_at_w ",z_at_w(10,10,10)
!SDE Firse read in the number of timesteps from volc_d01.asc
OPEN(14,FILE="volc_d01.asc")
!SDE skip over the header line
READ(14,*)
READ(14,*) ntimestep

!z_at_w_volc=z(ni,kts,nj)

percen_mass_umbrel=.75
base_umbrel=.25    ! fraction


ivolcano=0
area=dx*dx

!SDE nlevels is number of total heights in ensemble
nlevels=5

emis_vol=0
OFFSET_EXT_WRF=0

!SDE read in the height offset percentages
ALLOCATE(HEIGHT_OFFSETS(nlevels))
READ(14,*) (HEIGHT_OFFSETS(bi),bi=1,nlevels)

!SDE read in ni and nj - these were computed by the scripts
READ(14,*) ni
READ(14,*) nj

!SDE skip over the header line
READ(14,*)

ALLOCATE(DATE(ntimestep),TIME(ntimestep),HEIGHT(ntimestep),DURATION(ntimestep),ASH_EMIS(ntimestep),SO2_EMIS(ntimestep),H2O_EMIS(ntimestep),TIMEW(ntimestep))
ALLOCATE(JULDAY(ntimestep))

DO timestep=1,ntimestep
  READ(14,*) DATE(timestep),TIME(timestep),DURATION(timestep),HEIGHT(timestep)&
    &,ASH_EMIS(timestep),SO2_EMIS(timestep),H2O_EMIS(timestep)
  year=INT(DATE(timestep)/10000)
  ref_date=year*10000+0101
  JULDAY(timestep)=juldate(DATE(timestep),000000)-juldate(ref_date,000000)
  VOLC_HOUR=INT(TIME(timestep)/10000.)
  VOLC_MIN=INT((TIME(timestep)-VOLC_HOUR*10000.)/100.)
  VOLC_SEC=INT((TIME(timestep)-VOLC_HOUR*10000.-VOLC_MIN*100.))
  TIMEW(timestep)=VOLC_HOUR*3600.+VOLC_MIN*60.+VOLC_SEC
  write(*,*) "MARCUS",timestep,JULDAY(timestep),TIME(timestep),HEIGHT(timestep)
  write(*,*) "MARCUS",TIMEW(timestep)
END DO

CLOSE(14)
! READ IN volc.asc END

secs=mod(gmt*3600.+curr_secs,86400.)
write(*,*) "PROBLEM2",julday_wrf,gmt,curr_secs,secs
write(*,*) "PROBLEM2"

! CHECK IF TIMES FIT BEG
timestep_curr=0
DO timestep=1,ntimestep-1 ! last time step in input file should have 0 emission as it should be the end time for the last intervall
  time_before_volc=JULDAY(timestep)*100000.+TIMEW(timestep)
  time_wrf=julday_wrf*100000.+secs ! year*10000000000 should be here as well
  time_after_volc=JULDAY(timestep+1)*100000.+TIMEW(timestep+1)

write(*,*) "MARCUS ddhh3",time_before_volc,time_wrf,time_after_volc

write(*,*) "TIMESTEP1",JULDAY(timestep),DATE(timestep),TIMEW(timestep)
write(*,*) "TIMESTEP1",julday_wrf,secs
write(*,*) "TIMESTEP1"

  IF((time_wrf.ge.time_before_volc).and.(time_wrf.lt.time_after_volc)) THEN
    timestep_curr=timestep
    write(*,*) "TIMESTEP2",time_before_volc,time_wrf,time_after_volc
    write(*,*) "TIMESTEP2",timestep,DATE(timestep),TIMEW(timestep)
    write(*,*) "TIMESTEP2",HEIGHT(timestep),ASH_EMIS(timestep)
    write(*,*) "TIMESTEP2"
  END IF
END DO
! CHECK IF TIMES FIT END
write(*,*) "DO LOOP EXECUTED OK"
!We are using Mastin's caluclations for mass
emiss_ash_height = HEIGHT(timestep_curr)
eh=2600.*(emiss_ash_height*.0005)**4.1494
!eh=ASH_EMIS(timestep_curr)
emiss_ash_mass=eh*1.e9/area
ivolcano=1
!ading SO2 and water vapor - SDE 1NOV18
erup_so2=SO2_EMIS(timestep_curr)
erup_h2o=H2O_EMIS(timestep_curr)
so2_mass=erup_so2*3600.*1.e9/64./area !molecular weight SO2 is 64
h2o_flux=erup_h2o/area ! kg/s ---> kg/(m2s)


! UMBRELLA PART BEG
!ashz_above_vent=emiss_ash_height - z_at_w_volc

! So this is where he is determining the top and bottom 
! of the plume - We'll need to edit
! Note for SDE - k_final is maximum plume height
! Also note that if the warning gives a height below the vent
! that the height in the warning will be used without a 
! vent offset
write(*,*) " ni = ",ni
write(*,*) " nj = ",nj
write(*,*) " kts = ",kts
write(*,*) " emiss_ash_height = ",emiss_ash_height
write(*,*) "z_at_w = ",z_at_w(ni,kts,nj)
ashz_above_vent=emiss_ash_height - z_at_w(ni,kts,nj)
IF(ashz_above_vent.lt.0)THEN
!  ashz_above_vent=emiss_ash_height
   ashz_above_vent=0.0
ENDIF

write(*,*) "SEAN HEIGHT",kts,ashz_above_vent,emiss_ash_height,z_at_w(ni,kts,nj)

write(*,*) "SEAN K_INIT",z_at_w(ni,k,nj),emiss_ash_height,HEIGHT_OFFSETS

!jzhu, 20190702, initialize k_u2,k_u1, k_final, k_d1, k_d2
k_d2=kts+1
k_d1=kts+1
k_final=kts+1
k_u1=kts+1
k_u2=kts+1

do k=kme-1,kts,-1
write(*,*) "z_at_w",z_at_w(ni,k,nj)
!   if(z_at_w(ni,kts,nj) > (emiss_ash_height*HEIGHT_OFFSETS(3))) then
!    k_d2=(kts+1)
!    write(*,*) "*************************************************"
!    write(*,*) "WARNING - EMISSIONS FOR HEIGHT OFFSET OF ",HEIGHT_OFFSETS(1)
!    write(*,*) "IS BELOW TERRAIN LEVEL - ASH IS BEING ADDED"
!    write(*,*) "TO THE LOWEST MODEL LEVEL - SDE"
!    write(*,*) "*************************************************"
!    exit
!  endif
if(z_at_w(ni,k,nj) < (emiss_ash_height*HEIGHT_OFFSETS(3))) then
    k_final=k+1
write(*,*) "K_FINAL",z_at_w(ni,k,nj),emiss_ash_height,k_final
    exit
  endif
enddo

do k=kme-1,kts,-1
  if(z_at_w(ni,k,nj) < (emiss_ash_height*HEIGHT_OFFSETS(4))) then
    k_u1=k+1
write(*,*) "K_UP1",z_at_w(ni,k,nj),emiss_ash_height,k_u1
    exit
  endif
enddo

do k=kme-1,kts,-1
  if(z_at_w(ni,k,nj) < (emiss_ash_height*HEIGHT_OFFSETS(5))) then
    k_u2=k+1
write(*,*) "K_UP2",z_at_w(ni,k,nj),emiss_ash_height,k_u2
    exit
  endif
enddo
do k=kme-1,kts,-1
!   if(z_at_w(ni,kts,nj) > (emiss_ash_height*HEIGHT_OFFSETS(2))) then
!    k_d2=(kts+1)
!    write(*,*) "*************************************************"
!    write(*,*) "WARNING - EMISSIONS FOR HEIGHT OFFSET OF ",HEIGHT_OFFSETS(1)
!    write(*,*) "IS BELOW TERRAIN LEVEL - ASH IS BEING ADDED"
!    write(*,*) "TO THE LOWEST MODEL LEVEL - SDE"
!    write(*,*) "*************************************************"
!    exit
!  endif 
if(z_at_w(ni,k,nj) <= (emiss_ash_height*HEIGHT_OFFSETS(2))) then
    k_d1=k+1
write(*,*) "K_DOWN1",z_at_w(ni,k,nj),emiss_ash_height,k_d1
    exit
  endif
enddo
do k=kme-1,kts,-1
!  if(z_at_w(ni,kts,nj) > (emiss_ash_height*HEIGHT_OFFSETS(1))) then
!    k_d2=(kts+1)
!    write(*,*) "*************************************************"
!    write(*,*) "WARNING - EMISSIONS FOR HEIGHT OFFSET OF ",HEIGHT_OFFSETS(1)
!    write(*,*) "IS BELOW TERRAIN LEVEL - ASH IS BEING ADDED"
!    write(*,*) "TO THE LOWEST MODEL LEVEL - SDE"
!    write(*,*) "*************************************************"
!    exit
!  endif
  if(z_at_w(ni,k,nj) <= (emiss_ash_height*HEIGHT_OFFSETS(1))) then
    k_d2=k+1
write(*,*) "K_DOWN2",z_at_w(ni,k,nj),emiss_ash_height,k_d2
    exit
  endif
enddo

!adjust k_d2 

if(z_at_w(ni,kts,nj) > (emiss_ash_height*HEIGHT_OFFSETS(1))) then
    k_d2=(kts+1)
    write(*,*) "*************************************************"
    write(*,*) "WARNING - EMISSIONS FOR HEIGHT OFFSET OF ",HEIGHT_OFFSETS(1)
    write(*,*) "IS BELOW TERRAIN LEVEL - ASH IS BEING ADDED"
    write(*,*) "TO THE LOWEST MODEL LEVEL - JZhu"
    write(*,*) "*************************************************"
    write(*,*) "K_DOWN2",z_at_w(ni,k,nj),emiss_ash_height,k_d2
endif



!do k=kme-1,kts,-1
!write(*,*) "LUCIA2",k,z_at_w(ni,k,nj),(1.-base_umbrel),ashz_above_vent,z_at_w(ni,kts,nj)
!  if(z_at_w(ni,k,nj) < ((1.-base_umbrel)*ashz_above_vent)+z_at_w(ni,kts,nj))then
!    k_initial=k
!write(*,*) "LUCIA2",z_at_w(ni,k,nj),((1.-base_umbrel)*ashz_above_vent)+z_at_w(ni,kts,nj),k_initial
!    exit
!  endif
!enddo

! So this is the top and bottom of the plume - see below where they're used
write(*,*) "SEAN LEVELS",k_final,k_d1,k_d2,k_u1,k_u2
write(*,*) "SEAN EMISSION RATE",emiss_ash_mass
! Notes for SDE - 29JAN2019
! The previous section of do loops determine the top of the plume
! k_final and the bottom, k_initial
! k_final is specified in the volc_d01.asc file but
! k_initial is calculated via the umbrella plume approximation 


! height_offset is integer defined here that subracts and adds to the 
! central height (k_final)
! SDE We use the new HEIGHT_OFFSET in our new code 

!The following code is not used in the operational tool and is legacy code
!vert_mass_dist=0.
!kk4 = k_final-k_initial+2
!do ko=1,kk4-1
!  kl=ko+k_initial-1
!  vert_mass_dist(kl) = 6.*percen_mass_umbrel* float(ko)    &
!  /float(kk4)**2 * (1. - float(ko)/float(kk4))
!enddo
!if(sum(vert_mass_dist(kts:kme)) .ne. percen_mass_umbrel) then
!  x1= ( percen_mass_umbrel- sum(vert_mass_dist(kts:kme)) )   &
!  /float(k_final-k_initial+1)
!  do ko=k_initial,k_final
!    vert_mass_dist(ko) = vert_mass_dist(ko)+ x1
!  enddo
!endif
!
!do ko=1,k_initial-1   
!  vert_mass_dist(ko)=float(ko)/float(k_initial-1)
!enddo
!x1=sum(vert_mass_dist(1:k_initial-1))
!do ko=1,k_initial-1
!  vert_mass_dist(ko)=(1.-percen_mass_umbrel)*vert_mass_dist(ko)/x1
!enddo
!UMBRELLA PART END - end to legacy code

! WRITE OUT TO ARREY
! VASH 1 through 5 are actually VASH 8
! VASH 6 thorugh 10 are actually VASH 10
! The densities and drag coefficient are updated in 
! module_vash_settling.F to ensure that they are removed
! from the model domain at the correct velocities

! First initialize the variables since some of these values will be 0

do ko=1,kme
    emis_vol(ni,ko,nj,p_e_vash1)=0.0
    emis_vol(ni,ko,nj,p_e_vash2)=0.0
    emis_vol(ni,ko,nj,p_e_vash3)=0.0
    emis_vol(ni,ko,nj,p_e_vash4)=0.0
    emis_vol(ni,ko,nj,p_e_vash5)=0.0
    emis_vol(ni,ko,nj,p_e_vash6)=0.0
    emis_vol(ni,ko,nj,p_e_vash7)=0.0
    emis_vol(ni,ko,nj,p_e_vash8)=0.0
    emis_vol(ni,ko,nj,p_e_vash9)=0.0
    emis_vol(ni,ko,nj,p_e_vash10)=0.0
    !if(config_flags%emiss_opt_vol ==
    !2)emis_vol(ni,ko,nj,p_e_vso2)=vert_mass_dist(ko)*so2_mass
    if(emissoptvol == 2)emis_vol(ni,ko,nj,p_e_vso2)=0.0
    !if(config_flags%emiss_opt_vol ==
    !2)emis_vol(ni,ko,nj,p_ke_h2o)=vert_mass_dist(ko)*h2o_flux
    if(emissoptvol == 2)emis_vol(ni,ko,nj,p_ke_h2o)=0.0
enddo
    emis_vol(ni,k_d2,nj,p_e_vash1)=emiss_ash_mass
    emis_vol(ni,k_d1,nj,p_e_vash2)=emiss_ash_mass
    emis_vol(ni,k_final,nj,p_e_vash3)=emiss_ash_mass
    emis_vol(ni,k_u1,nj,p_e_vash4)=emiss_ash_mass
    emis_vol(ni,k_u2,nj,p_e_vash5)=emiss_ash_mass
    emis_vol(ni,k_d2,nj,p_e_vash6)=emiss_ash_mass
    emis_vol(ni,k_d1,nj,p_e_vash7)=emiss_ash_mass
    emis_vol(ni,k_final,nj,p_e_vash8)=emiss_ash_mass
    emis_vol(ni,k_u1,nj,p_e_vash9)=emiss_ash_mass
    emis_vol(ni,k_u2,nj,p_e_vash10)=emiss_ash_mass
 do ko=1,k_final
    !if(config_flags%emiss_opt_vol == 2)emis_vol(ni,ko,nj,p_e_vso2)=vert_mass_dist(ko)*so2_mass
    if(emissoptvol == 2)emis_vol(ni,ko,nj,p_e_vso2)=so2_mass
    !if(config_flags%emiss_opt_vol == 2)emis_vol(ni,ko,nj,p_ke_h2o)=vert_mass_dist(ko)*h2o_flux
    if(emissoptvol == 2)emis_vol(ni,ko,nj,p_ke_h2o)=h2o_flux
  enddo
! do ko=k_u2+1,kme
!   emis_vol(ni,ko,nj,p_e_vash1)=0.
!   emis_vol(ni,ko,nj,p_e_vash2)=0.
!   emis_vol(ni,ko,nj,p_e_vash3)=0.
!   emis_vol(ni,ko,nj,p_e_vash4)=0.
!   emis_vol(ni,ko,nj,p_e_vash5)=0.
!   emis_vol(ni,ko,nj,p_e_vash6)=0.
!   emis_vol(ni,ko,nj,p_e_vash7)=0.
!   emis_vol(ni,ko,nj,p_e_vash8)=0.
!   emis_vol(ni,ko,nj,p_e_vash9)=0.
!   emis_vol(ni,ko,nj,p_e_vash10)=0.
!   !if(config_flags%emiss_opt_vol == 2)emis_vol(ni,ko,nj,p_e_vso2)=0.
!   if(emissoptvol == 2)emis_vol(ni,ko,nj,p_e_vso2)=0.
!   !if(config_flags%emiss_opt_vol == 2)emis_vol(ni,ko,nj,p_ke_h2o)=0.
!   if(emissoptvol == 2)emis_vol(ni,ko,nj,p_ke_h2o)=0.
! enddo

end subroutine volcemiss


FUNCTION juldate(YYYYMMDD,HHMISS)
IMPLICIT NONE
integer, parameter :: double_k = selected_real_kind(15,307)
integer, parameter :: dp=double_k
INTEGER :: YYYYMMDD,YYYY,MM,DD,HH,MI,SS,HHMISS
INTEGER :: JULDAY,JY,JM,JA,IGREG
REAL (kind=dp) ::  JULDATE
PARAMETER (IGREG=15+31*(10+12*1582))
YYYY=YYYYMMDD/10000
MM=(YYYYMMDD-10000*YYYY)/100
DD=YYYYMMDD-10000*YYYY-100*MM
HH=HHMISS/10000
MI=(HHMISS-10000*HH)/100
SS=HHMISS-10000*HH-100*MI
IF (YYYY.EQ.0) PAUSE 'There is no Year Zero.'
IF (YYYY.LT.0) YYYY=YYYY+1
IF (MM.GT.2) THEN
  JY=YYYY
  JM=MM+1
ELSE
  JY=YYYY-1
  JM=MM+13
ENDIF
JULDAY=INT(365.25*JY)+INT(30.6001*JM)+DD+1720995
IF (DD+31*(MM+12*YYYY).GE.IGREG) THEN
  JA=INT(0.01*JY)
  JULDAY=JULDAY+2-JA+INT(0.25*JA)
ENDIF
JULDATE=DBLE(REAL(JULDAY))+DBLE(REAL(HH)/24.)+&
&DBLE(REAL(MI)/1440.)+DBLE(REAL(SS)/86400.)
END FUNCTION juldate


!FUNCTION julday(dummydate)
!IMPLICIT NONE
!!integer, parameter :: double_k = selected_real_kind(15,307)
!!integer, parameter :: dp=double_k
!INTEGER,INTENT(IN) :: dummydate
!INTEGER :: ref_year
!REAL :: date_act,date_ref
!REAL :: juldate
!!REAL(KIND=dp) :: date_act,date_ref
!!REAL(KIND=dp) :: juldate
!CHARACTER*8 :: chdate
!INTEGER :: julday
!write(chdate,'(I8)') dummydate
!chdate(1:8)=chdate(1:4)//'0101'
!read(chdate(1:8),'(I8)') ref_year
!!date_ref=juldate(ref_year,000000)
!!date_act=juldate(dummydate,000000)
!julday=date_act-date_ref+1
!RETURN
!END FUNCTION julday





subroutine read_dyn_emiss(time_pass)
IMPLICIT NONE

INTEGER :: i,dd,hh,hgt
CHARACTER(20) :: dummy
REAL,ALLOCATABLE :: HEIGHT(:),ASH(:,:,:),SO2(:,:,:)
INTEGER,ALLOCATABLE :: DATE(:),TIME(:)
integer :: time_pass

ALLOCATE(DATE(3),TIME(8),HEIGHT(19))
ALLOCATE(ASH(3,8,19),SO2(3,8,19))

OPEN(14,FILE="emissions.txt")
DO dd=1,3
  DO hh=1,8
    DO hgt=1,19
       READ(14,*) DATE(dd),TIME(hh),HEIGHT(hgt)&
               &,ASH(dd,hh,hgt),SO2(dd,hh,hgt)
       write(*,*) "MARCUS",dd,hh,hgt,DATE(dd),TIME(hh),HEIGHT(hgt)
    END DO
  END DO
ENDDO

CLOSE(14)
time_pass=1

END subroutine


subroutine getij(ni,nj)
integer :: ni,nj
ni=200 !247
nj=200 !336
end subroutine getij

END Module module_volc_emiss_driver
