-- COLUMN SECURITY example

-- Create a sample Customer table

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

INSERT INTO dbo.DimCustomer(customerId, name, emailId, phoneNum, city) VALUES (301, 'Sarah', 'sarah@ryan.com', '(465)-xxx-xxxx', 'New York');
INSERT INTO dbo.DimCustomer(customerId, name, emailId, phoneNum, city) VALUES (303, 'Ryan', 'ryan@ryan.com', '(122)-xxx-xxxx', 'Phoenix');

SELECT * from dbo.DimCustomer;

-- Create two users: HiPriv_User and LowPriv_User
-- Let us assume the HiPriv_User will have access to all the rows
-- And LowPriv_User will not have access to rows with TripID > 900
CREATE USER HiPriv_User WITHOUT LOGIN;  
CREATE USER LowPriv_User WITHOUT LOGIN;

-- Grant the right Privileges to HiPriv_User and LowPriv_User 
GRANT SELECT ON dbo.DimCustomer (customerId, name, city) TO LowPriv_User;
GRANT SELECT ON dbo.DimCustomer (customerId, name, emailId, phoneNum, city) TO HiPriv_User;
 
-- Now run the query as HiPriv_User. You will see all the columns
EXECUTE AS USER = 'HiPriv_User';
SELECT * from dbo.DimCustomer
REVERT;

-- Now run the query as LowPriv_User. You will only see customerId, name, city
EXECUTE AS USER = 'LowPriv_User';
SELECT * from dbo.DimCustomer
REVERT;
