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