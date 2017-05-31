use lab_3_3

--вспомогательные представления
IF OBJECT_ID('Команда_очки_турнир') IS NOT NULL
DROP VIEW Команда_очки_турнир

IF OBJECT_ID('Команда_очки_стадия') IS NOT NULL
DROP VIEW Команда_очки_стадия
go

create view Команда_очки_стадия (Команда, Стадия_ид, турнир_ид, Очки)
as(
select Игра_команда.Команда_ид, Игры_турнира.стадия_ид,Игры_турнира.Турнир_ид, sum(Игра_команда.Очки) as Очки 
	 from Игра_команда inner join Игры_турнира on  Игры_турнира.Игра_ид = Игра_команда.Игра_ид
	 				   inner join Команда on Игра_команда.Команда_ид = Команда.Команда_ид
	 group by Игра_команда.Команда_ид, Игры_турнира.стадия_ид, Игры_турнира.Турнир_ид
)
go

go
create view Команда_очки_турнир (Команда,  турнир_ид, Очки)
as(
select Команда_очки_стадия.Команда , Команда_очки_стадия.турнир_ид, sum (Команда_очки_стадия.Очки) from Команда_очки_стадия
	 group by Команда_очки_стадия.Команда , Команда_очки_стадия.турнир_ид
)
go

--исправить 1,2,3 места (в таблицах стадия_группа и команда турнир) после добавления новых результатов игры 
--(стадия - часть турнира)

use lab_3_3

--select* from стадия

--добавим стадию в существующем турнире
--добаавим команды, учасников
IF OBJECT_ID('Place_trig1') IS NOT NULL
DROP trigger Place_trig1

IF OBJECT_ID('Place_trig2') IS NOT NULL
DROP trigger Place_trig2

go
create trigger place_trig1 on dbo.Игра_команда
after insert, update
as
begin
	declare @team_score_stage table(team int,stage int,tournament int,scores int, place tinyint)
	declare @team_score_tournament table(team int,tournament int,scores int, place tinyint)
	declare @stages table (stage int)
	declare @current_stage int
	declare @current_tournament int
	declare @tournaments table (tournament int)

	insert into @stages select distinct Стадия_ид
						from Команда_очки_стадия 
						where стадия_ид in (select Игры_турнира.стадия_ид from Игры_турнира 
						inner join inserted on Игры_турнира.Игра_ид = inserted.Игра_ид)
	
	insert into @tournaments select distinct турнир_ид from Команда_очки_турнир 
						where турнир_ид in (select Игры_турнира.Турнир_ид from Игры_турнира 
						inner join inserted on Игры_турнира.Игра_ид = inserted.Игра_ид)
	--select * from Команда_очки_турнир
	
	while (select count(stage) from @stages)<>0
	begin
		set @current_stage = (select top (1) stage from @stages order by stage desc)
		insert into @team_score_stage(team, stage, tournament, scores, place) select команда, Стадия_ид,турнир_ид, Очки, row_number() over (order by очки desc) 
																from Команда_очки_стадия 
																where стадия_ид = @current_stage
																group by команда,турнир_ид, Стадия_ид, Очки
																order by турнир_ид, Стадия_ид, Очки desc
		delete from @stages where [@stages].stage = @current_stage
	end

	while (select count(tournament) from @tournaments)<>0
	begin
		set @current_tournament = (select top (1) tournament from @tournaments order by tournament desc)
		insert into @team_score_tournament(team, tournament, scores, place) select команда, турнир_ид, Очки, row_number() over (order by очки desc) 
																from Команда_очки_турнир 
																where турнир_ид = @current_tournament
																group by команда,турнир_ид, турнир_ид, Очки
																order by команда, турнир_ид, Очки desc
		delete from @tournaments where [@tournaments].tournament = @current_tournament
	end

	update Стадия_группа set Место = ([@team_score_stage].place ) from @team_score_stage where
										 Стадия_группа.Команда_ид = [@team_score_stage].team and
											  Стадия_группа.Стадия_ид = [@team_score_stage].stage
	
	update Команда_турнир set Место = ([@team_score_tournament].place ) from @team_score_tournament where
										 Команда_турнир.Команда_ид = [@team_score_tournament].team and
											  Команда_турнир.Турнир_ид = [@team_score_tournament].tournament
	
end 


