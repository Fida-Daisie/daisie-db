create schema dwh;


create table dwh.ta_stg_artikel (artikel_nr varchar(100) primary key,
    artikelbeschreibung varchar(100) not null,
    artikelpreis decimal (9,2) not null);

create table dwh.ta_stg_land (id integer primary key,
    name_land varchar(100) not null);

create table dwh.ta_stg_kunde (kundennummer integer primary key,
    id_land integer not null);

create table dwh.ta_stg_rechnung (rechnung_nr integer primary key,
    rechnungsdatum date not null,
    kundennummer integer);

create table dwh.ta_stg_rechnung_position(rechnung_nr integer ,
    rechnung_position integer not null,
    artikel_nr varchar(100) ,
    menge integer not null);

alter table dwh.ta_stg_rechnung_position add primary key (rechnung_nr, rechnung_position);

create table dwh.ta_cor_artikel (artikel_nr varchar(100) not null primary key,
    artikelbeschreibung varchar(100) not null,
    artikelpreis decimal (9,2) not null,
    sysstart timestamp not null,
    sysend timestamp not null);

create table dwh.ta_cor_artikel_h (artikel_nr varchar(100) not null,
    artikelbeschreibung varchar(100) not null,
    artikelpreis decimal (9,2) not null,
    sysstart timestamp not null,
    sysend timestamp not null);

alter table dwh.ta_cor_artikel_h add primary key (artikel_nr, sysstart);

create table dwh.ta_cor_land (id integer not null primary key,
    name_land varchar(100) not null,
    sysstart timestamp not null,
    sysend timestamp not null);
   
create table dwh.ta_cor_land_h (id integer not null,
    name_land varchar(100) not null,
    sysstart timestamp not null,
    sysend timestamp not null);
   
alter table dwh.ta_cor_land_h add primary key (id, sysstart);

create table dwh.ta_cor_kunde (kundennummer integer not null primary key,
    id_land integer not null,
    sysstart timestamp not null,
    sysend timestamp not null);

create table dwh.ta_cor_kunde_h (kundennummer integer not null,
    id_land integer not null,
    sysstart timestamp not null,
    sysend timestamp not null);
    
alter table dwh.ta_cor_kunde_h add primary key (kundennummer, sysstart);

create table dwh.ta_cor_rechnung (rechnung_nr integer not null primary key,
    rechnungsdatum date not null,
    kundennummer integer not null,
    sysstart timestamp not null,
   sysend timestamp not null);

create table dwh.ta_cor_rechnung_h (rechnung_nr integer not null,
    rechnungsdatum date not null,
    kundennummer integer not null,
    sysstart timestamp not null,
   sysend timestamp not null);
   
alter table dwh.ta_cor_rechnung_h add primary key (rechnung_nr, sysstart);

create table dwh.ta_cor_rechnung_position( rechnung_nr integer not null,
    rechnung_position integer not null,
    artikel_nr varchar(100) not null,
    menge integer not null,
   sysstart timestamp not null,  
  sysend timestamp not null);
 
alter table dwh.ta_cor_rechnung_position  add primary key (rechnung_nr, rechnung_position);

create table dwh.ta_cor_rechnung_position_h( rechnung_nr integer not null,
    rechnung_position integer not null,
    artikel_nr varchar(100) not null,
    menge integer not null,
   sysstart timestamp not null,  
  sysend timestamp not null);
 
alter table dwh.ta_cor_rechnung_position_h  add primary key (rechnung_nr, rechnung_position, sysstart);

create or replace
function dwh.set_techtimestamp() returns trigger as $BODY$ begin
new.techtimestamp = now();
return new;
end;

$BODY$ language plpgsql volatile;

create table dwh.ta_dim_artikel (dim_artikel_id integer generated always as identity primary key,
artikelbeschreibung varchar(100) not null,
techtimestamp timestamp,
unique(artikelbeschreibung));

create trigger ta_dim_artikel_techtimestamp_trigger before insert or update on dwh.ta_dim_artikel for each row execute procedure dwh.set_techtimestamp();

create table dwh.ta_dim_land (dim_land_id integer generated always as identity primary key,
name_land varchar(100) not null,
techtimestamp timestamp,
unique(name_land));

create trigger ta_dim_land_techtimestamp_trigger before insert or update on dwh.ta_dim_land for each row execute procedure dwh.set_techtimestamp();

CREATE TABLE dwh.ta_dim_zeit (
	dim_zeit_id int4 NOT NULL,
	datum date NOT NULL,
	jahr int4 NOT NULL,
	quartal int4 NOT NULL,
	monat int4 NOT NULL,
	monat_zweistellig bpchar(2) NOT NULL,
	monat_desc varchar(20) NOT NULL,
	techtimestamp timestamp,
	CONSTRAINT ta_dim_zeit_pkey PRIMARY KEY (dim_zeit_id),
	CONSTRAINT ta_dim_zeit_un1 UNIQUE (datum)
);

create trigger ta_dim_zeit_techtimestamp_trigger before insert or update on dwh.ta_dim_zeit for each row execute procedure dwh.set_techtimestamp();


create table dwh.ta_mart_artikelverkauf (
dim_artikel_id integer references dwh.ta_dim_artikel,
dim_land_id integer references dwh.ta_dim_land,
dim_zeit_id integer references dwh.ta_dim_zeit,
fakt_anzahl_artikel decimal (9,2) not null default 0,
fakt_preis_artikel decimal (9,2) not null default 0,
techtimestamp timestamp);

alter table dwh.ta_mart_artikelverkauf add primary key (dim_artikel_id, dim_land_id, dim_zeit_id);

create trigger ta_mart_artikelverkauf_techtimestamp_trigger before insert or update on dwh.ta_mart_artikelverkauf for each row execute procedure dwh.set_techtimestamp();

create view dwh.v_mart_artikelverkauf as
select
	a.fakt_anzahl_artikel,
	a.fakt_preis_artikel,
	b.techtimestamp ,
	c.name_land ,
	d.datum
from
	dwh.ta_mart_artikelverkauf a
inner join dwh.ta_dim_artikel b on a.dim_artikel_id = b.dim_artikel_id
inner join dwh.ta_dim_land c on	a.dim_land_id = c.dim_land_id
inner join dwh.ta_dim_zeit d on	a.dim_zeit_id = d.dim_zeit_id;