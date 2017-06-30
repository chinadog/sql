-- Schema: Trifecta

-- DROP SCHEMA "Trifecta";

CREATE SCHEMA "Trifecta"
  AUTHORIZATION postgres;

-- Table: "Trifecta".dangerevents

-- DROP TABLE "Trifecta".dangerevents;

CREATE TABLE "Trifecta".dangerevents
(
  id serial NOT NULL,
  customerid bigint,
  receivedat timestamp without time zone,
  devicereportedtime timestamp without time zone,
  facility smallint,
  priority smallint,
  fromhost character varying(60),
  message text,
  ntseverity integer,
  importance integer,
  eventsource character varying(60),
  eventuser character varying(60),
  eventcategory integer,
  eventid integer,
  eventbinarydata text,
  maxavailable integer,
  currusage integer,
  minusage integer,
  maxusage integer,
  infounitid integer,
  syslogtag character varying(60),
  eventlogtype character varying(60),
  genericfilename character varying(60),
  systemid integer,
  CONSTRAINT dangerevents_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Trifecta".dangerevents
  OWNER TO postgres;

-- Table: "Trifecta".filterevents

-- DROP TABLE "Trifecta".filterevents;

CREATE TABLE "Trifecta".filterevents
(
  id serial NOT NULL,
  customerid bigint,
  receivedat timestamp without time zone,
  devicereportedtime timestamp without time zone,
  facility smallint,
  priority smallint,
  fromhost character varying(60),
  message text,
  ntseverity integer,
  importance integer,
  eventsource character varying(60),
  eventuser character varying(60),
  eventcategory integer,
  eventid integer,
  eventbinarydata text,
  maxavailable integer,
  currusage integer,
  minusage integer,
  maxusage integer,
  infounitid integer,
  syslogtag character varying(60),
  eventlogtype character varying(60),
  genericfilename character varying(60),
  systemid integer,
  CONSTRAINT filterevents_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Trifecta".filterevents
  OWNER TO postgres;

-- Table: "Trifecta".normalevents

-- DROP TABLE "Trifecta".normalevents;

CREATE TABLE "Trifecta".normalevents
(
  id serial NOT NULL,
  customerid bigint,
  receivedat timestamp without time zone,
  devicereportedtime timestamp without time zone,
  facility smallint,
  priority smallint,
  fromhost character varying(60),
  message text,
  ntseverity integer,
  importance integer,
  eventsource character varying(60),
  eventuser character varying(60),
  eventcategory integer,
  eventid integer,
  eventbinarydata text,
  maxavailable integer,
  currusage integer,
  minusage integer,
  maxusage integer,
  infounitid integer,
  syslogtag character varying(60),
  eventlogtype character varying(60),
  genericfilename character varying(60),
  systemid integer,
  CONSTRAINT normalevents_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Trifecta".normalevents
  OWNER TO postgres;

-- Function: func_event_update()

-- DROP FUNCTION func_event_update();

CREATE OR REPLACE FUNCTION func_event_update()
  RETURNS trigger AS
$BODY$BEGIN
PERFORM pg_notify( 'event', 'U'||'|'||NEW.id::varchar(20) );
RETURN NULL;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION func_event_update()
  OWNER TO postgres;

-- Trigger: tr_event_update on systemevents

-- DROP TRIGGER tr_event_update ON systemevents;

CREATE TRIGGER tr_event_update
  AFTER INSERT OR UPDATE
  ON systemevents
  FOR EACH ROW
  EXECUTE PROCEDURE func_event_update();
