BEGIN;

COMMENT ON COLUMN "severe_weather".details.episode_id IS '(ID assigned by NWS to denote the storm episode; links the event details file with the information within location file)';

COMMENT ON COLUMN "severe_weather".details.event_id IS '(Primary database key field)
(ID assigned by NWS to note a single, small part that goes into a specific storm episode; links the storm episode between the three files downloaded from SPC’s website)';

COMMENT ON COLUMN "severe_weather".details.state IS 'The state name where the event occurred (no State ID’s are included here; State Name is spelled out in ALL CAPS)';


COMMENT ON COLUMN "severe_weather".details.state_fips IS 'A unique number (State Federal Information Processing Standard) is assigned to the county by the National Institute for Standards and Technology (NIST).';

COMMENT ON COLUMN "severe_weather".details.year IS 'Four digit year for the event in this record';

COMMENT ON COLUMN "severe_weather".details.month_name IS 'Name of the month for the event in this record (spelled out; not abbreviated)';

COMMENT ON COLUMN "severe_weather".details.event_type IS 'The only events permitted in Storm Data are listed in Table 1 of Section 2.1.1 of NWS Directive 10-1605 at http://www.nws.noaa.gov/directives/sym/pd01016005curr.pdf. The chosen event name should be the one that most accurately describes the meteorological event leading to fatalities, injuries, damage, etc. However, significant events, such as tornadoes, having no impact or causing no damage, should also be included in Storm Data.';

COMMENT ON COLUMN "severe_weather".details.cz_type IS 'Indicates whether the event happened in a (C) county/parish, (Z) zone or (M) marine';

COMMENT ON COLUMN "severe_weather".details.cz_fips IS 'The county FIPS number is a unique number assigned to the county by the National Institute for Standards and Technology (NIST) or NWS Forecast Zone Number';

COMMENT ON COLUMN "severe_weather".details.cz_name IS '(County/Parish, Zone or Marine Name assigned to the county FIPS number or NWS Forecast Zone)';

COMMENT ON COLUMN "severe_weather".details.wfo IS '(National Weather Service Forecast Office’s area of responsibility (County Warning Area) in which the event occurred)';

COMMENT ON COLUMN "severe_weather".details.begin_date_time IS 'MM/DD/YYYY  24 hour time AM/PM';

COMMENT ON COLUMN "severe_weather".details.cz_timezone IS '(Time Zone for the County/Parish, Zone or Marine Name)
Eastern Standard Time (EST), Central Standard Time (CST), Mountain Standard Time (MST), etc.';

COMMENT ON COLUMN "severe_weather".details.end_date_time IS 'MM/DD/YYYY  24 hour time AM/PM';

COMMENT ON COLUMN "severe_weather".details.injuries_direct IS 'The number of injuries directly related to the weather event';

COMMENT ON COLUMN "severe_weather".details.injuries_indirect IS 'The number of injuries indirectly related to the weather event';

COMMENT ON COLUMN "severe_weather".details.deaths_direct IS 'The number of deaths directly related to the weather event';

COMMENT ON COLUMN "severe_weather".details.deaths_indirect IS 'The number of deaths indirectly related to the weather event';

COMMENT ON COLUMN "severe_weather".details.damage_property IS 'The estimated amount of damage to property incurred by the weather event.  (e.g. 10.00K = $10,000; 10.00M = $10,000,000)';


COMMIT;
