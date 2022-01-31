-- Temporal Data Example
-- Run this in Azure SQL

CREATE TABLE Customer
(
  [customerId] INT NOT NULL PRIMARY KEY CLUSTERED,
  [name] VARCHAR(100) NOT NULL,
  [address] VARCHAR(100) NOT NULL,
  [email] VARCHAR (100) NOT NULL,
  [phone] VARCHAR(12) NOT NULL,
  [validFrom] DATETIME2 GENERATED ALWAYS AS ROW START,
  [validTo] DATETIME2 GENERATED ALWAYS AS ROW END,
  PERIOD FOR SYSTEM_TIME (validFrom, validTo),
 )
WITH (SYSTEM_VERSIONING = ON);

-- Let us insert some dummy values
INSERT INTO [dbo].[Customer] ([customerId], [name], [address], [email], [phone]) VALUES (101, 'Alan Li', '101 Test Lane, LA', 'alan@li.com', '111-222-3333');
INSERT INTO [dbo].[Customer] ([customerId], [name], [address], [email], [phone]) VALUES (102, 'Becky King', '202 Second Lane, SF', 'becky@king.com', '222-333-4444');
INSERT INTO [dbo].[Customer] ([customerId], [name], [address], [email], [phone]) VALUES (103, 'Daniel Martin', '303 Third Lane, NY', 'daniel@someone.com', '333-444-5555');

-- Check the values
SELECT * FROM Customer;

-- Now, let us update one of the table entries and see how the temporal table keeps track of the changes.

UPDATE [dbo].[Customer] SET [address] = '111 Updated Lane, LA' WHERE [customerId] = 101;


-- Change the dates to your current date before running this query
SELECT [customerId]
   , [name]
   , [address]
   , [validFrom]
   , [validTo]
   , IIF (YEAR(validTo) = 9999, 1, 0) AS IsActual
FROM [dbo].[Customer]
FOR SYSTEM_TIME BETWEEN '2022-01-12' AND '2022-01-15'
WHERE CustomerId = 101
ORDER BY validFrom DESC;