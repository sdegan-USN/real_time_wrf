#!/usr/bin/env python

import datetime
import csv

volcout='volc_d01.asc'

data=[]

with open('domain.asc', 'rU') as source:
  reader = csv.reader(source)#, delimiter=' ')
  for row in reader:
    data.append(row)

today = datetime.date.today()
erup_hour=[x.split(':') for x in data[3]]
tomorrow = today + datetime.timedelta(days=1)
tomorrow2 = today + datetime.timedelta(days=2)
yesterday = today + datetime.timedelta(days=-1)

datadict={}
datadict['i']=str(data[6][0])
datadict['j']=str(data[7][0])
datadict['year1']=str(yesterday.year)
datadict['year2']=str(today.year)
datadict['year3']=str(tomorrow.year)
datadict['year4']=str(tomorrow2.year)
datadict['day1']=str(yesterday.day).zfill(2)
datadict['day2']=str(today.day).zfill(2)
datadict['day3']=str(tomorrow.day).zfill(2)
datadict['day4']=str(tomorrow2.day).zfill(2)
datadict['month1']=str(yesterday.month).zfill(2)
datadict['month2']=str(today.month).zfill(2)
datadict['month3']=str(tomorrow.month).zfill(2)
datadict['month4']=str(tomorrow2.month).zfill(2)
datadict['lat']=data[0][0]
datadict['lon']=data[1][0]
datadict['intervalSeconds']=str(21600)

datadict['date1']=str(datadict['year1']+datadict['month1']+datadict['day1'])
datadict['date2']=str(datadict['year2']+datadict['month2']+datadict['day2'])
datadict['date3']=str(datadict['year3']+datadict['month3']+datadict['day3'])
datadict['date4']=str(datadict['year4']+datadict['month4']+datadict['day4'])

if int(erup_hour[0][0]) in range(0,3):
  datadict['height0'] = str(int(float(data[4][0])*1000))
else:
  datadict['height0'] = str(0).zfill(4)
if int(erup_hour[0][0]) in range(3,6):
  datadict['height1'] = str(int(float(data[4][0])*1000))
else:
  datadict['height1'] = str(0).zfill(4)
if int(erup_hour[0][0]) in range(6,9):
  datadict['height2'] = str(int(float(data[4][0])*1000))
else:
  datadict['height2'] = str(0).zfill(4)
if int(erup_hour[0][0]) in range(9,12):
  datadict['height3'] = str(int(float(data[4][0])*1000))
else:
  datadict['height3'] = str(0).zfill(4)
if int(erup_hour[0][0]) in range(12,15):
  datadict['height4'] = str(int(float(data[4][0])*1000))
else:
  datadict['height4'] = str(0).zfill(4)
if int(erup_hour[0][0]) in range(15,18):
  datadict['height5'] = str(int(float(data[4][0])*1000))
else:
  datadict['height5'] = str(0).zfill(4)
if int(erup_hour[0][0]) in range(18,21):
  datadict['height6'] = str(int(float(data[4][0])*1000))
else:
  datadict['height6'] = str(0).zfill(4)
if int(erup_hour[0][0]) in range(21,24):
  datadict['height7'] = str(int(float(data[4][0])*1000))
else:
  datadict['height7'] = str(0).zfill(4)

template=open('volc_d01.tpl','rU').read()
fh=open(volcout,'w')
fh.write(template%datadict)
fh.close
