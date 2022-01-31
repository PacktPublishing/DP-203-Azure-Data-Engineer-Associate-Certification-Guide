-- SQL Transformation Examples

-- CLean up the workspace

--DROP TABLE dbo.Driver;
--DROP TABLE dbo.TripTable;
--DROP TABLE dbo.Feedback;
--DROP TABLE dbo.TempDriver;

-- Create a Driver table

CREATE TABLE dbo.Driver
(
    [driverId] INT NOT NULL,
    [firstName] VARCHAR(40),
    [middleName] VARCHAR(40),
    [lastName] VARCHAR(40),
    [city] VARCHAR(40),
    [gender] VARCHAR(40),
    [salary] INT
)
    WITH 
    (
        CLUSTERED COLUMNSTORE INDEX
    )
GO

-- Insert sample data 
INSERT INTO dbo.Driver VALUES (200, 'Alice','','Hood','New York', 'Female', 4100);
INSERT INTO dbo.Driver VALUES (201, 'Bryan','M','Williams','New York','Male', 4000);
INSERT INTO dbo.Driver VALUES (202, 'Catherine','Goodwin','','California','Female', 4300);
INSERT INTO dbo.Driver VALUES (203, 'Daryl','','Jones','Florida','Male', 5500);
INSERT INTO dbo.Driver VALUES (204, 'Jenny','Anne','Simons','Arizona','Female', 3400);
INSERT INTO dbo.Driver VALUES (203, 'Daryl','','Jones','Florida','Male', 5500);


CREATE TABLE dbo.TempDriver
(
    [driverId] INT NOT NULL,
    [firstName] VARCHAR(40),
    [middleName] VARCHAR(40),
    [lastName] VARCHAR(40),
    [city] VARCHAR(40),
    [gender] VARCHAR(40),
    [salary] INT
)
    WITH 
    (
        CLUSTERED COLUMNSTORE INDEX
    )
GO

INSERT INTO dbo.TempDriver VALUES (210, 'Alicia','','Yang','New York', 'Female', 4000);
INSERT INTO dbo.TempDriver VALUES (211, 'Brandon','','Rhodes','New York','Male', 3000);
INSERT INTO dbo.TempDriver VALUES (212, 'Cathy','','Mayor','California','Female', 3000);
INSERT INTO dbo.TempDriver VALUES (213, 'Dennis','','Brown','Florida','Male', 2500);
INSERT INTO dbo.TempDriver VALUES (214, 'Jeremey','','Stilton','Arizona','Male', 2500);
INSERT INTO dbo.TempDriver VALUES (215, 'Maile','','Green','Florida','Female', 4000);


CREATE TABLE dbo.TripTable
(
    [tripId] INT NOT NULL,
    [driverId] INT NOT NULL,
    [customerId] INT NOT NULL,
    [tripDate] INT,
    [startLocation] VARCHAR(40),
    [endLocation] VARCHAR(40)
 )
 WITH
 (
    CLUSTERED COLUMNSTORE INDEX,
    DISTRIBUTION = HASH ([tripId])
 )

INSERT INTO dbo.TripTable VALUES (100, 200, 300, 20220101, 'New York', 'New Jersey');
INSERT INTO dbo.TripTable VALUES (101, 201, 301, 20220101, 'Miami', 'Dallas');
INSERT INTO dbo.TripTable VALUES (102, 202, 302, 20220102, 'Phoenix', 'Tempe');
INSERT INTO dbo.TripTable VALUES (103, 203, 303, 20220204, 'LA', 'San Jose');
INSERT INTO dbo.TripTable VALUES (104, 204, 304, 20220205, 'Seattle', 'Redmond');
INSERT INTO dbo.TripTable VALUES (105, 205, 305, 20220301, 'Atlanta', 'Chicago');


CREATE TABLE dbo.Feedback
(
    [driverId] INT NOT NULL,
    [rating] INT,
    [comment] VARCHAR(100)
)
WITH
(
    CLUSTERED COLUMNSTORE INDEX
)

INSERT INTO dbo.Feedback VALUES (200, 5, 'On time');
INSERT INTO dbo.Feedback VALUES (201, 4, 'Good manners');
INSERT INTO dbo.Feedback VALUES (201, 5, 'Punctual driver');
INSERT INTO dbo.Feedback VALUES (203, 2, 'Rude');
INSERT INTO dbo.Feedback VALUES (200, 1, 'Dirty seats');
INSERT INTO dbo.Feedback VALUES (204, 4, 'Clean car');


-- Now let us run some transformations on the above tables

-- WHERE
SELECT [firstName], [lastName] from dbo.Driver WHERE [city] = 'New York';
SELECT [firstName], [lastName] from dbo.Driver WHERE [salary] > 5000;

-- DISTINCT 
SELECT DISTINCT [firstName], [lastName] from dbo.Driver;

-- ORDER BY
SELECT DISTINCT [firstName], [lastName] from dbo.Driver ORDER BY [firstName];

-- GROUP BY
SELECT [gender], AVG([salary]) AS 'AVG salary' from dbo.Driver GROUP BY [gender];

-- UNION

SELECT [firstName], [lastName] FROM
dbo.Driver
WHERE [city] = 'New York'
UNION 
select [firstName], [lastName] FROM
dbo.TempDriver
WHERE [city] = 'New York';
GO


--JOIN

SELECT driver.[firstName], driver.[lastName], feedback.[rating], Feedback.[comment] FROM
dbo.Driver AS driver
INNER JOIN dbo.Feedback AS feedback
ON driver.[driverId] = feedback.[driverId]
WHERE driver.[city] = 'New York';
GO


--VIEWS
-- Driver and Feedback
DROP VIEW CompleteDriverView;

CREATE VIEW CompleteDriverView 
AS
SELECT driver.[firstName], driver.[lastName], feedback.[rating], feedback.[comment] FROM
dbo.Driver AS driver
INNER JOIN dbo.Feedback AS feedback
ON driver.[driverId] = feedback.[driverId]
WHERE driver.[city] = 'New York';
GO

SELECT DISTINCT * from CompleteDriverView;