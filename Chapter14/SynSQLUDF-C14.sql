-- Synapse SQL UDF Example

-- Drop the UDF if it already exists
DROP FUNCTION IF EXISTS dbo.isValidEmail
GO
-- Create an UDF to check valid emails. It returns 'Not Available' for all invalid emails
CREATE FUNCTION dbo.isValidEmail(@EMAIL VARCHAR(100))
RETURNS VARCHAR(100) AS
BEGIN     
  DECLARE @returnValue AS VARCHAR(100)
  DECLARE @EmailText VARCHAR(100)
  SET @EmailText= isnull(@EMAIL,'')
  SET @returnValue = CASE WHEN @EmailText NOT LIKE '_%@_%._%' THEN 'Not Available'
                          ELSE @EmailText
                      end
  RETURN @returnValue
END
GO
-- Drop the sample table if it already exists
-- DROP TABLE dbo.CustomerContact;
-- Create a sample table

-- DROP TABLE dbo.CustomerContact

CREATE TABLE dbo.CustomerContact
(  
    [CustomerID] INT,  
    [Name] VARCHAR(100),  
    [Email] VARCHAR(100) 
)

-- Insert some dummy values
INSERT INTO dbo.CustomerContact VALUES (1, 'Arielle', 'arielle');
INSERT INTO dbo.CustomerContact VALUES (2, 'Bran', 'bryan@domain.com');
INSERT INTO dbo.CustomerContact VALUES (3, 'Cathy', 'cathy@domain.com');
INSERT INTO dbo.CustomerContact VALUES (4, 'Demin', 'demin@wrongdomain');
INSERT INTO dbo.CustomerContact VALUES (5, 'Ethan', 'ethan@domain.com');

-- View the rows in the table  
SELECT * FROM dbo.CustomerContact;


-- Here is how you can use the UDF
SELECT CustomerID, Name, dbo.isValidEmail(Email) AS Email FROM dbo.CustomerContact;