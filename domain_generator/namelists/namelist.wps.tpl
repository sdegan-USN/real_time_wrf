   &share
    wrf_core = 'ARW',
    max_dom = 1,
    start_date = '%(year1)s-%(month1)s-%(day1)s_00:00:00',
    end_date   = '%(year2)s-%(month2)s-%(day2)s_00:00:00',
    interval_seconds = %(intervalSeconds)s,
    io_form_geogrid = 2,
   /
   
   &geogrid
    parent_id         =   1,    1,   2,    3,
    parent_grid_ratio =   1,    3,   3,    3,
    i_parent_start    =   1,   67,  67,   67, 
    j_parent_start    =   1,   67,  67,   67,
    e_we              =  400,  199, 199, 199,
    e_sn              =  400,  199, 199, 199,
    geog_data_res     = '30s','30s','2s', '2s',
    dx = 10000,
    dy = 10000,
    map_proj = 'lambert',
    ref_lat   =  %(lat)s,
    ref_lon   =  %(lon)s,
    truelat1  =  %(lat)s,
    truelat2  =  %(lat)s,
    stand_lon =  %(lon)s,
    geog_data_path = '/center1/VOLCWRF/VOLCWRF/operational_v2/WPS_GEOG'
   /
   
   &ungrib
    out_format = 'WPS',
    prefix = 'FILE',
   /
   
   &metgrid
    fg_name = 'FILE'
    io_form_metgrid = 2, 
   /
   
   &mod_levs
    press_pa = 201300 , 200100 , 100000 , 
                95000 ,  90000 , 
                85000 ,  80000 , 
                75000 ,  70000 , 
                65000 ,  60000 , 
                55000 ,  50000 , 
                45000 ,  40000 , 
                35000 ,  30000 , 
                25000 ,  20000 , 
                15000 ,  10000 , 
                 5000 ,   1000
   /
