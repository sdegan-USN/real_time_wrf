 &time_control
 run_days                            = 0,
 run_hours                           = 24,
 run_minutes                         = 0,
 run_seconds                         = 0,
 start_year                          = %(yearLess1)s, 2000, 2000,
 start_month                         = %(monthLess1)s,   01,   01,
 start_day                           = %(dayLess1)s,   24,   24,
 start_hour                          = 00,   12,   12,
 start_minute                        = 00,   00,   00,
 start_second                        = 00,   00,   00,
 end_year                            = %(yearLess2)s, 2000, 2000,
 end_month                           = %(monthLess2)s,   01,   01,
 end_day                             = %(dayLess2)s,   25,   25,
 end_hour                            = 00    12,   12,
 end_minute                          = 00,   00,   00,
 end_second                          = 00,   00,   00,
 interval_seconds                    = 21600
 input_from_file                     = .true.,.true.,.true.,
 history_interval                    = 60,  60,   60,
 frames_per_outfile                  = 24, 1000, 1000,
 restart                             = .false.,
 restart_interval                    = 5000,
 io_form_history                     = 2,
 io_form_restart                     = 2,
 io_form_input                       = 2,
 io_form_boundary                    = 2,
 auxinput1_inname                    = "met_em.d<domain>.<date>",
 /

 &domains
 time_step                           = 30, 
 time_step_fract_num                 = 0,
 time_step_fract_den                 = 1,
 max_dom                             = 1,
 e_we                                = 400,    112,   94,
 e_sn                                = 400,    97,    91,
 e_vert                              = 30,    30,    30,
 p_top_requested                     = 5000,
 num_metgrid_levels                  = 32,
 num_metgrid_soil_levels             = 4,
 dx                                  = 10000, 10000,  3333.33,
 dy                                  = 10000, 10000,  3333.33,
 grid_id                             = 1,     2,     3,
 parent_id                           = 0,     1,     2,
 i_parent_start                      = 1,     31,    30,
 j_parent_start                      = 1,     17,    30,
 parent_grid_ratio                   = 1,     3,     3,
 parent_time_step_ratio              = 1,     3,     3,
 feedback                            = 1,
 smooth_option                       = 0
 /

 &physics
 mp_physics                          = 3,     3,     3,
 ra_lw_physics                       = 1,     1,     1,
 ra_sw_physics                       = 1,     1,     1,
 radt                                = 30,    30,    30,
 sf_sfclay_physics                   = 1,     1,     1,
 sf_surface_physics                  = 2,     2,     2,
 bl_pbl_physics                      = 1,     1,     1,
 bldt                                = 0,     0,     0,
 cu_physics                          = 5,     1,     0,
 cudt                                = 0,     5,     5,
 isfflx                              = 1,
 ifsnow                              = 1,
 icloud                              = 1,
 cu_diag                             = 1,
 surface_input_source                = 1,
 num_soil_layers                     = 4,
 sf_urban_physics                    = 0,     0,     0,
 /

 &fdda
 /

 &dynamics
 w_damping                           = 0,
 diff_opt                            = 1,
 km_opt                              = 4,
 diff_6th_opt                        = 0,      0,      0,
 diff_6th_factor                     = 0.12,   0.12,   0.12,
 base_temp                           = 290.
 damp_opt                            = 0,
 zdamp                               = 5000.,  5000.,  5000.,
 dampcoef                            = 0.2,    0.2,    0.2
 khdif                               = 0,      0,      0,
 kvdif                               = 0,      0,      0,
 non_hydrostatic                     = .true., .true., .true.,
 moist_adv_opt                       = 1,      1,      1,     
 scalar_adv_opt                      = 1,      1,      1,     
 /

 &bdy_control
 spec_bdy_width                      = 5,
 spec_zone                           = 1,
 relax_zone                          = 4,
 specified                           = .true., .false.,.false.,
 nested                              = .false., .true., .true.,
 /

 &grib2
 /

 &namelist_quilt
 nio_tasks_per_group = 0,
 nio_groups = 1,
 /

 &chem
 kemit                               = 35,
 chem_opt                            = 0,
 emiss_inpt_opt                      = 1,
 bioemdt                             = 0,
 photdt                              = 0,
 chemdt                              = 30,
 io_style_emissions                  = 1,
 emiss_opt                           = 6,          0,
 emiss_opt_vol                       = 2,          0,
 emiss_ash_hgt                       = 11000.,
 chem_in_opt                         = 0,          0,
 phot_opt                            = 0,          0,
 gas_drydep_opt                      = 0,          1,
 aer_drydep_opt                      = 1,          1,
 bio_emiss_opt                       = 0,          0,
 ne_area                             = 0,
 dust_opt                            = 1,
 dmsemis_opt                         = 1,
 seas_opt                            = 1,
 depo_fact                           = 0.25,
 gas_bc_opt                          = 0,          0,
 gas_ic_opt                          = 0,          0,
 aer_bc_opt                          = 1,          0,
 aer_ic_opt                          = 1,          0,
 gaschem_onoff                       = 0,          0,
 aerchem_onoff                       = 1,          0,
 wetscav_onoff                       = 0,          0,
 cldchem_onoff                       = 0,          0,
 vertmix_onoff                       = 1,          0,
 chem_conv_tr                        = 0,          0,
 conv_tr_wetscav                     = 0,          0,
 conv_tr_aqchem                      = 0,          0,
 biomass_burn_opt                    = 0,          0,
 plumerisefire_frq                   = 30,         0,
 have_bcs_chem                       = .false., .false., .false.,
 aer_ra_feedback                     = 0,
 aer_op_opt                          = 0,
 opt_pars_out                        = 0,
 diagnostic_chem                     = 0,
/

