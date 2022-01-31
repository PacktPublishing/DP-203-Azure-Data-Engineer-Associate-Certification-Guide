-- Creating statistics for Synapse serverless pools
-- We will first create an external table and then create statistics for that table.

-- The concept of statistics is the same for dedicated and serverless pools. 
-- In case of serverless pools the auto-creation of statistics is turned on by default for Parquet files but not for CSV files. 
-- Since we deal with external tables in serverless pools, we will have to create statistics for external tables. 

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'Dp203ParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [Dp203ParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'Dp203DataSource') 
	CREATE EXTERNAL DATA SOURCE [Dp203DataSource] 
	WITH (
		LOCATION = '<INSERT abfss:// DATA SOURCE LOCATION>' 
	)
GO

-- Here we are assuming that the Parquet files are present under parquet/trips folder
CREATE EXTERNAL TABLE TripsExtTable (
	[tripsId] nvarchar(100),
	[driverId] nvarchar(100),
	[customerId] nvarchar(100),
	[cabId] nvarchar(100),
	[tripDate] nvarchar(100),
	[startLocation] nvarchar(100),
	[endLocation] nvarchar(100)
	)
	WITH (
	LOCATION = 'parquet/trips/**',
	DATA_SOURCE = [Dp203DataSource],
	FILE_FORMAT = [Dp203ParquetFormat]
	)
GO


SELECT TOP 100 * FROM dbo.TripsExtTable
GO

-- Now that we have the table, let us create stats on the tripsId column:

CREATE STATISTICS TripStats
ON dbo.TripsExtTable ( tripsId )
    WITH FULLSCAN

GO
