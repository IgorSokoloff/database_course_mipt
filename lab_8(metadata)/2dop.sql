--для всех юзеров выыести списки прав котороыми они обладает и на какие объекту, учеть сто права могут распространяться посредством участия в роли

SELECT  so.name, permisson.class_desc,permisson.permission_name, principal1.name as grantee_name, principal2.name as grantor_name 
FROM sys.database_permissions as permisson 
inner join sys.database_principals as principal1 on permisson.grantee_principal_id = principal1.principal_id
left join sys.database_principals as principal2 on permisson.grantor_principal_id = principal2.principal_id
left join sys.all_objects as so on permisson.major_id = so.object_id


select * from sys.database_permissions
--where object_id = 0