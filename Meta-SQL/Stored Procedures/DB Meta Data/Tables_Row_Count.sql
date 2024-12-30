CREATE PROCEDURE powerbi.InsertTablesRowsCounts
AS
BEGIN

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
            INSERT INTO Carry_Home_Meta.powerbi.AboutTables (Table_Id, Table_Name, Number_of_Lines, Allocated_Space_KB, Used_Space_KB, Remaining_Space_KB, LOAD_DATE)
            SELECT 
                t.object_id AS Table_Id,
                t.name AS TableName,
                p.rows AS RowCounts,
                SUM(a.total_pages) * 8 AS Allocated_Space_KB,
                SUM(a.used_pages) * 8 AS Used_Space_KB,
                (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS Remaining_Space_KB,
                SYSDATETIME() AS LoadDate
            FROM ' + @DatabaseName + '.sys.tables t
            INNER JOIN ' + @DatabaseName + '.sys.indexes i ON t.OBJECT_ID = i.object_id
            INNER JOIN ' + @DatabaseName + '.sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
            INNER JOIN ' + @DatabaseName + '.sys.allocation_units a ON p.partition_id = a.container_id
            LEFT OUTER JOIN ' + @DatabaseName + '.sys.schemas s ON t.schema_id = s.schema_id
            WHERE t.NAME NOT LIKE ''dt%'' 
                AND t.is_ms_shipped = 0
                AND i.OBJECT_ID > 255 
            GROUP BY 
                t.object_id, t.name, s.name, p.Rows
        '

        EXEC sp_executesql @SQL

        FETCH NEXT FROM db_cursor INTO @DatabaseName
    END

    CLOSE db_cursor
    DEALLOCATE db_cursor

END;
