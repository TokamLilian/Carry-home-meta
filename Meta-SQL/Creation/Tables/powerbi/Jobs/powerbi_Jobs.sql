CREATE TABLE powerbi.Jobs (		-- Table of all existing SSIS jobs on the database
	Job_Id uniqueidentifier NOT NULL
	,Job_Name VARCHAR (200) NOT NULL
	,Sever_Id INT  NOT NULL
	,Is_Enabled INT
	,Described VARCHAR (355)
	,Category INT
	,Start_Step_Id INT
	,Date_Created DATETIME
	,Date_Modified DATETIME
	,Number_of_Versions INT
	,LOAD_DATE DATETIME
)