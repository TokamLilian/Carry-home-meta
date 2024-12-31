# Power BI Dashboard for Tracking SSIS Metadata and Executions on SQL Server 

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Prerequisites](#prerequisites)
4. [Installation and setup](#installation-and-setup)
5. [Repository Contents](#repository-contents)
6. [Contributing](#contributing)

## Overview  

This project delivers a comprehensive Power BI dashboard designed to monitor and analyze SSIS (SQL Server Integration Services) executions and metadata. By leveraging dynamic SQL and querying the SSISDB and msdb system databases in Microsoft SQL Server, this solution offers valuable insights into package execution details, historical trends, and performance optimization opportunities.  

The primary goal is to provide data engineers, analysts, and stakeholders with a user-friendly visualization tool to track SSIS performance, troubleshoot issues, and enhance workflows.  

---

## Features  

- **SSIS Package Execution Monitoring**: Track execution success, failure, and duration trends.  
- **Historical Analysis**: Visualize package performance over time for optimization.  
- **Metadata Insights**: Gain visibility into deployed packages and configurations.  
- **Customizable Dashboards**: Easily adapt the Power BI report to your unique environment.  

---

## Prerequisites  

To run this project, ensure you have the following tools and configurations:  

1. **Microsoft SQL Server**: The SSISDB and msdb databases should be enabled and populated with execution data.  
2. **Power BI Desktop**: To open and edit the report template.  
3. **SQL Management Studio (SSMS)**: To execute SQL queries and prepare the data sources using SQL Server agent.  
4. **Access to SSISDB and msdb**: Required permissions for querying system databases and make sure SSISDB catalog is operational.  

---

## Installation and Setup  

Follow these steps to set up and run the Power BI dashboard:  

### Step 1: Clone the Repository  
```bash  
git clone https://github.com/TokamLilian/Carry-home-meta.git
```

### Step 2: Prepare the SQL Server Environment  

1. **Validate Access**: Ensure Integration Catalog exists you have read access to the `SSISDB` and `msdb` databases.  
   - You must have access to execute queries on both of these system databases.  

2. **Publish the SQL Scripts**:  
   - In `Integration Services Catalogs`, deploy the SSIS packages under the folder `CarryHomeMeta` (spelling super important).  
   - Open and publish the provided SQL directory using loaded profile (publish scipt) `Meta-SQL.publish.xml` from solution `Carry-Home-Meta.sln` in Microsoft Visual Studio or similar application.  

3. **Verify deployed files**:
    - Verify that the SSIS packages are deployed in the SSIS catalog.
    - Check the environment `DEV` in SSIS project directory.
    - Ensure that database `Carry_home_meta` contains required tables.
    - Check the database `Carry_home_meta_etl` is created and steps have no errors.
    - Verify that the SQL Server Agent is running and configured to execute the SSIS packages.

### Step 3: Configure Power BI  

1. **Open the Power BI Template**:  
   - Launch Power BI Desktop.  
   - Open the provided template `.pbit` file located in the repository folder `Power-BI`.  

2. **Set Up Data Connections**:  
   - In Power BI, click `Home` -> `Transform Data` -> `Data Source Settings`.  
   - Update the connection string to point to your SQL Server instance where SSISDB and msdb reside.  
   - Ensure you use the correct credentials to authenticate your connection.  

   Example of connection string:

   ```plaintext
   Server=your_sql_server;Database=SSISDB;User Id=your_user;Password=your_password;
   ```

### Step 4: Customize the Dashboard  

- Adjust the existing visualizations based on your business needs:
  - **Filters**: Modify filters to show data relevant to specific packages, time periods, or execution statuses.
  - **Measures**: Create new measures or calculated columns to aggregate the data in different ways.
  - **Visuals**: You can change charts, tables, and other visuals based on your preferences, or add new visuals like bar charts, trend lines, or KPIs to show the data more effectively.
  
---

## Repository Contents  

- **SQL Scripts**:  
```markdown

Exploit-my-data/
|
├── Meta-SQL/
│   ├── Meta-SQL.dbmdl
│   ├── Meta-SQL.jfm
│   ├── Meta-SQL.publish.xml
│   ├── Meta-SQL.sqlproj
│   ├── Meta-SQL.sqlproj.user
│   
│   ├── Creation/
│       ├── Schemas/
|           ├── api.sql
|           ├── powerbi.sql
|           ├── src.sql
|           ├── stg.sql
|
│       ├── Tables/
|           ├── powerbi/
|               ├── Jobs/
|                   ├── powerbi_Executions.sql
|                   ├── powerbi_Jobs.sql
|                   ├── powerbi_Schedule.sql
|               ├── Meta Data/
|                   ├── powerbi.AboutTables.sql
|                   ├── powerbi.AboutViews.sql
|                   ├── powerbi.AllColumns.sql
|                   ├── powerbi.AllTables.sql
|                   ├── powerbi.AllViews.sql
|                   ├── powerbi_AllDatabases.sql
|           ├── src/
|               ├── Jobs/
|                   ├── src_Executions.sql
|                   ├── src_Jobs.sql
|                   ├── src_Tasks.sql
|               ├── Meta Data/
|                   ├── src_AboutDatabases.sql
|                   ├── src_AboutTables.sql
|                   ├── src_AboutViews.sql
|                   ├── src_AllDatabases.sql
|                   ├── src_AllTables.sql
│       ├── Views/
|           ├── api_Databases.sql
|           ├── api_Jobs.sql
|           ├── api_Tables.sql
|
│   ├── Stored Procedures/
│       ├── DB Meta Data/
|           ├── Tables_Row_Count.sql
|           ├── Views_Row_Count.sql
|
│   ├── Gen/
│       ├── createEnvironmentC_H.sql
│       ├── createJobCarryHomeMeta.sql
|       
└── 
```

- **SSIS Packages**:
```markdown

│
├── EMD_SSIS/
│   ├── Jobs Extract.dtsx
│   ├── Jobs Trasnsform-load.dtsx
│   ├── Meta data Extract.dtsx
│   ├── Meta data Trasnsform-load.dtsx
│   ├── Meta_SSIS.database
│   ├── Meta_SSIS.dtproj
│   ├── Meta_SSIS.dtproj.user
│   ├── Project.params
|
└── 
```

- **Power BI Report**:  
  - `Databases Metadata.pbit`: Power BI report template that includes all default visualizations and queries.

## Contributing
Contributions are welcome! Feel free to submit pull requests for additional features, bug fixes, or improvements.

If you encounter any issues or have suggestions, please open an issue or reach out at tokamlilian@gmail.com
