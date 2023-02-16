USE DatabaseName;
GO

SELECT log_reuse_wait_desc
FROM sys.databases
WHERE name = 'DatabaseName';
GO

SELECT DB_NAME() AS DbName,
	name AS FileName,
	type_desc,
	size/128.0 AS CurrentSizeMB,
	size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS INT)/128.0 AS FreeSpaceMB
FROM sys.database_files
WHERE type IN (0,1)
GO

ALTER DATABASE DatabaseName SET RECOVERY SIMPLE WITH NO_WAIT;
GO

CHECKPOINT;
GO

DBCC SHRINKDATABASE (DatabaseName);
GO

ALTER DATABASE DatabaseName SET RECOVERY FULL WITH NO_WAIT;
GO

SELECT DB_NAME() AS DbName,
	name AS FileName,
	type_desc,
	size/128.0 AS CurrentSizeMB,
	size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS INT)/128.0 AS FreeSpaceMB
FROM sys.database_files
WHERE type IN (0,1)
GO

ALTER DATABASE DatabaseName SET RECOVERY SIMPLE WITH NO_WAIT;
GO