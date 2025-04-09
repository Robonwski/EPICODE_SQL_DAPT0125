/*Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria.
(DimProduct, DimProductSubcategory, DimProductCategory).*/
select ProductKey as Codice_Prodotto
, EnglishProductName as Nome_Prodotto
, SC.EnglishProductSubcategoryName as Nome_SottoCategoria
, SC.ProductSubcategoryAlternateKey as Codice_SottoCategoria
, C.EnglishProductCategoryName as Nome_Categoria
, C.ProductCategoryKey as Codice_Categoria
from dimproduct as P inner join dimproductsubcategory as SC
on P.ProductSubcategoryKey = SC.ProductSubcategoryKey
inner join dimproductcategory as C
on SC.ProductCategoryKey = C.ProductCategoryKey;

/*Esponi lʼelenco dei soli prodotti venduti (DimProduct, FactResellerSales)*/
-- Con Query
select ProductKey as Codice_Prodotto
, EnglishProductName as Nome
from dimproduct
where ProductKey in (select ProductKey
from factresellersales);
/*or ProductKey in (select ProductKey
from factinternetsales)*/
-- Con Join
select distinct P.ProductKey as Codice_Prodotto
, P.EnglishProductName as Nome_Prodotto
from dimproduct as P
inner join factresellersales as RS
on P.ProductKey = RS.ProductKey;

/*Esponi lʼelenco dei prodotti non venduti 
(considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1)*/
-- Versione Con Query
select ProductKey as Codice_Prodotto
, EnglishProductName as Nome
from dimproduct
where ProductKey not in (select ProductKey
from factresellersales)
/*union 
select ProductKey
from factinternetsales)*/
and FinishedGoodsFlag = 1;
-- Versione con Left Join
select distinct P.ProductKey as Codice_Prodotto
, P.EnglishProductName as Nome_Prodotto
from dimproduct as P
left join factresellersales as RS
on P.ProductKey = RS.ProductKey
where RS.ProductKey is null
and P.FinishedGoodsFlag = 1;

/*Esponi lʼelenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct)*/

select SalesOrderNumber as Numero_Ordine
, SalesOrderLineNumber as Numero_Linea_Ordine
, P.ProductKey as Codice_Prodotto
, P.EnglishProductName as Nome_Prodotto
from factresellersales as RS
inner join dimproduct as P
on RS.ProductKey = P.ProductKey;

/*Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto*/

select RS.SalesOrderNumber as Numero_Ordine
, RS.SalesOrderLineNumber as Numero_Linea_Ordine
, P.EnglishProductName as Nome_Prodotto
, C.EnglishProductCategoryName as Nome_Categoria
from factresellersales as RS
inner join dimproduct as P
on RS.ProductKey = P.ProductKey
inner join dimproductsubcategory as SC
on P.ProductSubcategoryKey = SC.ProductSubcategoryKey
inner join dimproductcategory as C
on SC.ProductCategoryKey = C.ProductCategoryKey;

/*Esponi in output lʼelenco dei reseller (DimReseller) indicando anche la sua area geografica*/

select R.ResellerKey as Codice
, R.ResellerName as Nome
, G.City as Città
, G.EnglishCountryRegionName as Area
from dimreseller as R
inner join dimgeography as G
on R.GeographyKey = G.GeographyKey;

-- SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e lʼarea geografica.
select RS.SalesOrderNumber as Numero_Ordine
, RS.SalesOrderLineNumber as Numero_Linea_Ordine
, RS.OrderDate as Data_Ordine
, RS.UnitPrice as Prezzo_unitario
, RS.OrderQuantity as Quantità
, RS.TotalProductCost as Costo_Totale_Prodotto
, P.EnglishProductName as Nome_Prodotto
, C.EnglishProductCategoryName as Categoria_Prodotto
, RES.ResellerName as Nome_Reseller
, G.City as Città
, G.EnglishCountryRegionName as Regione
from factresellersales as RS inner join dimproduct as P
on RS.ProductKey = P.ProductKey inner join dimproductsubcategory as SC
on P.ProductSubcategoryKey = SC.ProductSubcategoryKey inner join dimproductcategory as C
on SC.ProductCategoryKey = C.ProductCategoryKey inner join dimreseller as RES
on RS.ResellerKey = RES.ResellerKey inner join dimgeography as G
on RES.GeographyKey = G.GeographyKey;
-- where year (RS.OrderDate) between 2019 and 2020; Funzione per filtrare anni