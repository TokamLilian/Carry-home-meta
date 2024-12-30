CREATE VIEW [api].[api_Tables]
AS

WITH RankedTables AS (
    SELECT 
        [DatabaseName]
      ,[SchemaName]
      ,[Table_Id]
      ,[Table_Name]
      ,[LOAD_DATE]
      ,ROW_NUMBER() OVER (PARTITION BY DatabaseName, SchemaName, Table_Name ORDER BY LOAD_DATE DESC) AS rn
    FROM 
        powerbi.AllTables
)

SELECT 
    DatabaseName
    ,SchemaName
    ,Table_Id
    ,Table_Name
    ,LOAD_DATE
FROM 
	RankedTables
WHERE 
	rn = 1;

GO
