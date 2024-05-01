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