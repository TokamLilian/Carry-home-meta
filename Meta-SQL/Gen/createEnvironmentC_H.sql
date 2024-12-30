USE SSISDB;
GO

DECLARE @EnvironmentName NVARCHAR(255) = N'DEV';
DECLARE @FolderName NVARCHAR(255) = N'CarryHomeMeta';
DECLARE @VariableName NVARCHAR(255) = N'ConnectionString'; 

-- Check if the environment already exists
IF NOT EXISTS (
    SELECT 1
    FROM catalog.environments AS env
    INNER JOIN catalog.folders AS f ON env.folder_id = f.folder_id
    WHERE env.name = @EnvironmentName -- Correct column name for environment
      AND f.name = @FolderName -- Correct column name for folder
)
BEGIN
    -- Create the environment in the specified project folder
    EXEC catalog.create_environment
        @environment_name = @EnvironmentName,
        @folder_name = @FolderName;
END
GO

DECLARE @environment_id INT;
