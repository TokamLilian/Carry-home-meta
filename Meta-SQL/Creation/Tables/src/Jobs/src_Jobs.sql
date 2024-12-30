CREATE TABLE src.Jobs (		-- Table of all existing SSIS jobs on the database
	Job_Id INT NOT NULL PRIMARY KEY
	,Job_Name VARCHAR (200) NOT NULL
	,DatabaseName VARCHAR (200)
	,Start_Step_Id INT
	,LOAD_DATE DATETIME
)