/*Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria.
Quali considerazioni/ragionamenti è necessario che tu faccia?*/

select count(ProductKey) as Conteggio
, ProductKey as Codice_Prodotto
from dimproduct
group by ProductKey;
/* Per verificare che ProductKey sia una PK abbiamo 2 modi:
1. Verifica della collana Dimproduct nella Sezione SCHEMAS del Navigator (Menù a sinistra)
2. Eseguire un conteggio di ogni singolo valore e verifica che siano conteggiati una sola volta*/

/*Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK*/

select count(SalesOrderNumber)
, SalesOrderNumber as Numero_Ordine
, count(SalesOrderLineNumber)
, SalesOrderLineNumber as Numero_Linea_Ordine
from factresellersales
group by SalesOrderNumber, SalesOrderLineNumber;

/*Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020*/

select SalesOrderNumber as Numero_Ordine
, count(SalesOrderNumber)
from factresellersales
where OrderDate >= "2020-01-01"
group by SalesOrderNumber;

/*Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity)
e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) 
a partire dal 1 Gennaio 2020. Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, 
la quantità totale venduta e il prezzo medio di vendita. I campi in output devono essere parlanti!*/

select RS.ProductKey as Codice_Prodotto
, P.EnglishProductName as Nome_Prodotto
, sum(RS.SalesAmount) as Fatturato_Totale
, sum(OrderQuantity) as Quantità_Venduta
, avg(UnitPrice) as Prezzo_Vendita_Medio
from dimproduct as P
inner join factresellersales as RS
on P.ProductKey = RS.ProductKey
where RS.OrderDate >= "2020-01-01"
group by P.ProductKey;

/*Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (FactResellerSales.OrderQuantity) 
per Categoria prodotto (DimProductCategory). Il result set deve esporre pertanto il nome della categoria prodotto, 
il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti!*/

select C.EnglishProductCategoryName as Nome_Categoria
, sum(RS.SalesAmount) as Fatturato_Totale
, sum(OrderQuantity) as Quantità_Venduta
from dimproduct as P
inner join factresellersales as RS
on P.ProductKey = RS.ProductKey
inner join dimproductsubcategory as SC
on P.ProductSubcategoryKey = P.ProductSubcategoryKey
inner join dimproductcategory C
on SC.ProductCategoryKey = C.ProductCategoryKey
group by C.ProductCategoryKey;

/*Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. 
Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.*/

select sum(RS.SalesAmount) as Fatturato_Totale
, G.City as Città
from factresellersales as RS
inner join dimreseller as R
on RS.ResellerKey = R.ResellerKey
inner join dimgeography as G
on R.GeographyKey = G.GeographyKey
where RS.OrderDate >= "2020-01-01"
group by G.City
having sum(RS.SalesAmount) >= 60000;