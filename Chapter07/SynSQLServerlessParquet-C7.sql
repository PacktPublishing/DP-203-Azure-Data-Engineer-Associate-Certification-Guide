-- Reading parquet with Synapse SQL serverless

SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK '<INSERT https:// LOCATION>',
        FORMAT = 'PARQUET'
    ) AS [result]


-- Accessing data using external Table example
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'Dp203ParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [Dp203ParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'Dp203DataSource') 
	CREATE EXTERNAL DATA SOURCE [Dp203DataSource] 
	WITH (
		LOCATION  = '<INSERT abfss:// LOCATION>' 
	)
GO

DROP EXTERNAL TABLE TripsExtTable;

CREATE EXTERNAL TABLE TripsExtTable (
	[tripId] VARCHAR (10),
	[driverId] VARCHAR (10),
	[customerId] VARCHAR (10),
	[cabId] VARCHAR (10),
	[tripDate] VARCHAR (10),
	[startLocation] VARCHAR (50),
	[endLocation] VARCHAR (50)
)
WITH (
	LOCATION = '/parquet/trips/*.parquet',
	DATA_SOURCE = [Dp203DataSource],
	FILE_FORMAT = [Dp203ParquetFormat]
)
GO

SELECT TOP 100 * FROM TripsExtTable
GO

SELECT COUNT(*) AS 'Trips', [startLocation] AS 'Location' FROM TripsExtTable GROUP BY startLocation;
