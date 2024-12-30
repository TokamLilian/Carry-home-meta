CREATE VIEW [api].[api_Jobs]
AS

WITH RankedJobs AS (
    SELECT 
      [Job_Id]
      ,[Job_Name]
      ,[Sever_Id]
      ,[Is_Enabled]
      ,[Described]
      ,[Category]
      ,[Start_Step_Id]
      ,[Date_Created]
      ,[Date_Modified]
      ,[Number_of_Versions]
      ,[LOAD_DATE]
      ,ROW_NUMBER() OVER (PARTITION BY Job_Name ORDER BY load_date DESC) AS rn
    FROM 
        powerbi.Jobs
)

SELECT 
       [Job_Id]
      ,[Job_Name]
      ,[Sever_Id]
      ,[Is_Enabled]
      ,[Described]
      ,[Category]
      ,[Start_Step_Id]
      ,[Date_Created]
      ,[Date_Modified]
      ,[Number_of_Versions]
      ,[LOAD_DATE]
FROM 
	RankedJobs
WHERE 
	rn = 1;

GO
