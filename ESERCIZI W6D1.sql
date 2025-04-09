/*Interroga la tabella dei prodotti (DimProduct) ed esponi in output i campi ProductKey, ProductAlternateKey, 
EnglishProductName, Color, StandardCost, FinishedGoodsFlag. assegna un alias se lo ritieni opportuno.*/
select ProductKey as Codice_Prodotto
, ProductAlternateKey as Codice_Alternativo
, EnglishProductName as Nome_Prodotto
, Color as Colore
, StandardCost as Costo_Standard
, FinishedGoodsFlag as Prodotto_Finito
from dimproduct;
/*Partendo dalla query scritta nel passaggio precedente, esponi in output i 
soli prodotti finiti cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1.*/
select ProductKey as Codice_Prodotto
, ProductAlternateKey as Codice_Alternativo
, EnglishProductName as Nome_Prodotto
, Color as Colore
, StandardCost as Costo_Standard
, FinishedGoodsFlag as Prodotto_Finito
from dimproduct
where FinishedGoodsFlag = 1;
/*Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello (ProductAlternateKey) 
comincia con FR oppure BK. Il result set deve contenere il codice prodotto (ProductKey), il modello, il nome del prodotto,
il costo standard (StandardCost) e il prezzo di listino (ListPrice)*/
select ProductKey as Codice_Prodotto
, ProductAlternateKey as Codice_Alternativo
, ModelName as Modello
, EnglishProductName as Nome_Prodotto
, StandardCost as Costo_Standard
, ListPrice as Prezzo_listino
from dimproduct
where ProductAlternateKey like "FR%"
or ProductAlternateKey like "BK%";
-- Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dallʼazienda (ListPrice - StandardCost)
select ProductKey as Codice_Prodotto
, ProductAlternateKey as Codice_Alternativo
, ModelName as Modello
, EnglishProductName as Nome_Prodotto
, StandardCost as Costo_Standard
, ListPrice as Prezzo_listino
, (ListPrice - StandardCost) as Markup
from dimproduct
where ProductAlternateKey like "FR%"
or ProductAlternateKey like "BK%";
/*Esponi, interrogando la tabella degli impiegati aziendali, lʼelenco dei soli agenti. 
Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a 1.*/
select EmployeeKey as Codice_Dipendente
, FirstName as Nome
, LastName as Cognome
, Title as Titolo
, SalesPersonFlag as Agente
from dimemployee
where SalesPersonFlag = 1;
/*Interroga la tabella delle vendite (FactResellerSales). Esponi in output lʼelenco delle transazioni 
registrate a partire dal 1 gennaio 2020 dei soli codici prodotto: 597, 598, 477, 214. Calcola per ciascuna 
transazione il profitto (SalesAmount - TotalProductCost)*/
select SalesOrderNumber as Numero_Ordine
, SalesOrderLineNumber as Numero_Linea_Ordine
, ProductKey as Codice_Prodotto
, OrderDate as Data_Ordine
, (SalesAmount - TotalProductCost) as Profitto
from factresellersales
where ProductKey in (597,598,477,214)
and OrderDate >= "2020-01-01";