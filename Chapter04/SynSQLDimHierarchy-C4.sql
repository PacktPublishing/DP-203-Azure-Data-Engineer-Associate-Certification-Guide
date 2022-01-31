-- Dimensional Hierarchy Example

-- DROP TABLE DimEmployee;

CREATE TABLE DimEmployee (
	[employeeId] VARCHAR(20) NOT NULL,
	[name] VARCHAR(100),
	[department] VARCHAR(50),
	[title] VARCHAR(50),
	[parentEmployeeId] VARCHAR(20)
)

GO
-- Insert some sample values

INSERT INTO [dbo].[DimEmployee] ([employeeId], [name], [department], [title], [parentEmployeeId]) VALUES (100, 'Alan Li', 'Manufacturing', 'Manager', NULL);
INSERT INTO [dbo].[DimEmployee] ([employeeId], [name], [department], [title], [parentEmployeeId]) VALUES (200, 'Brenda Jackman', 'Manufacturing', 'Supervisor', 100);
INSERT INTO [dbo].[DimEmployee] ([employeeId], [name], [department], [title], [parentEmployeeId]) VALUES (300, 'David Hood', 'Manufacturing', 'Machine operator', 200);

-- Check the hierarchy established via the [parentEmployeeId] column
SELECT * FROM [dbo].[DimEmployee];

