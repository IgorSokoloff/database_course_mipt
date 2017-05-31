--для всех вьюшек вывести имена таблиц и имена столбцов из которых созданы эти таблицы

SELECT OBJECT_NAME(referencing_id) AS view_name, referenced_entity_name as table_name, sc.name as Столбец
FROM sys.sql_expression_dependencies AS ssed 
INNER JOIN sys.objects AS sob ON ssed.referencing_id = sob.object_id
INNER JOIN sys.columns as sc on sc.object_id = ssed.referenced_id
WHERE sob.type_desc = 'VIEW' 
