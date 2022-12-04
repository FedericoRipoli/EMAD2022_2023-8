ALTER TABLE import_servizi CHANGE id id VARCHAR(255) NOT NULL DEFAULT (UUID());

update import_servizi set struttura = concat(struttura ," - ", ente) where struttura="Sede Legale"
update import_servizi set indirizzo="Via Pizzi, 9 - Castiglione dei Genovesi (SA)", latlong="40.724125, 14.849915" where ente="Emmaus" and struttura="Oltre I Confini"
update import_servizi set struttura="Villa Formosa - Cava de' Tirreni", latlong="40.724125, 14.849915" where ente="Centro di Riabilitazione Lars S.r.l" and struttura="Villa Formosa"
                                                                                                               and indirizzo="Via Pietro Formosa, 19 - 84013 Cava de' Tirreni (SA)";
update import_servizi set struttura="Villa Formosa - Siano", latlong="40.724125, 14.849915" where ente="Centro di Riabilitazione Lars S.r.l" and struttura="Villa Formosa"
update import_servizi set struttura="Sede Cassiopea" where ente="Cassiopea Società Cooperativa Sociale" and servizio="Centro di prima accoglienza e di sistemazione alloggiativa temporanea" and indirizzo="Via Ostaglio - 84133 Salerno (SA)"