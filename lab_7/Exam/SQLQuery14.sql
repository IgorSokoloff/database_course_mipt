use lab_3_2
begin tran
go
create view schema_test.view_test(A,B) as
(
select * from schema_test.table_test2
)
go

rollback