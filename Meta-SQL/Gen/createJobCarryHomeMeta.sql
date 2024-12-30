USE SSISDB;
GO

DECLARE @EnvironmentName NVARCHAR(255) = N'DEV';
DECLARE @FolderName NVARCHAR(255) = N'CarryHomeMeta';
DECLARE @VariableName NVARCHAR(255) = N'ConnectionString'; 

BEGIN TRY
    -- Check if the folder exists
    IF NOT EXISTS (
        SELECT 1
        FROM catalog.folders AS f
        WHERE f.name = @FolderName
    )
    BEGIN
        RETURN;
    END

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
END TRY
BEGIN CATCH
    -- Handle errors if any occur during the process
    PRINT 'An error occurred: ' + ERROR_MESSAGE();
    -- Optionally, you can log the error or perform additional error handling here.
END CATCH
GO

----

USE msdb;
GO

-- Check if the job already exists, and drop it if necessary
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs WHERE name = N'Carry_home_meta_etl')
BEGIN
    EXEC sp_delete_job @job_name = N'Carry_home_meta_etl';
END
GO

-- Create the SQL Server Agent Job
EXEC sp_add_job
    @job_name = N'Carry_home_meta_etl', -- Name of the job
    @enabled = 1,                  -- Enable the job
    @description = N'Automated job created during Visual Studio deployment.',
    @start_step_id = 1,            -- Specify the starting step ID
    @category_name = N'Data collector'; -- Specify the category
GO

-- steps
EXEC sp_add_jobstep
    @job_name = N'Carry_home_meta_etl',
    @step_name = N'1_Jobs_Transform_and_load',
    @subsystem = N'SSIS',
    @command = N'/IS "\SSISDB\CarryHomeMeta\Meta-SSIS\Jobs Transform-Load.dtsx" /SERVER . /CHECKPOINTING OFF /REPORTING E',
    @retry_attempts = 3,
    @retry_interval = 5,
    @database_name = N'msdb',
    @on_success_action = 3, -- Proceed to the next step even if the current step fails
    @on_fail_action = 3;
    
GO

EXEC sp_add_jobstep
    @job_name = N'Carry_home_meta_etl',
    @step_name = N'2_Meta_data_transform_and_load',
    @subsystem = N'SSIS',
    @command = N'/IS "\SSISDB\CarryHomeMeta\Meta-SSIS\Meta data Transform-load.dtsx" /SERVER . /CHECKPOINTING OFF /REPORTING E',
    @retry_attempts = 3,
    @retry_interval = 5,
    @database_name = N'msdb',
    @on_success_action = 1, -- exit with success
    @on_fail_action = 2;
    
GO

-- Set the schedule for the job
EXEC sp_add_jobschedule
    @job_name = N'Carry_home_meta_etl',
    @name = N'DailySchedule',          -- Schedule name
    @freq_type = 4,                    -- Frequency type (4 = Daily)
    @freq_interval = 1,                -- Every 1 day
    @active_start_time = 060000;       -- Start time in HHMMSS format (9:00 AM)
GO

-- Add the job to a specific target (SQL Server Agent server)
EXEC sp_add_jobserver
    @job_name = N'Carry_home_meta_etl',
    @server_name = N'(local)' ;         -- Target server name (use "(local)" for current instance)
GO
