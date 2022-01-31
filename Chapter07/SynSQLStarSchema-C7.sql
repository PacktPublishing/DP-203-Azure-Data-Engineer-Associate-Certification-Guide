-- Example for creating a Star schema 

-- Create the Fact Table. In our case it would be the TripTable
DROP TABLE dbo.FactTrips;

CREATE TABLE dbo.FactTrips
(
    [tripId] INT NOT NULL,
    [driverId] INT NOT NULL,
    [customerId] INT NOT NULL,
    [tripdate] INT,
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


-- Create the Customer Dimension table
DROP TABLE dbo.DimCustomer;

CREATE TABLE dbo.DimCustomer
(
    [customerId] INT NOT NULL,
    [name] VARCHAR(40) NOT NULL,
    [emailId] VARCHAR(40),
    [phoneNum] VARCHAR(40),
    [city] VARCHAR(40)
)
WITH
(
    CLUSTERED COLUMNSTORE INDEX,
    DISTRIBUTION = REPLICATE
)
GO

-- Another way of inserting data using COPY INTO
-- You will have to use the https format here instead of the abfss format
-- Copy the customer.csv file in this directory to the ADLS Gen2 location and use that path here.

COPY INTO dbo.DimCustomer
FROM '<INSERT https:// LOCATION>'
WITH (
    FILE_TYPE='CSV',
    FIELDTERMINATOR=',',
    FIELDQUOTE='',
    ROWTERMINATOR='\n',
    ENCODING = 'UTF8',
    FIRSTROW = 2
);

SELECT * from dbo.DimCustomer;

-- Create a Driver Dimension table
CREATE TABLE dbo.DimDriver
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
    CLUSTERED COLUMNSTORE INDEX,
    DISTRIBUTION = REPLICATE
)
GO

-- Insert some sample values

INSERT INTO dbo.DimDriver VALUES (210, 'Alicia','','Yang','New York', 'Female', 2000);
INSERT INTO dbo.DimDriver VALUES (211, 'Brandon','','Rhodes','New York','Male', 3000);
INSERT INTO dbo.DimDriver VALUES (212, 'Cathy','','Mayor','California','Female', 3000);
INSERT INTO dbo.DimDriver VALUES (213, 'Dennis','','Brown','Florida','Male', 2500);
INSERT INTO dbo.DimDriver VALUES (214, 'Jeremey','','Stilton','Arizona','Male', 2500);
INSERT INTO dbo.DimDriver VALUES (215, 'Maile','','Green','Florida','Female', 4000);

SELECT * from dbo.DimDriver;

DROP TABLE dbo.DimDate
-- Create the date dimension table
CREATE TABLE dbo.DimDate
(
    [dateId] INT NOT NULL,
    [date] DATETIME NOT NULL,
    [dayOfWeek] VARCHAR(40),
    [fiscalQuarter] VARCHAR(40)
)
WITH
(
    CLUSTERED COLUMNSTORE INDEX,
    DISTRIBUTION = REPLICATE
)
GO

INSERT INTO dbo.DimDate VALUES (20210101, '20210101','Saturday','Q3');
INSERT INTO dbo.DimDate VALUES (20210102, '20210102','Sunday','Q3');
INSERT INTO dbo.DimDate VALUES (20210103, '20210103','Monday','Q3');
INSERT INTO dbo.DimDate VALUES (20210104, '20210104','Tuesday','Q3');
INSERT INTO dbo.DimDate VALUES (20210105, '20210105','Wednesday','Q3');



-- Now run some sample queries

SELECT trip.[tripId], customer.[name] from 
dbo.FactTrips AS trip
JOIN dbo.DimCustomer AS customer
ON trip.[customerId] = customer.[customerId] 
WHERE trip.[endLocation] = 'San Jose';