go
create trigger place_trig2 on dbo.Игра_команда
after delete
as
begin
	declare @team_score_stage table(team int,stage int,tournament int,scores int, place tinyint)
	declare @team_score_tournament table(team int,tournament int,scores int, place tinyint)
	declare @stages table (stage int)
	declare @current_stage int
	declare @current_tournament int
	declare @tournaments table (tournament int)
	insert into @stages select distinct Стадия_ид
						from Команда_очки_стадия 
						where стадия_ид in (select Игры_турнира.стадия_ид from Игры_турнира 
						inner join deleted on Игры_турнира.Игра_ид = deleted.Игра_ид)
	
	insert into @tournaments select distinct турнир_ид from Команда_очки_турнир 
						where турнир_ид in (select Игры_турнира.Турнир_ид from Игры_турнира 
						inner join deleted on Игры_турнира.Игра_ид = deleted.Игра_ид)
	--select * from Команда_очки_турнир
	
	while (select count(stage) from @stages)<>0
	begin
		set @current_stage = (select top (1) stage from @stages order by stage desc)
		insert into @team_score_stage(team, stage, tournament, scores, place) select команда, Стадия_ид,турнир_ид, Очки, row_number() over (order by очки desc) 
																from Команда_очки_стадия 
																where стадия_ид = @current_stage
																group by команда,турнир_ид, Стадия_ид, Очки
																order by турнир_ид, Стадия_ид, Очки desc
		delete from @stages where [@stages].stage = @current_stage
	end

	while (select count(tournament) from @tournaments)<>0
	begin
		set @current_tournament = (select top (1) tournament from @tournaments order by tournament desc)
		insert into @team_score_tournament(team, tournament, scores, place) select команда, турнир_ид, Очки, row_number() over (order by очки desc) 
																from Команда_очки_турнир 
																where турнир_ид = @current_tournament
																group by команда,турнир_ид, турнир_ид, Очки
																order by команда, турнир_ид, Очки desc
		delete from @tournaments where [@tournaments].tournament = @current_tournament
	end

	update Стадия_группа set Место = ([@team_score_stage].place ) from @team_score_stage where
										 Стадия_группа.Команда_ид = [@team_score_stage].team and
											  Стадия_группа.Стадия_ид = [@team_score_stage].stage
	
	update Команда_турнир set Место = ([@team_score_tournament].place ) from @team_score_tournament where
										 Команда_турнир.Команда_ид = [@team_score_tournament].team and
											  Команда_турнир.Турнир_ид = [@team_score_tournament].tournament


end
go


begin tran

DBCC CHECKIDENT (Стадия, RESEED, 1)
DBCC CHECKIDENT (игра, RESEED, 6)
--DBCC CHECKIDENT (игра_команда, RESEED, 12)


INSERT INTO Стадия(Турнир_ид, Тип_стадии,Уровень_стадии,Дата_начала,Дата_окончания, Название) 
VALUES (dbo.id_of_tournament(dbo.id_of_ligue('Супер лига'),'Сезон 2016-2017'),dbo.id_of_type_stage('Круг'),1,'01-01-2017','31-12-2018','Группа Б') 

INSERT INTO Стадия_группа(Команда_ид, Стадия_ид, Место) VALUES (dbo.id_of_team('Дирекция Инфраструктуры (ДИ)'),2,NULL)
INSERT INTO Стадия_группа(Команда_ид, Стадия_ид, Место) VALUES (dbo.id_of_team('Газпром нефть'),2,NULL)
INSERT INTO Стадия_группа(Команда_ид, Стадия_ид, Место) VALUES (dbo.id_of_team('ЛИДЕР'),2,NULL)
INSERT INTO Стадия_группа(Команда_ид, Стадия_ид, Место) VALUES (dbo.id_of_team('ВК Тайфун'),2,NULL)
--??Возможно по результатам игр турнирная таблица изменится (и в стадии и в турнире) 

--
--Тур 1
--4 - 1
--3 - 2
--Игра Тайфун_ДИ
INSERT INTO Игра(Дата_проведения,Место_проведения,Стадия_ид, Номер_тура, Название)
VALUES ('01-02-2017 12:00', dbo.id_of_place('Тайфун_спортцентр'), 2, 1, 'Тайфун_ДИ')

--#####Команды
INSERT INTO Игра_команда(Команда_ид,Игра_ид,Итог,Очки)
VALUES (dbo.id_of_team('ВК Тайфун'), dbo.id_of_game('Тайфун_ДИ', 1, 2),	dbo.id_of_result('Поражение'), 0)

INSERT INTO Игра_команда(Команда_ид,Игра_ид,Итог,Очки)
VALUES (dbo.id_of_team('Дирекция Инфраструктуры (ДИ)'), dbo.id_of_game('Тайфун_ДИ', 1, 2), dbo.id_of_result('Победа'),3)

--Игра ЛИДЕР_Газпром
INSERT INTO Игра(Дата_проведения,Место_проведения,Стадия_ид, Номер_тура, Название) 
VALUES ('01-02-2017 11:00',dbo.id_of_place('ЛИДЕР_спортцентр'),2, 1, 'ЛИДЕР_Газпром')

--####Команды
INSERT INTO Игра_команда(Команда_ид,Игра_ид,Итог,Очки) VALUES (dbo.id_of_team('ЛИДЕР'), dbo.id_of_game('ЛИДЕР_Газпром', 1, 2),	dbo.id_of_result('Победа'), 2)
INSERT INTO Игра_команда(Команда_ид,Игра_ид,Итог,Очки) VALUES (dbo.id_of_team('Газпром нефть'), dbo.id_of_game('ЛИДЕР_Газпром', 1, 2), dbo.id_of_result('Поражение'),1)

