/*Modificare, eliminare i dati Esercizio Schema concettuale 
È necessario implementare uno schema che consenta di gestire le anagrafiche degli store di unʼipotetica azienda.
Uno store è collocato in una precisa area geografica. In unʼarea geografica possono essere collocati store diversi. 
Cosa devi fare: 1.Crea una tabella Store per la gestione degli store (ID, nome, data apertura, ecc.) 
2.Crea una tabella Region per la gestione delle aree geografiche (ID, città, regione, area geografica, …) 
3.Popola con pochi record esemplificativi. 4.Esegui operazioni di aggiornamento, modifica ed eliminazione record create database*/

create database Anagrafiche_Azienda;
use Anagrafiche_Azienda;

-- Creazione Tabelle
create table Store (
ID_Store int
, Nome_Store varchar(50)
, Città varchar(50)
, ID_Città int(50)
, Regione varchar(50)
, ID_Regione int
, Data_Apertura date
, constraint PK_Store primary key (ID_Store)
, constraint FK_Città_Store foreign key (ID_Città) references AreaGeografica (ID_Città)
);
create Table AreaGeografica (
ID_Città int
, Città varchar(50)
, ID_Regione int
, Regione varchar(50)
, constraint PK_Città_Area_Geografica primary key (ID_Città)
);
-- Popolamento Tabelle
insert into Store values
(1, "Baggiano", "Bronte", 1, "Sicilia", 1, '2020-01-01'),
(2, "Riccardo", "Roma", 2, "Lazio", 2, '2021-01-01'),
(3, "Doppio Passo", "Milano", 3 , "Lombardia", 3 ,'2022-01-01'),
(4, "Mister Ric", "Firenze", 4, "Toscana", 4, '2023-01-01'),
(5, "OffBall", "New York", 5, "America", 5, '2024-01-01');
insert into AreaGeografica values
(1, "Bronte", 3, "Sicilia"),
(2, "Roma", 2 ,"Lazio"),
(3, "Milano", 3, "Lombardia"),
(4,"Firenze", 4, "Toscana"),
(5, "New York", 5, "America");

select *
from AreaGeografica;
select *
from Store;

-- Aggiornamento e modifica record
SET SQL_SAFE_UPDATES = 0;
Start transaction;
update AreaGeografica
set ID_Regione = 1
where Città = 'Bronte' and Regione = 'Sicilia';

select *
from AreaGeografica
Rollback;                                    /*Check modifica*/

Start transaction;
update AreaGeografica
set ID_Regione = 1
where Città = 'Bronte' and Regione = 'Sicilia';
Commit;             /*Covalida modifica*/

 -- Elimanzione Record
Start transaction;
Delete from Store
where ID_Città = 4;

select *
from Store
Rollback;                  /*Check eliminazione*/

 Start transaction;
Delete from Store
where ID_Città = 4;

select *
from Store
Commit;                   /*Convalida eliminazione*/