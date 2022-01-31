-- SQL Query Plan Example

-- DROP TABLE dbo.DimDriver;

-- Create a Driver table
CREATE TABLE dbo.DimDriver
(
    [driverId] INT NOT NULL,
    [firstName] VARCHAR (40),
    [middleName] VARCHAR(40),
    [lastName] VARCHAR(40),
    [city] VARCHAR (40),
    [gender] VARCHAR(40),
    [salary] INT
)
WITH
(
    CLUSTERED COLUMNSTORE INDEX
)
GO

-- Insert some sample values

INSERT INTO dbo.DimDriver VALUES (210, 'Alicia','','Yang','New York', 'Female', 2000);
INSERT INTO dbo.DimDriver VALUES (211, 'Brandon','','Rhodes','New York','Male', 3000);
INSERT INTO dbo.DimDriver VALUES (212, 'Cathy','','Mayor','California','Female', 3000);
INSERT INTO dbo.DimDriver VALUES (213, 'Dennis','','Brown','Florida','Male', 2500);
INSERT INTO dbo.DimDriver VALUES (214, 'Jeremey','','Stilton','Arizona','Male', 2500);
INSERT INTO dbo.DimDriver VALUES (215, 'Maile','','Green','Florida','Female', 4000);

SELECT * FROM dbo.DimDriver;

-- Let us run a query that has some aggregations
Select [gender], AVG([salary]) AS 'AVG salary' from dbo.DimDriver GROUP BY [gender];

-- Use the EXPLAIN option to see the query plan
EXPLAIN WITH_RECOMMENDATIONS
SELECT
        [gender],SUM([salary]) as Totalsalary
    FROM
       dbo.DimDriver
    GROUP BY
        [gender]
