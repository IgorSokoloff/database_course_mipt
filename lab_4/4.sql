--Вывести тех участников чей возраст больше среднего по турниру 'Сезон 2016-2017', лиги 'Супер лига'


with sportsman_tournament(Спортсмен_ид, Команда,Возраст)as--участники конкретного турнира
(
select Спортсмен.Спортсмен_ид, Команда.Название ,(YEAR(CURRENT_TIMESTAMP)-YEAR(Спортсмен.Дата_рождения)) as Возраст 
from Участники inner join Турнир on Участники.Турнир_ид = Турнир.Турнир_ид
			   inner join Лига on Лига.Лига_ид = Турнир.Лига_ид
			   inner join Команда on Участники.Команда_ид = Команда.Команда_ид
	   		   inner join Спортсмен on Участники.Спортсмен_ид = Спортсмен.Спортсмен_ид
where  (Лига.Название like 'Супер лига' and Турнир.Название like 'Сезон 2016-2017')
)
select Спортсмен.Фамилия, Спортсмен.Имя, sportsman_tournament.Команда as Команда, Возраст 
from Спортсмен inner join sportsman_tournament on Спортсмен.Спортсмен_ид = sportsman_tournament.Спортсмен_ид
where sportsman_tournament.Возраст > (select avg(sportsman_tournament.Возраст) from sportsman_tournament)

