-- create table and load data --
CREATE DATABASE snp500
GO


BULK INSERT CompanyBySector
FROM 'C:\Users\jki\Downloads\1.1 snp500-company-by-sector.csv.csv' 
WITH
(
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n',
TABLOCK
)
GO

-- Get the number of companies per sector
SELECT  Sector, COUNT(*) AS Number
  FROM [snp500].[dbo].[CompanyBySector]
  GROUP BY Sector
  GO

-- Get the highest stock Price 
 SELECT MAX(StockPrice) AS Highest_Stock_Price
  FROM [snp500].[dbo].[CompanyBySector]
  GO


-- get the lowest stock price
SELECT MIN(StockPrice) AS Lowest_Stock_Price
  FROM [snp500].[dbo].[CompanyBySector]
  GO
  

  -- Get the Minimum and maximum stock rice in each sector
  
SELECT Sector,MIN(StockPrice) AS MinStockPrice,MAX(StockPrice) as StockPrice
  FROM [snp500].[dbo].[CompanyBySector]
  GROUP BY Sector
  GO

-- Get the stock price above above 100 in the nformation technology sector
SELECT *
  FROM [snp500].[dbo].[CompanyBySector]
  WHERE 
  StockPrice >1000
  AND
  Sector = 'Information Technology'
  GO

  SELECT TOP (1000) [Ticker]
      ,[CompanyName]
      ,[Sector]
      ,[StockPrice]
  FROM [snp500].[dbo].[CompanyBySector]

  CREATE TABLE tableA_CompanyStockPrices
  (Ticker varchar(5)
  ,stockPrice decimal(6,2)
  )
  GO



  INSERT INTO tableA_CompanyStockPrices VALUES('AMZN',350.5)
    INSERT INTO tableA_CompanyStockPrices VALUES('BBY',350.5)
	  INSERT INTO tableA_CompanyStockPrices VALUES('CMCA',350.5)
	    INSERT INTO tableA_CompanyStockPrices VALUES('DG',350.5)
		GO


		CREATE TABLE tableB_CompanyNames
		(Ticker varchar(5)
		,CompanyName varchar(50)
		)
		GO
		
  INSERT INTO tableB_CompanyNames VALUES('AMZN','Amazon.com')
    INSERT INTO tableB_CompanyNames  VALUES('BBY','Best Buy Co.Ic')
	  INSERT INTO tableB_CompanyNames  VALUES('CMCA','Comcast Corp')
	    INSERT INTO tableB_CompanyNames  VALUES('DG','Ford Motor')
		GO


    CREATE TABLE tableA_Stocks
(CompanyName varchar(50)
, stockPrice decimal(6,2)
)
GO

INSERT INTO tableA_Stocks VALUES ('Amazon.com Inc',350.5)
INSERT INTO tableA_Stocks VALUES ('Best Buy Co.Inc',68.79)
INSERT INTO tableA_Stocks VALUES ('Comcast Corp',38.19)
GO

CREATE TABLE tableB_Stocks
(CompanyName varchar(50)
, stockPrice decimal(6,2)
)
GO

INSERT INTO tableB_Stocks VALUES ('Amazon.com Inc',350.5)
INSERT INTO tableB_Stocks VALUES ('Best Buy Co.Inc',68.79)
INSERT INTO tableB_Stocks VALUES ('Ford Moor',10.43)
GO

SELECT * FROM tableA_Stocks
SELECT * FROM tableB_Stocks
GO

SELECT * FROM tableA_Stocks
UNION
SELECT * FROM tableB_Stocks
GO
-- GET ON SIMILAR
SELECT * FROM tableA_Stocks
INTERSECT
SELECT * FROM tableB_Stocks
GO

-- getting unique values
SELECT * FROM tableA_Stocks
EXCEPT
SELECT * FROM tableB_Stocks
GO