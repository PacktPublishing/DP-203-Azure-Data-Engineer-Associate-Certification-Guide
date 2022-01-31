-- External Table Example

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'Dp203ParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [Dp203ParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'Dp203DataSource') 
	CREATE EXTERNAL DATA SOURCE [Dp203DataSource] 
	WITH (
		LOCATION  = '<INSERT abfss://  DATA SOURCE LOCATION>' 
	)
G0

--DROP EXTERNAL TABLE TestExtTable;

CREATE EXTERNAL TABLE TestExtTable (
	[tripId] INT,
	[driverId] INT,
	[customerId] INT,
	[cabId] INT,
	[tripDate] INT,
	[startLocation] VARCHAR (50),
	[endLocation] VARCHAR (50)
)
WITH (
	LOCATION = '/parquet/trips/*.parquet',
	DATA_SOURCE = [Dp203DataSource],
	FILE_FORMAT = [Dp203ParquetFormat]
)
GO

SELECT TOP 100 * FROM TestExtTable
GO

