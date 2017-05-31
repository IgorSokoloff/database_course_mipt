/*
DBCC CHECKIDENT (Спортсмен, RESEED, 1)
DBCC CHECKIDENT (Страна, RESEED, 1)
DBCC CHECKIDENT (Город, RESEED, 1)
DBCC CHECKIDENT (Улица, RESEED, 1)
DBCC CHECKIDENT (Награда, RESEED, 1)
DBCC CHECKIDENT (Тренер, RESEED, 1)
DBCC CHECKIDENT (Судья, RESEED, 1)
DBCC CHECKIDENT (Мастерство, RESEED, 1)
DBCC CHECKIDENT (Пол, RESEED, 1)
DBCC CHECKIDENT (Амплуа, RESEED, 1)
DBCC CHECKIDENT (Статус_игрока, RESEED, 1)
DBCC CHECKIDENT (Турнир, RESEED, 1)
DBCC CHECKIDENT (Команда, RESEED, 1)
DBCC CHECKIDENT (Лига, RESEED, 1)
DBCC CHECKIDENT (Сет, RESEED, 1)
DBCC CHECKIDENT (Итог, RESEED, 1)
DBCC CHECKIDENT (Штраф, RESEED, 1)
DBCC CHECKIDENT (Игра, RESEED, 1)
DBCC CHECKIDENT (Причина, RESEED, 1)
DBCC CHECKIDENT (Площадка, RESEED, 1)
DBCC CHECKIDENT (Тип_стадии, RESEED, 1)
DBCC CHECKIDENT (Игра, RESEED, 1)
DBCC CHECKIDENT (Стадия, RESEED, 1)
*/




select *from Награда
delete from Награда
DBCC CHECKIDENT (Награда, RESEED, 0) 
INSERT INTO Награда (Название) VALUES ('Награда2'),('Награда3') 
INSERT INTO Награда (Название) VALUES ('Награда3')
select *from Награда


--Изменить тип поля
ALTER TABLE [Пол]
ALTER COLUMN Название integer

ALTER TABLE Спортсмен 
DROP CONSTRAINT [age_sportsmen]  


create table aa(
a int identity(100,2)
)
--select * from 

declare @local varchar(10)
set @local ='Hello'
select @local

