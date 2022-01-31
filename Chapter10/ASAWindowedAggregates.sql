-- ASA Windowed Aggregates Examples
-- You will have to copy these SQL snippets into your ASA Job Query section and run it one by one.

-- Tumbling window example in ASA. It calculates the number of trips grouped by Location, in 10-second-wide tumbling windows.
SELECT System.Timestamp() AS WindowEnd, tripLocation, COUNT(*)  
INTO [Output]
FROM [Input] TIMESTAMP BY createdAt  
GROUP BY tripLocation, TumblingWindow(Duration(second, 10), Offset(millisecond, -1))

-- Hopping window example. Every 10 seconds, fetch the trip count per location for the last 20 seconds. 
-- Here the window size is 20 seconds, and the hop size is 10 seconds.
SELECT System.Timestamp() AS WindowEnd, tripLocation, COUNT(*)  
INTO [Output]
FROM [Input]  TIMESTAMP BY createdAt  
GROUP BY tripLocation, HoppingWindow(Duration(second, 20), Hop(second, 10), Offset(millisecond, -1))

-- Sliding window example. For every 10 seconds, alert if a location appears more than 5 times.
SELECT System.Timestamp() AS WindowEnd, tripLocation, COUNT(*)  
INTO [Output]
FROM [Input] TIMESTAMP BY createdAt
GROUP BY tripLocation, SlidingWindow(second, 10)
HAVING COUNT(*) > 5

-- Session window example. Find the number of trips that occur within 5 seconds of each other.
SELECT System.Timestamp() AS WindowEnd, tripId, COUNT(*)  
INTO [Output]
FROM [Input] TIMESTAMP BY createdAt
GROUP BY tripId, SessionWindow(second, 5, 10)

-- Snapshot window example
SELECT tripId, COUNT(*)
INTO [Output]
FROM [Input] TIMESTAMP BY createdAt
GROUP BY tripId, System.Timestamp()
