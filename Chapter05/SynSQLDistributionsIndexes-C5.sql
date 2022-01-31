-- Synapse SQL Indexes, Distributions and Partitions Example

-- Example of CLUSTERED COLUMNSTORE INDEX with Hash index
DROP TABLE dbo.TripTable;

CREATE TABLE dbo.TripTable
(
    [tripId] INT NOT NULL,
    [driverId] INT NOT NULL,
    [customerID] INT NOT NULL,
    [tripDate] INT,
    [startLocation] VARCHAR(40),
    [endLocation] VARCHAR(40)
 )
 WITH
 (
    CLUSTERED COLUMNSTORE INDEX,
    DISTRIBUTION = HASH ([tripId]),
    PARTITION ([tripDate] RANGE RIGHT FOR VALUES
        ( 20220101, 20220201, 20220301 )
    )
)

INSERT INTO dbo.TripTable VALUES (100, 200, 300, 20220101, 'New York', 'New Jersey');
INSERT INTO dbo.TripTable VALUES (101, 201, 301, 20220101, 'Miami', 'Dallas');
INSERT INTO dbo.TripTable VALUES (102, 202, 302, 20220102, 'Phoenix', 'Tempe');
INSERT INTO dbo.TripTable VALUES (103, 203, 303, 20220204, 'LA', 'San Jose');
INSERT INTO dbo.TripTable VALUES (104, 204, 304, 20220205, 'Seattle', 'Redmond');
INSERT INTO dbo.TripTable VALUES (105, 205, 305, 20220301, 'Atlanta', 'Chicago');

 SELECT * from dbo.TripTable;

DROP TABLE dbo.TripTable;

-- Example of CLUSTERED COLUMNSTORE INDEX with Round Robin

CREATE TABLE dbo.TripTable
(
    [tripId] INT NOT NULL,
    [driverId] INT NOT NULL,
    [customerID] INT NOT NULL,
    [tripDate] INT,
    [startLocation] VARCHAR(40),
    [endLocation] VARCHAR(40)
 )
 WITH
 (
    CLUSTERED COLUMNSTORE INDEX,
    DISTRIBUTION = ROUND_ROBIN,
    PARTITION ([tripDate] RANGE RIGHT FOR VALUES
        ( 20220101, 20220201, 20220301 )
    )
)

INSERT INTO dbo.TripTable VALUES (100, 200, 300, 20220101, 'New York', 'New Jersey');
INSERT INTO dbo.TripTable VALUES (101, 201, 301, 20220101, 'Miami', 'Dallas');
INSERT INTO dbo.TripTable VALUES (102, 202, 302, 20220102, 'Phoenix', 'Tempe');
INSERT INTO dbo.TripTable VALUES (103, 203, 303, 20220204, 'LA', 'San Jose');
INSERT INTO dbo.TripTable VALUES (104, 204, 304, 20220205, 'Seattle', 'Redmond');
INSERT INTO dbo.TripTable VALUES (105, 205, 305, 20220301, 'Atlanta', 'Chicago');

 SELECT * from dbo.TripTable;

-- Example of CLUSTERED COLUMNSTORE INDEX with REPLICATE distribution
DROP TABLE dbo.TripTable;

CREATE TABLE dbo.TripTable
(
    [tripId] INT NOT NULL,
    [driverId] INT NOT NULL,
    [customerID] INT NOT NULL,
    [tripDate] INT,
    [startLocation] VARCHAR(40),
    [endLocation] VARCHAR(40)
 )
 WITH
 (
    CLUSTERED COLUMNSTORE INDEX,
    DISTRIBUTION = REPLICATE,
    PARTITION ([tripDate] RANGE RIGHT FOR VALUES
        ( 20220101, 20220201, 20220301 )
    )
)

