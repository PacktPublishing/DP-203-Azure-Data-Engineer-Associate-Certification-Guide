-- Querying the system tables
-- Synapse SQL Pool provides the following system tables that can be used to monitor the query performance:

-- sys.dm_pdw_exec_requests – contains all the current and recently active requests in Azure Synapse Analytics. It contains details like total_elapsed_time, submit_time, start_time, end_time, command, result_cache_hit and so on.
SELECT * FROM sys.dm_pdw_exec_requests;

-- sys.dm_pdw_waits – contains details of the wait states in a query, including locks and waits on transmission queues. 
SELECT * FROM sys.dm_pdw_waits;