CREATE TABLE src.Executions (		-- Table of all SSIS job runs
	Execution_Id INT PRIMARY KEY
	,DatabaseName VARCHAR (200)
	,Job_Id INT NOT NULL 
	--,Job_Name VARCHAR (200) NOT NULL
	,Start_Id INT NOT NULL
	,Announcement VARCHAR (MAX)
	,Succes VARCHAR (100)
	,LOAD_DATE DATETIME
)