--Тур 2
--3 - 1
--2 - 4
--Игра ЛИДЕР_ДИ
INSERT INTO Игра(Дата_проведения,Место_проведения,Стадия_ид, Номер_тура, Название) VALUES ('01-03-2016 12:00',dbo.id_of_place('ЛИДЕР_спортцентр'), 2, 2, 'ЛИДЕР_ДИ')

--####Команды
INSERT INTO Игра_команда(Команда_ид,Игра_ид,Итог,Очки) VALUES (dbo.id_of_team('ЛИДЕР'), dbo.id_of_game('ЛИДЕР_ДИ', 2, 2),	dbo.id_of_result('Поражение'), 0)
INSERT INTO Игра_команда(Команда_ид,Игра_ид,Итог,Очки) VALUES (dbo.id_of_team('Дирекция Инфраструктуры (ДИ)'), dbo.id_of_game('ЛИДЕР_ДИ', 2, 2), dbo.id_of_result('Победа'),3)

--Игра Газпром_Тайфун
INSERT INTO Игра(Дата_проведения,Место_проведения,Стадия_ид, Номер_тура, Название) VALUES ('01-03-2016 11:00',dbo.id_of_place('Газпром_спортцентр'), 2, 2, 'Газпром_Тайфун')

--####Команды
INSERT INTO Игра_команда(Команда_ид,Игра_ид,Итог,Очки) VALUES (dbo.id_of_team('Газпром нефть'), dbo.id_of_game('Газпром_Тайфун', 2, 2),	dbo.id_of_result('Победа'), 3)
INSERT INTO Игра_команда(Команда_ид,Игра_ид,Итог,Очки) VALUES (dbo.id_of_team('ВК Тайфун'), dbo.id_of_game('Газпром_Тайфун', 2, 2), dbo.id_of_result('Поражение'),0)

--Тур 3
--2 - 1
--4 - 3
--Игра Газпром_ДИ
INSERT INTO Игра(Дата_проведения,Место_проведения,Стадия_ид, Номер_тура, Название) VALUES ('01-04-2016 11:00',dbo.id_of_place('Газпром_спортцентр'), 2, 3, 'Газпром_ДИ')

--####Команды
INSERT INTO Игра_команда(Команда_ид,Игра_ид,Итог,Очки) VALUES (dbo.id_of_team('Газпром нефть'), dbo.id_of_game('Газпром_ДИ',3,2),	dbo.id_of_result('Поражение'), 0)
INSERT INTO Игра_команда(Команда_ид,Игра_ид,Итог,Очки) VALUES (dbo.id_of_team('Дирекция Инфраструктуры (ДИ)'), dbo.id_of_game('Газпром_ДИ',3,2), dbo.id_of_result('Победа'),3)

--Игра Тайфун_ЛИДЕР
INSERT INTO Игра(Дата_проведения,Место_проведения,Стадия_ид, Номер_тура, Название) VALUES ('01-04-2016 11:00',dbo.id_of_place('Тайфун_спортцентр'), 2, 3, 'Тайфун_ЛИДЕР')



--####Команды
INSERT INTO Игра_команда(Команда_ид,Игра_ид,Итог,Очки) VALUES (dbo.id_of_team('ВК Тайфун'), dbo.id_of_game('Тайфун_ЛИДЕР',3,2),	dbo.id_of_result('Поражение'), 0),
															  (dbo.id_of_team('ЛИДЕР'), dbo.id_of_game('Тайфун_ЛИДЕР',3,2), dbo.id_of_result('Победа'),3)


--обновим
--Игра Тайфун_ЛИДЕР
--добавим 100 очков вк тайфун и 100 ЛИДЕР

update Игра_команда set очки = 100 where (Игра_команда.Команда_ид = dbo.id_of_team('ВК Тайфун') and
										 Игра_команда.Игра_ид = dbo.id_of_game('Тайфун_ЛИДЕР',3,2) and	
										 Игра_команда.Итог =  dbo.id_of_result('Поражение'))
										 or
										 (Игра_команда.Команда_ид = dbo.id_of_team('ЛИДЕР')and
										  Игра_команда.Игра_ид = dbo.id_of_game('Тайфун_ЛИДЕР',3,2)and
										  Игра_команда.Итог = dbo.id_of_result('Победа'))


--теперь удалим запись об это игре
delete from Игра_команда where (Игра_команда.Команда_ид = dbo.id_of_team('ВК Тайфун') and
										 Игра_команда.Игра_ид = dbo.id_of_game('Тайфун_ЛИДЕР',3,2) and	
										 Игра_команда.Итог =  dbo.id_of_result('Поражение'))
										 or (Игра_команда.Команда_ид = dbo.id_of_team('ЛИДЕР')and
										  Игра_команда.Игра_ид = dbo.id_of_game('Тайфун_ЛИДЕР',3,2)and
										  Игра_команда.Итог = dbo.id_of_result('Победа'))


select * from Стадия_группа order by Стадия_ид, Команда_ид 
select * from команда_турнир order by Команда_ид

/*

delete from Игра where Игра_ид>10
delete from Стадия where Стадия_ид >1
delete from Игра_команда where Игра_ид>10
delete from стадия_группа where Стадия_ид =2

*/

rollback
