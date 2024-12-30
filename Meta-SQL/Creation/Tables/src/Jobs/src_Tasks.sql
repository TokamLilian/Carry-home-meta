CREATE TABLE src.Tasks (		-- Table of all existing tasks (steps) per SSIS job
	Step_Id INT PRIMARY KEY
	,Step_Name VARCHAR (200) NOT NULL
	,Job_Id INT NOT NULL 
	--,Job_Name VARCHAR (200) NOT NULL
	,Job_Step_Id INT NOT NULL
	,DatabaseName VARCHAR (200)
	,LOAD_DATE DATETIME
)