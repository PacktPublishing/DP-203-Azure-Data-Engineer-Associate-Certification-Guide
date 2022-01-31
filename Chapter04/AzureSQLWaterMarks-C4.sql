--  Watermark Example
-- Run this in Azure SQL

DROP TABLE IF EXISTS  [dbo].[FactTrips];

CREATE TABLE FactTrips (
[TripID] INT,
[CustomerID] INT,
[LastModifiedTime] DATETIME2
);

INSERT INTO [dbo].[FactTrips] VALUES (100, 200, CURRENT_TIMESTAMP);
INSERT INTO [dbo].[FactTrips] VALUES (101, 201, CURRENT_TIMESTAMP);
INSERT INTO [dbo].[FactTrips] VALUES (102, 202, CURRENT_TIMESTAMP);

SELECT * FROM [dbo].[FactTrips];

-- A simple watermark table with just the table name and the last update value.
DROP TABLE WatermarkTable;
CREATE TABLE WatermarkTable
(
  [TableName] VARCHAR(100),
  [WatermarkValue] DATETIME,
);

INSERT INTO [dbo].[WatermarkTable] VALUES ('FactTrips', CURRENT_TIMESTAMP);
SELECT * FROM WatermarkTable;
GO

-- You can either update the Watermark table manually as shown or create a stored procedure and execute it everytime there is an update
UPDATE [dbo].[WatermarkTable] SET [WatermarkValue] = CURRENT_TIMESTAMP WHERE [TableName] = 'FactTrips';

-- Creating a stored procedure to update the watermark whenever there is an update to the  FactTable
DROP PROCEDURE uspUpdateWatermark
GO

CREATE PROCEDURE [dbo].uspUpdateWatermark @LastModifiedtime DATETIME, @TableName VARCHAR(100)
AS
BEGIN
UPDATE [dbo].[WatermarkTable] SET [WatermarkValue] = @LastModifiedtime WHERE [TableName] = @TableName
END
GO

-- Executing the stored procedure
DECLARE @timestamp AS DATETIME = CURRENT_TIMESTAMP;
EXECUTE uspUpdateWatermark @LastModifiedtime=@timestamp, @TableName='FactTrips';

SELECT * FROM WatermarkTable;