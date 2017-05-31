--когда sys.objects.principal_id не null

drop schema schema_test1
drop user test1
drop login test1


--begin tran

SELECT * FROM sys.objects WHERE sys.objects.[type] = 'U'

create login test1 with password = '1'
create user test1 for login test1

--grant create schema to test1
--grant alter on database::lab_3_2 to test1

go
CREATE SCHEMA schema_test1 AUTHORIZATION test1
--create table schema_test.table_test (A int, B int)
go


--grant select on schema::schema_test to test1
grant create table to test1 with
--grant create view to user2 with grant option

GRANT ALTER ON SCHEMA::schema_test TO test1
go




create table schema_test1.table_test (A int, B int)

alter authorization on object::schema_test1.table_test to dbo


select* from sys.schemas
select* from sys.database_principals



--rollback