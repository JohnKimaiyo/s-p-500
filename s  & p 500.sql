-- create table and load data --
CREATE DATABASE snp500
GO


CREATE TABLE CompanyBySector
(Ticker varchar(5)
,CompanyName varchar (50)
,Sector varchar(50)
,StockPrice decimal(6,2)
)
GO