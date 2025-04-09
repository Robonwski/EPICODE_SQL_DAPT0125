-- Creazione DB e uso Sistema Bancario
Create database Sistema_Bancario;
use Sistema_Bancario;

-- Creazione Tabelle
create table Cliente (
ID_Cliente int
, Nome varchar(50)
, Cognome varchar(50)
, constraint PK_Cliente primary key (ID_Cliente)
);
create table Transazioni (
ID_Transazioni int
, Tipo_Transazione varchar(50)
, Importo decimal (10,2)
, constraint PK_Transazioni primary key (ID_Transazioni)
);
create Table Filiale (
ID_Filiale int
, Nome_Filiale varchar(50)
, constraint PK_Filiali primary key (ID_Filiale)
);
create Table Prestiti (
ID_Prestito int
, Importo decimal(10,2)
, constraint PK_Prestiti primary key (ID_Prestito)
);
Create Table Account (
ID_Account int
, Username varchar(50)
, email varchar(50)
, ID_Cliente int
, ID_Transazioni int
, ID_Filiale int
, ID_Prestito int
, constraint PK_Account primary key (ID_Account)
, constraint FK_Cliente_Account foreign key (ID_Cliente) references Cliente (ID_Cliente)
, constraint FK_Transazioni_Account foreign key (ID_Transazioni) references Transazioni (ID_Transazioni)
, constraint FK_Filiale_Account foreign key (ID_Filiale) references Filiale (ID_Filiale)
, constraint FK_Prestiti_Account foreign key (ID_Prestito) references Prestiti (ID_Prestito)
);
-- Aggiunta Valori
insert into Cliente values
(1, "Lautaro", "Martinez"),
(2, "Francesco", "Totti"),
(3, "Giuseppe", "Mascara"),
(4, "Pippo", "Baudo"),
(5, "Chuck", "Norris");
insert into Transazioni values
(1, "Bonifico", 20.49),
(2, "giroconto", 1000.88),
(3, "Online", 283.56),
(4, "Mav", 273.85),
(5, "Assegno", 50000.57);
insert into Prestiti values
(1,38505.85),
(2, 57595.37),
(3, 78594.64),
(4, 57599.85),
(5, 367449.89);
insert into Filiale values
(1, "Banca A"),
(2, "Banca B"),
(3, "Banca C"),
(4, "Banca D"),
(5, "Banca E");
insert into Account values
(1, "Tizio1", "Tizio1@banca.it", 1, 1, 1, 1),
(2, "Tizio2", "Tizio2@banca.it", 2, 2, 2, 2),
(3, "Tizio3", "Tizio3@banca.it", 3, 3, 3, 3),
(4, "Tizio4", "Tizio4@banca.it", 4, 4, 4, 4),
(5, "Tizio5", "Tizio5@banca.it", 5, 5, 5, 5);
select *
From Account