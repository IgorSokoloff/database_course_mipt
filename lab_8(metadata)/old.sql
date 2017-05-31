use lab_3_2

-- выбрать имена всех таблиц, созданных назначенным пользователем базы данных

use lab_3_2
SELECT sys.sysobjects.name as [table], sysusers.name as [owner]
FROM sysobjects inner join sysusers on sysobjects.uid = sysusers.uid
WHERE xtype = 'U'
	AND sysusers.name = USER_NAME()


--left join sys.extended_properties on sys.extended_properties.major_id = sysobjects.id
--AND (sys.extended_properties.name not like 'microsoft_database_tools_support' or sys.extended_properties.name is null)
/*
 - 2. выбрать имя таблицы, имя столбца таблицы, признак того, 
 - допускает ли данный столбец null-значения, название типа данных столбца таблицы, размер этого типа данных 
 - для всех таблиц, созданных назначенным пользователем базы данных и всех их столбцов
 --------------------------------------------------------------------------------------
 */

-- select * from sys.all_columns

 --old
use lab_3_2
SELECT tb.name as table_name, cl.name as column_name, cl.isnullable, TYPE_NAME(cl.xtype) AS Type, cl.length
FROM sys.syscolumns AS cl inner join sys.sysobjects AS tb on tb.id = cl.id 
where tb.xtype='U'


/*
 - 3. Выбрать название ограничения целостности (первичные и внешние ключи), имя таблицы, в которой оно находится, 
 - признак того, что это за ограничение ('PK' для первичного ключа и 'F' для внешнего) - для всех ограничений целостности, 
 - созданных назначенным пользователем базы данных.
 */


SELECT t1.name, t2.name AS table_name, t1.xtype
FROM sysobjects AS t1 INNER JOIN sysobjects AS t2 ON t2.id = t1.parent_obj
	inner join sysusers ON sysusers.uid = t1.uid
WHERE sysusers.name = USER_NAME() AND
	(t1.xtype = 'PK' OR t1.xtype = 'F');


/*
 - 4. выбрать название внешнего ключа, имя таблицы, содержащей внешний ключ,
 - имя таблицы, содержащей его родительский ключ
 - для всех внешних ключей, созданных назначенным пользователем базы данных
 */

--old
use lab_3_2
SELECT t1.name as fk, t2.name as name_fk, t3.name as name_rk
FROM sysreferences AS ref INNER JOIN sysobjects AS t1 ON ref.constid = t1.id -- constid - идентификатор ограничения
	INNER JOIN sysobjects AS t2 ON ref.fkeyid = t2.id -- идентификатор таблицы, содержащей внешний ключ
	INNER JOIN sysobjects AS t3 ON ref.rkeyid = t3.id -- идентификатор таблицы, содерж. его родительский ключ
	INNER JOIN sysusers AS usr ON t2.uid = usr.uid
WHERE usr.name = USER_NAME();



/*
 - 5. Выбрать название представления, SQL-запрос, создающий это представление - для всех представлений, 
 - созданных назначенным пользователем базы данных.
 */


SELECT so.name AS view_name, com.text 
FROM sysobjects AS so inner join syscomments AS com ON so.id = com.id
	INNER JOIN sysusers AS usr ON usr.uid = so.uid
WHERE usr.name = USER_NAME()
	AND so.xtype = 'V'

/*
 - 6. Выбрать название триггера, имя таблицы, для которой определен триггер 
 - для всех триггеров, созданных назначенным пользователем базы данных 
 */
SELECT obj_tr.name AS trigger_name, obj_tab.name AS table_name
FROM sysobjects AS obj_tr INNER JOIN sysobjects AS obj_tab ON obj_tr.parent_obj = obj_tab.id
	INNER JOIN sysusers AS usr ON usr.uid = obj_tr.uid
WHERE usr.name = USER_NAME()
	AND obj_tr.xtype = 'TR'




