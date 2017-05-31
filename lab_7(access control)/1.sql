use lab_3_2

if exists(select name from sys.database_principals
where name like 'test')
begin
	alter role test_role drop member test
	drop role test_role
	drop user test
end

if exists(select name from sys.server_principals
where name like 'test')
drop login test

create login test with password = '1'
create user test for login test

/*
В среде Microsoft Query Analyzer выполнить скрипты присвоения новому пользователю прав доступа к таблицам, созданным в лабораторной работе №2. 
При этом права доступа к различным таблицам должны быть различными, а именно:
*/
--для одной таблицы новому пользователю присваиваются права SELECT, INSERT, UPDATE в полном объеме
GRANT INSERT, SELECT, UPDATE ON Награда TO test

--для одной таблицы новому пользователю присваиваются права SELECT и UPDATE только избранных столбцов.
GRANT SELECT, UPDATE ON Команда(Название) TO test

--для одной таблицы новому пользователю присваивается только право SELECT.
GRANT SELECT ON Спортсмен TO test


/*
В среде Microsoft Enterprise Manager присвоить новому пользователю право доступа (SELECT) к представлению, созданному в лабораторной работе №4.
*/
GRANT SELECT ON команда_место to test


/*
В среде Microsoft Enterprise Manager создать стандартную роль уровня базы данных, 
присвоить ей право доступа (UPDATE на некоторые столбцы) к представлению, созданному в лабораторной работе №4, 
назначить новому пользователю созданную роль.
*/

--select DATABASE_PRINCIPAL_ID('test')


if DATABASE_PRINCIPAL_ID('test_role') is not null
drop role test_role


create role test_role AUTHORIZATION test

grant update on Игра_счет(Команда, название, номер_тура,счет, итог) to test_role

alter role test_role add member test

--select * from sys.database_role_members

--select * from sys.database_principals where name like 'test_role'

/*
В среде Microsoft Query Analyzer соединиться с локальной базой данных под именем нового пользователя.
Выполнить от имени нового пользователя некоторые выборки из таблиц и представления, подготовленные для лабораторных работ №№2,4. Убедиться в правильности контроля прав доступа.
Выполнить от имени нового пользователя операторы изменения таблиц с ограниченными правами доступа. Убедиться в правильности контроля прав доступа.

*/

--залогинились как test/test
use lab_3_2
--GRANT INSERT, SELECT, UPDATE ON Награда TO test
-------------------------------------
begin transaction
--DBCC CHECKIDENT (Награда, RESEED, 3)
insert into Награда values ('Награда_тест')
update Награда set Название = 'Награда_новая' where Название like 'Награда_тест'
select * from Награда
delete from Награда--false

rollback
-------------------------------------

--GRANT SELECT, UPDATE ON Команда(Название) TO test
-------------------------------------
begin transaction
insert into Команда values ('Команда_тест')--false
update Команда set Название = 'лидер1' where Название like 'лидер'
select Название from Команда
rollback
-------------------------------------

--GRANT SELECT ON Спортсмен TO test
-------------------------------------
select * from Спортсмен
delete from Спортсмен

-------------------------------------

--GRANT SELECT ON команда_место to test
-------------------------------------
select * from команда_место
begin transaction
update команда_место set Стадия = 'Круговик' where Стадия like 'круг' --false
select * from команда_место
rollback
-------------------------------------




