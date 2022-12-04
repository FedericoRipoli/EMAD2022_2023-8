


update excelservizi.servizi set struttura = concat(struttura ," - ", ente) where struttura="Sede Legale"
update excelservizi.servizi set indirizzo="Via Pizzi, 9 - Castiglione dei Genovesi (SA)", latlong="40.724125, 14.849915" where ente="Emmaus" and struttura="Oltre I Confini"
update excelservizi.servizi set struttura="Villa Formosa - Cava de' Tirreni", latlong="40.724125, 14.849915" where ente="Centro di Riabilitazione Lars S.r.l" and struttura="Villa Formosa"
                                                                                                               and indirizzo="Via Pietro Formosa, 19 - 84013 Cava de' Tirreni (SA)";
update excelservizi.servizi set struttura="Villa Formosa - Siano", latlong="40.724125, 14.849915" where ente="Centro di Riabilitazione Lars S.r.l" and struttura="Villa Formosa"
                                                                                                    and indirizzo="Via Santa Maria Delle Grazie, 11-15 - 84088 Siano SA";

CREATE
TEMPORARY TABLE unq_enti
SELECT distinct(ente)
FROM excelservizi.servizi;
insert into test.ente(denominazione, id, descrizione)
SELECT ente, UUID(), ""
FROM unq_enti;

insert into test.struttura(id, denominazione, ente_id)
select uuid(), struttura, id
from (select distinct struttura, test.ente.id
      from excelservizi.servizi
               left join test.ente on ente = test.ente.denominazione) as t;

CREATE
TEMPORARY TABLE unq_pos
(select distinct ente, struttura, indirizzo,lat,lon,test.struttura.id as idstruttura, uuid() as idpos from
(
select *, uuid() as posid from (
                                   select distinct ente, struttura, indirizzo,  SUBSTRING_INDEX(latlong,', ', 1) AS lat,  SUBSTRING_INDEX(latlong,', ', -1) AS lon, test.struttura.id from excelservizi.servizi
                                                                                                                                                                                               inner join test.struttura on test.struttura.denominazione=struttura
                               ) as t
) as t1
inner join test.struttura on  test.struttura.denominazione=struttura)
insert into posizione(id,indirizzo,latitudine,longitudine)
select idpos,indirizzo, lat, lon from unq_pos
update struttura set posizione_id=(select idpos from unq_pos where idstruttura=struttura.id)

    insert into test.area (id, nome)
select uuid(),area from (select distinct area from excelservizi.servizi) as t

























