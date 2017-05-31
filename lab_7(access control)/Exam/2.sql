use lab_3_2
CREATE SERVER ROLE server_test_role AUTHORIZATION [Igor-PC\Igor]
ALTER SERVER ROLE server_test_role add member [Igor-PC\Igor]


CREATE role db_test_role AUTHORIZATION dbo
grant select on database::lab_3_2 to db_test_role 
alter role db_test_role add member <username>
drop role db_test_role



drop server role server_test_role

deny select on награда to test
grant select on награда to public 

--as test
select * from Награда

grant select on награда to public
deny select on награда to test

revoke select on награда to public

revoke select on награда to test

begin tran
alter role db_owner add member test
rollback

GRANT select on Награда TO test
GRANT CREATE schema TO test
GRANT ALTER ON database::lab_3_2 TO test


--от test'a


go
CREATE SCHEMA test_schema 
CREATE TABLE test_table (A int, B int)
go

drop table test_table
drop schema test_schema

begin tran
create user test2 for login test
rollback

use lab_3_2
begin tran
alter role db_datareader add member test
exec sp_addrolemember 'db_datareader','test'

alter role db_datareader add member test_role
alter role db_datareader drop member test_role
rollback