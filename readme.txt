The files contained in these directories may be used 
to modify the Weather Research Forecasting with Chemsitry
(WRF-CHEM) model to be run in near real time using 10
model members with 5 heights and 2 particle sizes. 

The domain_generator folder contains an example automation
script that parses e-mail for text that would indicate
an imminent eruption, along with a sample e-mail alert.
The scripts in the domain_generator folder can be used
to automate WRF-Chem and have it autoinitialize when an 
alert is received.

The chem directory contains editied Fortran code that 
enables the use of 5 heights (module_volc_emiss_driver.F)
and 2 particle sizes (module_vash_settling.F). 

The slurm batch scheduler file is an example of how to 
run WRF automatically using a batch scheduling system 
(in this case Slurm). PBS examples are available upon
request. 

If custom tailoring this code to user needs, the volc_d01.asc
templates located in the domain_generator folder need to be
placed in the em_real directory before launching wrf.exe.
This is evident in the scripts.  

For questions on configuration, e-mail Sean Egan at:

sean.d.egan@navy.mil
sean.egan@navy.smil.mil
sdegan@alaska.edu
