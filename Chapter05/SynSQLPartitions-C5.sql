-- Synapse SQL Partition Example

CREATE TABLE dbo.TripTable
(
    [tripId] INT NOT NULL,
    [driverId] INT NOT NULL,
    [customerId] INT NOT NULL,
    [tripDate] INT,
    [startLocation] VARCHAR(40),
    [endLocation] VARCHAR (40)
 )
 WITH
 (
    CLUSTERED COLUMNSTORE INDEX,
    DISTRIBUTION = HASH ([tripId]),
    PARTITION ([tripDate] RANGE RIGHT FOR VALUES
        ( 20220101, 20220201, 20220301 )
    )
)


INSERT INTO dbo.TripTable VALUES (101, 201, 301, 20220101, 'Miami', 'Dallas');
INSERT INTO dbo.TripTable VALUES (102, 202, 302, 20220102, 'Phoenix', 'Tempe');
INSERT INTO dbo.TripTable VALUES (103, 203, 303, 20220204, 'LA', 'San Jose');
INSERT INTO dbo.TripTable VALUES (104, 204, 304, 20220205, 'Seattle', 'Redmond');
INSERT INTO dbo.TripTable VALUES (105, 205, 305, 20220301, 'Atlanta', 'Chicago');

SELECT * from dbo.TripTable;

-- You can use this query to find the partition details

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
;

