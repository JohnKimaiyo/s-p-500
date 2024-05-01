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
