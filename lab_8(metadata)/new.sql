-- выбрать имена всех таблиц, созданных назначенным пользователем базы данных

use lab_3_2
SELECT sys.objects.name AS [table]--, sys.database_principals.name as [owner]
FROM sys.objects inner join sys.database_principals on sys.objects.principal_id = sys.database_principals.principal_id
WHERE sys.objects.[type] = 'U'
	AND sys.database_principals.name = USER_NAME()
union
SELECT sys.objects.name AS [table]--, user_name() as [owner]
FROM sys.objects inner join sys.schemas on sys.objects.schema_id = sys.schemas.schema_id
WHERE sys.objects.[type] = 'U'
	AND USER_id() = sys.schemas.principal_id
	and sys.objects.principal_id is null


--необлодимо создать прецендент, который бы показывал проблему


select * from sys.schemas

/*
 - 2. выбрать им¤ таблицы, им¤ столбца таблицы, признак того, 
 - допускает ли данный столбец null-значени¤, название типа данных столбца таблицы, размер этого типа данных 
 - дл¤ всех таблиц, созданных назначенным пользователем базы данных и всех их столбцов
 --------------------------------------------------------------------------------------
 */


use lab_3_2
SELECT tb.name as table_name, cl.name as column_name, cl.is_nullable, TYPE_NAME(cl.user_type_id) AS Type, cl.max_length AS Length
FROM sys.columns AS cl inner join sys.objects AS tb on tb.object_id = cl.object_id
						inner join sys.database_principals as sdp on tb.principal_id = sdp.principal_id
where tb.[type]='U' and
		sdp.name = USER_NAME()
union
SELECT tb.name as table_name, cl.name as column_name, cl.is_nullable, TYPE_NAME(cl.user_type_id) AS Type, cl.max_length AS Length
FROM sys.columns AS cl inner join sys.objects AS tb on tb.object_id = cl.object_id
					   inner join sys.schemas on tb.schema_id = sys.schemas.schema_id
where tb.[type]='U' and
	USER_id() = sys.schemas.principal_id and
	tb.principal_id is null




/*
 - 3. ¬ыбрать название ограничени¤ целостности (первичные и внешние ключи), им¤ таблицы, в которой оно находитс¤, 
 - признак того, что это за ограничение ('PK' дл¤ первичного ключа и 'F' дл¤ внешнего) - дл¤ всех ограничений целостности, 
 - созданных назначенным пользователем базы данных.
 */


 SELECT t1.name, t2.name AS table_name, t1.[type]
FROM sys.objects AS t1 INNER JOIN sys.objects AS t2 ON t2.object_id = t1.parent_object_id
inner join sys.database_principals ON sys.database_principals.principal_id = t1.principal_id
WHERE sys.database_principals.name = USER_NAME() AND
	(t1.type = 'PK' OR t1.type = 'F')
union
SELECT t1.name, t2.name AS table_name, t1.[type]
FROM sys.objects AS t1 INNER JOIN sys.objects AS t2 ON t2.object_id = t1.parent_object_id
						inner join sys.schemas on t1.schema_id = sys.schemas.schema_id
WHERE USER_id() = sys.schemas.principal_id AND
	t1.principal_id is null and
	(t1.type = 'PK' OR t1.type = 'F')

/*
 - 4. выбрать название внешнего ключа, им¤ таблицы, содержащей внешний ключ,
 - им¤ таблицы, содержащей его родительский ключ
 - дл¤ всех внешних ключей, созданных назначенным пользователем базы данных
 */

use lab_3_2
select so1.name as fk, so2.name as name_fk, so3.name as name_rk
from sys.foreign_key_columns as fkc inner join sys.objects as so1 on fkc.constraint_object_id = so1.object_id
									inner join sys.objects as so2 on fkc.parent_object_id = so2.object_id
									inner join sys.objects as so3 on fkc.referenced_object_id = so3.object_id
									inner join sys.database_principals ON sys.database_principals.principal_id = so2.principal_id
where sys.database_principals.name = USER_NAME() 
union
select so1.name as fk, so2.name as name_fk, so3.name as name_rk
from sys.foreign_key_columns as fkc inner join sys.objects as so1 on fkc.constraint_object_id = so1.object_id
									inner join sys.objects as so2 on fkc.parent_object_id = so2.object_id
									inner join sys.objects as so3 on fkc.referenced_object_id = so3.object_id
									inner join sys.schemas on so1.schema_id = sys.schemas.schema_id
where USER_id() = sys.schemas.principal_id AND
	so2.principal_id is null

/*
 - 5. ¬ыбрать название представлени¤, SQL-запрос, создающий это представление - дл¤ всех представлений, 
 - созданных назначенным пользователем базы данных.
 */


 SELECT so.name, ssm.definition as def 
from sys.sql_modules as ssm inner join sys.objects as so on ssm.object_id = so.object_id
							inner join sys.database_principals as sdp ON sdp.principal_id = so.principal_id
where sdp.name = USER_NAME() and
so.type = 'V' 
union
SELECT so.name, ssm.definition as def 
from sys.sql_modules as ssm inner join sys.objects as so on ssm.object_id = so.object_id
							inner join sys.schemas on so.schema_id = sys.schemas.schema_id
where USER_id() = sys.schemas.principal_id and
so.principal_id is null and
so.type = 'V'
 
/*
 - 6. ¬ыбрать название триггера, им¤ таблицы, дл¤ которой определен триггер 
 - дл¤ всех триггеров, созданных назначенным пользователем базы данных 
 */

SELECT so_tr.name AS trigger_name, so_tab.name AS table_name
FROM sys.objects AS so_tr INNER JOIN sys.objects AS so_tab ON so_tr.parent_object_id = so_tab.principal_id
						   inner join sys.database_principals as sdp ON sdp.principal_id = so_tab.principal_id
WHERE sdp.name = USER_NAME()
	AND so_tr.type = 'TR'
union
SELECT so_tr.name AS trigger_name, so_tab.name AS table_name
FROM sys.objects AS so_tr INNER JOIN sys.objects AS so_tab ON so_tr.parent_object_id = so_tab.principal_id
						  inner join sys.schemas on so_tab.schema_id = sys.schemas.schema_id
WHERE USER_id() = sys.schemas.principal_id and
	so_tab.principal_id is null and
	so_tr.type = 'TR'


