-- Creating statistics for Synapse dedicated pools

-- Create the Fact Table. In our case it would be the TripTable
-- DROP TABLE dbo.FactTrips;

CREATE TABLE dbo.FactTrips
(
    [tripId] int NOT NULL,
    [driverId] int NOT NULL,
    [customerId] int NOT NULL,
    [tripDate] int,
    [startLocation] VARCHAR (40),
    [endLocation] VARCHAR (40)
 )
 WITH
 (
    CLUSTERED COLUMNSTORE INDEX,
    DISTRIBUTION = HASH ([tripId])
 )
GO

-- Insert some sample values. In reality the Fact tables will have Millions of rows.

 INSERT INTO dbo.FactTrips VALUES (101, 201, 301, 20220101, 'New York', 'New Jersey');
 INSERT INTO dbo.FactTrips VALUES (102, 202, 302, 20220101, 'Miami', 'Dallas');
 INSERT INTO dbo.FactTrips VALUES (103, 203, 303, 20220102, 'Phoenix', 'Tempe');
 INSERT INTO dbo.FactTrips VALUES (104, 204, 304, 20220204, 'LA', 'San Jose');
 INSERT INTO dbo.FactTrips VALUES (105, 205, 305, 20220205, 'Seattle', 'Redmond');
 INSERT INTO dbo.FactTrips VALUES (106, 206, 306, 20220301, 'Atlanta', 'Chicago');

SELECT * from dbo.FactTrips;

-- You can enable statistics in Synapse SQL dedicated pools using the following command 
ALTER DATABASE <INSERT DATABASE NAME> SET AUTO_CREATE_STATISTICS ON

-- Once the AUTO_CREATE_STATISTICS is ON, any of SELECT, INSERT-SELECT, CTAS, UPDATE, DELETE or EXPLAIN 
-- statements will automatically trigger the creation of statistics for the columns involved in the query, if not already present. 
-- Automatic creation of statistics is not available for temporary or external tables.
-- You can create statistics on-demand using the following command.

CREATE STATISTICS TripStats
    ON dbo.FactTrips (tripId)
    WITH SAMPLE 40 PERCENT;

-- In the preceding example, we are using a 40% sample. If you do not provide a sample value, the default is 20%. 
-- You can also do a full scan instead of sampling using the following command.
CREATE STATISTICS TripStats
    ON dbo.FactTrips (tripId)
    WITH FULLSCAN;
