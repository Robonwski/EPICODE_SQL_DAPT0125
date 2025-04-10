CREATE VIEW VIEW_PRODUCT AS
(SELECT
P.EnglishProductName as Nome_Prodotto
, P.ProductKey as Codice_Prodotto
,SC.EnglishProductSubcategoryName as Nome_SottoCategoria
,C.EnglishProductCategoryName as Nome_Categoria
FROM dimproduct AS P
JOIN dimproductsubcategory AS SC
ON P.ProductSubcategoryKey = SC.ProductSubcategoryKey
JOIN dimproductcategory AS C
ON SC.ProductCategoryKey = C.ProductCategoryKey
);

select *
from VIEW_PRODUCT;

/*Implementa una vista denominata Reseller al fine di creare unʼanagrafica (dimensione) reseller completa. La vista, 
se interrogata o utilizzata come sorgente dati, deve esporre il nome del reseller, il nome della città e il nome della regione*/

Create view VIEW_RESELLER as
(select R.ResellerKey as Codice_Reseller
, R.ResellerName as Nome_reseller
, R.BusinessType as Tipo_Business
, G.City as Città
, sum(RS.SalesAmount) as Somma_Vendite
, G.EnglishCountryRegionName as Nome_Regione
, G.StateProvinceName as Area
from dimreseller as R
inner join dimgeography as G
on R.GeographyKey = G.GeographyKey
inner join factresellersales as RS
on R.ResellerKey = RS.ResellerKey
group by R.ResellerKey
);

select *
from VIEW_RESELLER;

/*Crea una vista denominata Sales che deve restituire la data dellʼordine, il codice documento,
la riga di corpo del documento, la quantità venduta, lʼimporto totale e il profitto*/

create view VIEW_SALES as
(select SalesOrderNumber as Codice_Documeto
, RS.SalesOrderLineNumber as Riga_Corpo_Documento
, P.ProductKey as Codice_Prodotto
, P.EnglishProductName as Nome
, RS.ResellerKey as Codice_Reseller
, RS.OrderQuantity as Quanità_Venduta
, (RS.SalesAmount - RS.TotalProductCost) as Profitto
from factresellersales as RS
inner join dimproduct as P
on RS.ProductKey = P.ProductKey
);
select *
from VIEW_SALES