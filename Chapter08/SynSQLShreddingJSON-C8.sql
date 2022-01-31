-- Example for reading JSON files using OPENROWSET

SELECT TOP 10 *
FROM openrowset(
        BULK '<INSERT https:// JSON LOCATION>',
        FORMAT = 'csv',
        FIELDTERMINATOR ='0x0b',
        FIELDQUOTE = '0x0b'
    ) with (doc nvarchar(max)) as rows
GO

SELECT     
    JSON_VALUE(doc, '$.firstname') AS firstName,
    JSON_VALUE(doc, '$.lastname') AS lastName,
    CAST(JSON_VALUE(doc, '$.id') AS INT) as driverId,
    JSON_VALUE(doc, '$.salary') as salary
FROM openrowset(
        BULK '<INSERT https:// JSON LOCATION>',
        FORMAT = 'csv',
        FIELDTERMINATOR ='0x0b',
        FIELDQUOTE = '0x0b'
    ) WITH (doc nvarchar(max)) AS ROWS
GO
