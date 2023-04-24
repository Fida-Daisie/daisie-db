insert into fida.ta_land (name_land) 
select col8 from fida.ta_temp
group by col8
order by col8;


insert into fida.ta_kunde 
select cast(cast(col7 as decimal) as integer), b.id  from fida.ta_temp a inner join fida.ta_land b on a.col8 = b.name_land
group by col7, b.id 
order by col7;

insert into fida.ta_rechnung 
select cast(col1 as integer) as rechnungsnr, cast(substr(col5, 1, 10) as date) as rechnungsdatum, 
cast(cast(col7 as decimal) as integer)
from fida.ta_temp a 
group by col1 , substr(col5, 1, 10), col7
order by col1;

with cte as (
select col2 as artikelnr
, col3 as artikelbeschreibung,
cast(col6 as decimal) as preis, rank() over(partition by col2 order by col2, col3, col6) as rank_nr
from fida.ta_temp
group by col2, col3, col6
)
insert into fida.ta_artikel 
select artikelnr, artikelbeschreibung, preis
from Cte where rank_nr = 1;

insert into fida.ta_rechnung_position 
select cast(col1 as integer) rechnungsnr, 
rank() over (partition by col1 order by col2) as rechnungsposition,
col2 as artikelnr,
cast(col4 as integer) as menge
from FIDA.ta_temp;

