CREATE TABLE powerbi.Schedules (		-- Table of all existing schedules per SSIS job
	Schedule_Id INT
	--,Step_Name VARCHAR (200) NOT NULL
	,Job_Id uniqueidentifier
	--,Job_Name VARCHAR (200) NOT NULL
	,Next_Run_Date INT
	,Next_Run_Time INT
	,LOAD_DATE DATETIME
)