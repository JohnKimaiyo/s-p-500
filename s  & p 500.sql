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

-- get the average stock price oer sector
SELECT Sector, AVG(StockPrice) AS StockAverage
 FROM [snp500].[dbo].[CompanyBySector]
GROUP BY Sector
GO

--get the average stock price per sector above 100 stoc price
SELECT Sector, AVG(StockPrice) AS StockAverage
FROM [snp500].[dbo].[CompanyBySector]
GROUP BY Sector
HAVING AVG(StockPrice) >100
ORDER BY StockAverage ASC
GO

--  getting average stock price by sector along side the company name--
SELECT CompanyName,StockPrice, Sector, AVG(StockPrice) OVER (PARTITION BY Sector) AS AverageStockPrice
FROM [snp500].[dbo].[CompanyBySector]
GO

-- get the number of comapny  per sector in descending order
SELECT DISTINCT Sector, COUNT(CompanyName) OVER (PARTITION BY Sector) AS CompanyCount
FROM [snp500].[dbo].[CompanyBySector]
ORDER BY CompanyCount DESC
GO

-- rank  the comapnies by  stock price  and indicate stock price--
SELECT CompanyName, StockPrice,Sector,RANK() OVER (PARTITION BY Sector ORDER BY StockPrice) AS StockPriceRank
FROM [snp500].[dbo].[CompanyBySector]

GO
-- row number--
SELECT CompanyName, StockPrice,Sector,ROW_NUMBER() OVER (PARTITION BY Sector ORDER BY StockPrice) AS StockPriceRank
FROM [snp500].[dbo].[CompanyBySector]
GO

-- ntile--
SELECT CompanyName, StockPrice,Sector,NTILE(4) OVER (PARTITION BY Sector ORDER BY StockPrice) AS StockPriceTile
FROM [snp500].[dbo].[CompanyBySector]
GO

--  dataes---
CREATE TABLE DateRecords
(RowDateRecord varchar(max))
GO

INSERT INTO DateRecords VALUES ('1/27/2018')
INSERT INTO DateRecords VALUES ('2018-01-27')
INSERT INTO DateRecords VALUES ('27-Jan-18')
INSERT INTO DateRecords VALUES ('27-Jan-2018')
INSERT INTO DateRecords VALUES ('January 27,2018')
INSERT INTO DateRecords VALUES ('Saturday,January 27,2018')
INSERT INTO DateRecords VALUES ('1/27/18 12:00 AM')
INSERT INTO DateRecords VALUES ('27 tammikuuta 2018 0:00')
GO


SELECT RowDateRecord
,TRY_CAST(RowDateRecord AS date) AS DateCAST
,TRY_CONVERT(date,RowDateRecord) AS DateCONVERT
,TRY_PARSE(RowDateRecord AS date) AS DateParse
FROM DateRecords

CREATE TABLE TimeRecords
(record varchar(max))
GO

INSERT INTO TimeRecords VALUES ('09:01:03')
INSERT INTO TimeRecords VALUES ('17:15:00')
INSERT INTO TimeRecords VALUES ('11:45:24')
GO
SELECT DATEPART(hour,TRY_PARSE(record as time))AS hours
		,DATEPART(minute,TRY_PARSE(record as time)) AS minutes
		,DATEPART(minute,TRY_PARSE(record as time)) AS seconds
FROM TimeRecords
GO


-- mathematical operations -- 
SELECT RAND(100) AS Random_numner_with_seed_100
SELECT RAND() Random_number_with_random_random_seed
GO

SELECT EXP(10) AS Exponent_of_10
SELECT SQRT(4) AS Square_root_of_4
SELECT SQUARE(2) AS Square_of_2
SELECT POWER(4,0.5) AS Number_4_in_power_of_o_point_s
SELECT POWER(2,2) AS Number_2_in_power_of_2
GO

SELECT LOG(22026.465890) AS Natural_Logarithm
SELECT LOG10(100) AS Base_10_logarithm
GO


DECLARE @KidAges table
(age int
,name varchar(max)
)

INSERT INTO @KidAges VALUES(10,'any')
INSERT INTO @KidAges VALUES(12,'krista')
INSERT INTO @KidAges VALUES(14,'email')

DECLARE @email_age int

SET @email_age = (SELECT age FROM @kidAges WHERE name = 'email')

SELECT @email_age
SELECT * FROM @kidAges
GO