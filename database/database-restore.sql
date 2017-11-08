USE ErisHelper
DROP DATABASE Eris
-- First check the file names in here
RESTORE FILELISTONLY FROM DISK = '/var/opt/mssql/backup/Eris.bak'

RESTORE DATABASE Eris
FROM DISK = '/var/opt/mssql/backup/Eris.bak'
WITH MOVE 'Eris_Data' TO '/var/opt/mssql/data/Eris_Data.mdf',
MOVE 'Eris_Log' TO '/var/opt/mssql/data/Eris_Log.ldf'
