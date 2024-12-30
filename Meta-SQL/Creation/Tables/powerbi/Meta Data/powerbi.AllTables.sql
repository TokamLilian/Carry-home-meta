CREATE TABLE powerbi.AllTables(
	DatabaseName sysname NOT NULL
	,SchemaName sysname NOT NULL
	,Table_Id sysname NOT NULL
	,Table_Name sysname NOT NULL
	--,Databse_Id INT NOT NULL
	--,Is_Read_Only VARCHAR (100)
	,LOAD_DATE DATETIME
)