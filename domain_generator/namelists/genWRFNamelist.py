#!/usr/bin/env python

import datetime
import csv

day0tpl='namelist.input.day0'
#day1NOChemtpl='namelist.input.day1NOchem'
day1Chemtpl='namelist.input.day1chem'


#data=[]

#with open('volc.dat', 'rU') as source:
#  reader = csv.reader(source, delimiter=' ')
#  for row in reader:
#    data.append(row)

today = datetime.date.today()
#As is done with WPS, we are setting the time
#delta to two days (2) so that we can get a 
#48 hour simulation.
tomorrow = today + datetime.timedelta(days=2)
yesterday = today + datetime.timedelta(days=-1)

day0dict={}
day0dict['yearLess1']=str(yesterday.year)
day0dict['dayLess1']=str(yesterday.day).zfill(2)
day0dict['monthLess1']=str(yesterday.month).zfill(2)
day0dict['yearLess2']=str(today.year)
day0dict['dayLess2']=str(today.day).zfill(2)
day0dict['monthLess2']=str(today.month).zfill(2)

day1dict={}
day1dict['year1']=str(today.year)
day1dict['day1']=str(today.day).zfill(2)
day1dict['month1']=str(today.month).zfill(2)
day1dict['year2']=str(tomorrow.year)
day1dict['month2']=str(tomorrow.month)
day1dict['day2']=str(tomorrow.day)

template=open('namelist.input.day0.tpl','rU').read()
fh=open(day0tpl,'w')
fh.write(template%day0dict)
fh.close

#template2=open('namelist.input.day1NOchem.tpl','rU').read()
#fh=open(day1NOChemtpl,'w')
#fh.write(template2%day1dict)
#fh.close

template3=open('namelist.input.day1chem.tpl','rU').read()
fh=open(day1Chemtpl,'w')
fh.write(template3%day1dict)
fh.close
