CREATE VIEW [api].[api_Databases]
AS

WITH RankedDatabases AS (
    SELECT 
       [Databse_Id]
      ,[DatabseName]
      ,[Creation_Date]
      ,[Is_Read_Only]
      ,[LOAD_DATE]
      ,ROW_NUMBER() OVER (PARTITION BY DatabseName ORDER BY load_date DESC) AS rn
    FROM 
        powerbi.AllDatabases
)

SELECT 
    [Databse_Id]
    ,[DatabseName]
    ,[Creation_Date]
    ,[Is_Read_Only]
    ,[LOAD_DATE]
FROM 
	RankedDatabases
WHERE 
	rn = 1;

GO
