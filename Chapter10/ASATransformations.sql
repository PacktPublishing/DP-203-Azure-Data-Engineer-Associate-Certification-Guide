-- ASA Transformation Examples
-- You will have to copy these SQL snippets into your ASA Job Query section and run it one by one.

SELECT
    COUNT(DISTINCT tripId) AS TripCount,
    System.TIMESTAMP() AS Time
INTO [Output]
FROM [Input] TIMESTAMP BY createdAt
GROUP BY 
     TumblingWindow(second, 10)

SELECT tripId, SUM(CAST(fare AS FLOAT)) AS TenSecondFares
INTO [Output]
FROM [Input] TIMESTAMP BY createdAt
GROUP BY
tripId, TumblingWindow(second, 10)


SELECT *
INTO [Output]
FROM [Input] TIMESTAMP BY timestamp
WHERE startLocation LIKE 'S%F'
