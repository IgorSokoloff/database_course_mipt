
--написать триггер котороый при создании объекта пользователя делал назначенного пользователя автоматическиим владельцем этого объекта

drop trigger trig_test on database

create trigger trig_test on database
with execute as self
for DDL_DATABASE_LEVEL_EVENTS
as
begin

--execute as --owner 

declare @table_name varchar(100)
declare @user_name varchar(100)

set @table_name = (SELECT EVENTDATA().value ('(/EVENT_INSTANCE/ObjectName)[1]','nvarchar(max)'))
set @user_name  = (SELECT EVENTDATA().value ('(/EVENT_INSTANCE/UserName)[1]','nvarchar(max)'))

--SELECT EVENTDATA().value ('(/EVENT_INSTANCE/UserName)[1]','nvarchar(max)')

exec sp_changeobjectowner @table_name, @user_name 

end

--grant execute on object::sp_changeobjectowner to test1 
	
drop user test1
drop login test1

create login test1 with password = '1'
create user test1 for login test1


select* from sys.triggers

grant create table to test1
GRANT ALTER ON SCHEMA::dbo TO test1


--от test1

--use lab_3_2


create table dbo.A_TAB (A int, B int)


drop table dbo.A_TAB

use lab_3_2
select * from sys.objects
where type = 'U'

drop table table_test1

