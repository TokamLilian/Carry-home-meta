CREATE TABLE powerbi.AboutTables(
	Table_Id INT NOT NULL
	,Table_Name VARCHAR (100) NOT NULL
	--,Databse_Id INT NOT NULL
	--,DatabaseName VARCHAR (100) NOT NULL
	--,Number_of_Columns INT NOT NULL
	,Number_of_Lines INT
	,Allocated_Space_KB INT
	,Used_Space_KB INT
	,Remaining_Space_KB INT
	,LOAD_DATE DATETIME
)