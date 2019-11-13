#!/usr/bin/env python

import datetime
import csv

nametpl='namelist.wps'
domaintpl='domain.ncl'

data=[]

with open('domain.asc', 'rU') as source:
  reader = csv.reader(source)#, delimiter=' ')
  for row in reader:
    data.append(row)

today = datetime.date.today()
#tomorrow is timedelta of 2 days because we need
#the day after tomorrow at midnight for the last
#48 hour run to be complete.
tomorrow = today + datetime.timedelta(days=2)
yesterday = today + datetime.timedelta(days=-1)

datadict={}
datadict['year1']=str(yesterday.year)
datadict['year2']=str(tomorrow.year)
datadict['day1']=str(yesterday.day).zfill(2)
datadict['day2']=str(tomorrow.day).zfill(2)
datadict['month1']=str(yesterday.month).zfill(2)
datadict['month2']=str(tomorrow.month).zfill(2)
datadict['lat']=data[0][0]
datadict['lon']=data[1][0]
datadict['intervalSeconds']=str(21600)

namedict={}
name=[x.strip().split('(') for x in data[5]]
namedict['volcanoName']='%s' %name[0][0]
namedict['lat'] =data[0][0]
namedict['lon'] =data[1][0]

template=open('namelist.wps.tpl','rU').read()
fh=open(nametpl,'w')
fh.write(template%datadict)
fh.close

template2=open('domain.tpl','rU').read()
fh=open(domaintpl,'w')
fh.write(template2%namedict)
fh.close
