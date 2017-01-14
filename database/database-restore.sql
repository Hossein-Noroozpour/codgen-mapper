RESTORE DATABASE Eris
FROM DISK = '/var/opt/mssql/backup/Eris-14-01-2017.bak'
WITH MOVE 'Eris' TO '/var/opt/mssql/data/Eris_Data.mdf',
MOVE 'Eris_Log' TO '/var/opt/mssql/data/Eris_Log.ldf'
GO