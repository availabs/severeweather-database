BEGIN;

CREATE TABLE "severe_weather".mda (
	ztime BIGINT, 
	lon FLOAT, 
	lat FLOAT, 
	wsr_id VARCHAR, 
	cell_id INTEGER, 
	str_rank VARCHAR, 
	scit_id VARCHAR, 
	range INTEGER, 
	azimuth INTEGER, 
	ll_rot_vel INTEGER, 
	ll_dv INTEGER, 
	ll_base INTEGER, 
	depth_kft INTEGER, 
	dpth_stmrl INTEGER, 
	max_rv_kft INTEGER, 
	max_rv_kts INTEGER, 
	tvs BOOLEAN, 
	motion_deg INTEGER, 
	motion_kts INTEGER, 
	msi INTEGER
);

COMMIT;