INSERT INTO dbo.TripTable VALUES (100, 200, 300, 20220101, 'New York', 'New Jersey');
INSERT INTO dbo.TripTable VALUES (101, 201, 301, 20220101, 'Miami', 'Dallas');
INSERT INTO dbo.TripTable VALUES (102, 202, 302, 20220102, 'Phoenix', 'Tempe');
INSERT INTO dbo.TripTable VALUES (103, 203, 303, 20220204, 'LA', 'San Jose');
INSERT INTO dbo.TripTable VALUES (104, 204, 304, 20220205, 'Seattle', 'Redmond');
INSERT INTO dbo.TripTable VALUES (105, 205, 305, 20220301, 'Atlanta', 'Chicago');

 SELECT * from dbo.TripTable;

-- Example of CLUSTERED INDEX

DROP TABLE dbo.TripTable;

CREATE TABLE dbo.TripTable
(
    [tripId] INT NOT NULL,
    [driverId] INT NOT NULL,
    [customerID] INT NOT NULL,
    [tripDate] INT,
    [startLocation] VARCHAR(40),
    [endLocation] VARCHAR(40)
 )
 WITH
 (
    CLUSTERED INDEX (tripID),
    DISTRIBUTION = REPLICATE,
    PARTITION ([tripDate] RANGE RIGHT FOR VALUES
        ( 20220101, 20220201, 20220301 )
    )
)

INSERT INTO dbo.TripTable VALUES (100, 200, 300, 20220101, 'New York', 'New Jersey');
INSERT INTO dbo.TripTable VALUES (101, 201, 301, 20220101, 'Miami', 'Dallas');
INSERT INTO dbo.TripTable VALUES (102, 202, 302, 20220102, 'Phoenix', 'Tempe');
INSERT INTO dbo.TripTable VALUES (103, 203, 303, 20220204, 'LA', 'San Jose');
INSERT INTO dbo.TripTable VALUES (104, 204, 304, 20220205, 'Seattle', 'Redmond');
INSERT INTO dbo.TripTable VALUES (105, 205, 305, 20220301, 'Atlanta', 'Chicago');

 SELECT * from dbo.TripTable;

-- Example of  Heap indexing

DROP TABLE dbo.TripTable;

CREATE TABLE dbo.TripTable
(
    [tripId] INT NOT NULL,
    [driverId] INT NOT NULL,
    [customerID] INT NOT NULL,
    [tripDate] INT,
    [startLocation] VARCHAR(40),
    [endLocation] VARCHAR(40)
 )
 WITH
 (
    HEAP,
    DISTRIBUTION = REPLICATE,
    PARTITION ([tripDate] RANGE RIGHT FOR VALUES
        ( 20220101, 20220201, 20220301 )
    )
)

INSERT INTO dbo.TripTable VALUES (100, 200, 300, 20220101, 'New York', 'New Jersey');
INSERT INTO dbo.TripTable VALUES (101, 201, 301, 20220101, 'Miami', 'Dallas');
INSERT INTO dbo.TripTable VALUES (102, 202, 302, 20220102, 'Phoenix', 'Tempe');
INSERT INTO dbo.TripTable VALUES (103, 203, 303, 20220204, 'LA', 'San Jose');
INSERT INTO dbo.TripTable VALUES (104, 204, 304, 20220205, 'Seattle', 'Redmond');
INSERT INTO dbo.TripTable VALUES (105, 205, 305, 20220301, 'Atlanta', 'Chicago');

 SELECT * from dbo.TripTable;


-- You can use the following query to find the indexes, partition number and other details about the table

SELECT  QUOTENAME(s.[name])+'.'+QUOTENAME(t.[name]) as Table_name
,       i.[name] as Index_name
,       p.partition_number as Partition_nmbr
,       p.[rows] as Row_count
,       p.[data_compression_desc] as Data_Compression_desc
FROM    sys.partitions p
JOIN    sys.tables     t    ON    p.[object_id]   = t.[object_id]
JOIN    sys.schemas    s    ON    t.[schema_id]   = s.[schema_id]
JOIN    sys.indexes    i    ON    p.[object_id]   = i.[object_Id]
                            AND   p.[index_Id]    = i.[index_Id]
WHERE t.[name] = 'TripTable'
