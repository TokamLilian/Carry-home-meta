CREATE TABLE powerbi.Executions (		-- Table of all SSIS job runs
	Execution_Id INT PRIMARY KEY
	,Job_Id uniqueidentifier NOT NULL 
	--,DatabaseName VARCHAR (200)
	--,Job_Name VARCHAR (200) NOT NULL
	,Step_Id INT NOT NULL
    ,Step_Name sysname NOT NULL
	,Announcement NVARCHAR (MAX)
	,Execution_Status VARCHAR (100)
    ,Execution_Date INT
    ,Time_of_Execution INT
    ,Execution_Duration_MS INT
    ,Number_of_retries INT
	,LOAD_DATE DATETIME
)