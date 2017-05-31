--1
--создать схему создать двух пользователей
--1-му польхзователь дать права на исполнение селектов в схеме и забрвть права на исполнение селектов в dbo
--2-му пользователю дать права только на создание таблиц в созданно	схеме
--залогиниться за 2-го пользователя и содать таблицу, из под второго дать права 1-му на создание представлний в созданной схеме

--drop  table  
--drop schema schema_test


if exists(select name from sys.database_principals
where name like 'user1')
drop user user1
if exists(select name from sys.server_principals
where name like 'login1')
drop login login1
if exists(select name from sys.database_principals
where name like 'user2')
drop user user2
if exists(select name from sys.server_principals
where name like 'login2')
drop login login2

select * from sys.schemas
order by name

IF OBJECT_ID(N'table_test1', N'U') IS NOT NULL
DROP TABLE schema_test.table_test1

IF OBJECT_ID(N'table_test2', N'U') IS NOT NULL
DROP TABLE schema_test.table_test2

if exists(select name from sys.schemas where name like 'schema_test')
drop schema schema_test

create login login1 with password = '1'
create user user1 for login login1

create login login2 with password = '1'
create user user2 for login login2

use lab_3_2
go
CREATE SCHEMA schema_test AUTHORIZATION dbo
--create table schema_test.table_test (A int, B int)
grant select on schema::schema_test to user1
grant create table to user2 with grant option
grant create view to user2 with grant option
GRANT ALTER ON SCHEMA::schema_test TO user2 with grant option;
go

deny select on schema::dbo to user1


--залогинились за 2-го

use lab_3_2
--drop table schema_test.table_test1
create table schema_test.table_test1 (A int, B int)
--drop view schema_test.view_test
grant CREATE view TO user1
GRANT ALTER ON SCHEMA::schema_test TO user1
