Select * FROM sys.fn_dblog(NULL,NULL)
where [transaction name] like 'CREATE TABLE'




SELECT * 
FROM sys.fn_dblog(NULL,NULL) dblog
inner join sys.syslogins logins on dblog.[Transaction SID] = logins.	sid;


SELECT * from sys.database_permissions


SELECT sdper.permission_name , sdpri1.name as grantee_name, sdpri2.name as grantor_name 
from sys.database_permissions as sdper inner join sys.database_principals as sdpri1 on sdper.grantee_principal_id = sdpri1.principal_id
									   inner join sys.database_principals as sdpri2 on sdper.grantor_principal_id = sdpri2.principal_id


use lab_3_2	
SELECT OBJECT_NAME(referencing_id) AS view_name, referenced_entity_name as table_name, col.name
FROM sys.sql_expression_dependencies AS sed 
INNER JOIN sys.objects AS tab ON sed.referencing_id = tab.object_id
left join sys.columns as col on (sed.referenced_minor_id = col.column_id and sed.referencing_id = col.object_id)
WHERE tab.type_desc='VIEW'

--order by view_name

select * from sys.columns

select * from sys.objects
where type = 'U'


use lab_3_2
select * 
FROM sys.sql_expression_dependencies AS sed 
INNER JOIN sys.objects AS tab ON sed.referencing_id = tab.object_id

									 
SELECT *
FROM sys.fn_dblog(NULL,NULL)
SELECT OBJECT_NAME(OBJECT_ID) AS DatabaseName,
last_user_update
FROM sys.dm_db_index_usage_stats
WHERE database_id = DB_ID( 'lab_3_2')
AND OBJECT_ID=OBJECT_ID('Награда')



SET NOCOUNT ON
DECLARE @LSN NVARCHAR(46)
DECLARE @LSN_HEX NVARCHAR(25)
DECLARE @trx_id NVARCHAR(28) = '0000:00004b1d'
DECLARE @tbl TABLE (id INT identity(1,1), i VARCHAR(10))
DECLARE @stmt VARCHAR(256)

SET @LSN = (SELECT TOP 1 [Current LSN] FROM fn_dblog(NULL, NULL) WHERE [Transaction ID] = @trx_id)

SET @stmt = 'SELECT CAST(0x' + SUBSTRING(@LSN, 1, 8) + ' AS INT)'
INSERT @tbl EXEC(@stmt)
SET @stmt = 'SELECT CAST(0x' + SUBSTRING(@LSN, 10, 8) + ' AS INT)'
INSERT @tbl EXEC(@stmt)
SET @stmt = 'SELECT CAST(0x' + SUBSTRING(@LSN, 19, 4) + ' AS INT)'
INSERT @tbl EXEC(@stmt)

SET @LSN_HEX =
 (SELECT i FROM @tbl WHERE id = 1) + ':' + (SELECT i FROM @tbl WHERE id = 2) + ':' + (SELECT i FROM @tbl WHERE id = 3)

SELECT [Current LSN], [Operation], [Context], [Transaction ID], [AllocUnitName], [Page ID], [Transaction Name], [Parent Transaction ID], [Description] 
FROM fn_dblog(@LSN_HEX, NULL)