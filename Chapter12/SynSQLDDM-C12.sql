-- Dynamic Data Masking examples

-- DROP TABLE dbo.CustomerDDM

CREATE TABLE dbo.CustomerDDM
(
    [customerId] INT NOT NULL,
    [name] VARCHAR(40) NOT NULL,
    [email] VARCHAR(100),
    [phoneNum] VARCHAR(40),
    [city] VARCHAR(40),
    [SSN] VARCHAR (12)
)
WITH (
    CLUSTERED COLUMNSTORE INDEX,
    DISTRIBUTION = REPLICATE
)
GO

INSERT INTO dbo.CustomerDDM(customerId, name, email, phoneNum, city, SSN) VALUES (301, 'Sarah', 'sarah@ryan.com', '(465)-111-xxxx', 'New York', '111-22-3333');
INSERT INTO dbo.CustomerDDM(customerId, name, email, phoneNum, city, SSN) VALUES (303, 'Ryan', 'ryan@ryan.com', '(122)-222-xxxx', 'Phoenix', '222-33-4444');
INSERT INTO dbo.CustomerDDM(customerId, name, email, phoneNum, city, SSN) VALUES (303, 'alicia', 'alicia@alicia.com', '(354)-333-xxxx', 'LA', '333-44-5555');

SELECT * from dbo.CustomerDDM;

ALTER TABLE [dbo].[CustomerDDM] ALTER COLUMN SSN ADD MASKED WITH (FUNCTION = 'PARTIAL(0,"xxx-xx-", 4)');
ALTER TABLE [dbo].[CustomerDDM] ALTER COLUMN email ADD MASKED WITH (FUNCTION = 'email()');
GO

-- Impersonate a low priv user for testing:
CREATE USER MaskingTestUser WITHOUT LOGIN;  
GRANT SELECT ON SCHEMA::dbo TO MaskingTestUser;  

EXECUTE AS USER = 'MaskingTestUser';  
SELECT * from dbo.CustomerDDM;
REVERT;
