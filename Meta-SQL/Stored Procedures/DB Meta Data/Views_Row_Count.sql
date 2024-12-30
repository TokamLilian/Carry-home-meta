DECLARE @DatabaseName NVARCHAR(255)
DECLARE @SQL NVARCHAR(MAX)

DECLARE db_cursor CURSOR FOR
SELECT name
FROM sys.databases
WHERE state_desc = 'ONLINE' 
    AND name NOT IN ('master', 'tempdb', 'model', 'msdb', 'SSISDB')

OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @DatabaseName

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = '
        USE [' + @DatabaseName + '];
        
        -- Create temp table to save results
		CREATE TABLE #ViewRecordCount (
		    SchemaName NVARCHAR(128),
		    ViewName NVARCHAR(128),
		    RecordCount INT
		);
		
		-- Loop through each view and get the RecordCount
		DECLARE @viewFullName NVARCHAR(258);
		DECLARE @schemaName NVARCHAR(128);
		DECLARE @viewName NVARCHAR(128);
		DECLARE viewCursor CURSOR FOR
		SELECT QUOTENAME(s.name) + ''.'' + QUOTENAME(v.name) AS FullViewName,
		       s.name AS SchemaName,
		       v.name AS ViewName
		FROM sys.views v
		INNER JOIN sys.schemas s ON v.schema_id = s.schema_id;
		
		OPEN viewCursor;
		FETCH NEXT FROM viewCursor INTO @viewFullName, @schemaName, @viewName;
		WHILE @@FETCH_STATUS = 0
		BEGIN
		    DECLARE @sql NVARCHAR(MAX);
		    SET @sql = N''INSERT INTO #ViewRecordCount (SchemaName, ViewName, RecordCount) '' +
		               N''SELECT N'''''' + @schemaName + '''''', N'''''' + @viewName + '''''', COUNT(*) FROM '' + @viewFullName;
		
		    EXEC sp_executesql @sql;
		
		    FETCH NEXT FROM viewCursor INTO @viewFullName, @schemaName, @viewName;
		END
		
		CLOSE viewCursor;
		DEALLOCATE viewCursor;
        
        -- Query to get RecordCount and ColumnCount
        INSERT INTO [Carry_Home_Meta].[powerbi].[AboutViews] (SchemaName, View_Name, Number_of_Lines, LOAD_DATE)
        SELECT SchemaName, ViewName, RecordCount, SYSDATETIME()
        FROM #ViewRecordCount;
        
        DROP TABLE #ViewRecordCount;
    '
    EXEC sp_executesql @SQL

    FETCH NEXT FROM db_cursor INTO @DatabaseName
END

CLOSE db_cursor
DEALLOCATE db_cursor