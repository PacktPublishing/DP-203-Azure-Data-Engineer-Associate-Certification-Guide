-- Row Level Security

-- Create sample Trips and Customer tables

DROP TABLE dbo.TripTable;

CREATE TABLE dbo.TripTable
(
    [tripId] INT NOT NULL,
    [driverId] INT NOT NULL,
    [customerId] INT NOT NULL,
    [tripDate] INT,
    [startLocation] VARCHAR (40),
    [endLocation] VARCHAR (40)
 )
 WITH
 (
    CLUSTERED COLUMNSTORE INDEX,
    DISTRIBUTION = HASH ([tripId])
)

 INSERT INTO dbo.TripTable VALUES (111, 201, 301, 20220101, 'New York', 'New Jersey');
 INSERT INTO dbo.TripTable VALUES (112, 202, 302, 20220101, 'Miami', 'Dallas');
 INSERT INTO dbo.TripTable VALUES (113, 203, 302, 20220102, 'Phoenix', 'Tempe');
 INSERT INTO dbo.TripTable VALUES (114, 204, 303, 20220204, 'LA', 'San Jose');
 INSERT INTO dbo.TripTable VALUES (115, 205, 304, 20220205, 'Seattle', 'Redmond');
 INSERT INTO dbo.TripTable VALUES (116, 203, 305, 20220301, 'Atlanta', 'Chicago');

-- Insert a row with tripId >= 900, as we will use that as the condition to restrict the row views to non-privelleged users
INSERT INTO dbo.TripTable VALUES (900, 299, 399, 20220301, 'Pre-Launch', 'Pre-Launch');

SELECT * from dbo.TripTable;

-- Create two users: HiPriv_User and LowPriv_User
-- Let us assume the HiPriv_User will have access to all the rows
-- And LowPriv_User will not have access to rows with tripId > 900
CREATE USER HiPriv_User WITHOUT LOGIN;  
CREATE USER LowPriv_User WITHOUT LOGIN;

GRANT SELECT ON dbo.TripTable TO HiPriv_User;  
GRANT SELECT ON dbo.TripTable TO LowPriv_User; 
GO

-- Drop old policies and schemas if already created

-- DROP SECURITY POLICY PrivFilter;
-- DROP FUNCTION Security.tvf_securitypredicate;
-- DROP SCHEMA Security;

-- Create a new Security schema
CREATE SCHEMA Security;  
GO  
  
-- Create the new function that has the business logic
CREATE FUNCTION Security.tvf_securitypredicate(@tripId AS int)  
    RETURNS TABLE  
WITH SCHEMABINDING  
AS  
    RETURN SELECT 1 AS tvf_securitypredicate_result
WHERE  @tripId < 900 OR USER_NAME() = 'HiPriv_User';  
GO

-- Create a security policy and map the previous function to the table on which it needs to operate
CREATE SECURITY POLICY PrivFilter ADD FILTER PREDICATE Security.tvf_securitypredicate(tripId) ON dbo.TripTable WITH (STATE = ON);
GO

-- Now run the query as HiPriv_User. You will see all the rows.
EXECUTE AS USER = 'HiPriv_User';
SELECT * from dbo.TripTable
REVERT;

-- Now run the query as LowPriv_User. You will not see the rows with tripId >= 900
EXECUTE AS USER = 'LowPriv_User';
SELECT * from dbo.TripTable
REVERT;

-- Turn off the filter
ALTER SECURITY POLICY PrivFilter  
WITH (STATE = ON);  
