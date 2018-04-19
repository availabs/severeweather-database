BEGIN;

CREATE SCHEMA IF NOT EXISTS "severe_weather";

CREATE TABLE IF NOT EXISTS "severe_weather".warn (
	issuedate TIMESTAMP WITHOUT TIME ZONE, 
	expiredate TIMESTAMP WITHOUT TIME ZONE, 
	issuewfo VARCHAR, 
	messageid VARCHAR, 
	messagetype VARCHAR, 
	warningtype VARCHAR, 
	polygon VARCHAR
);

COMMIT;
