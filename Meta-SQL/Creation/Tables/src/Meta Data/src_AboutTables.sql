CREATE TABLE src.AboutTables(
	Table_Id INT NOT NULL PRIMARY KEY
	--,Table_Name VARCHAR (100) NOT NULL
	--,Databse_Id INT NOT NULL
	--,DatabaseName VARCHAR (100) NOT NULL
	,Number_of_Columns INT NOT NULL
	,Number_of_Lines INT
	,LOAD_DATE DATETIME
)