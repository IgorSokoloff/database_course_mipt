Set transaction isolation level read uncommitted
--Set transaction isolation level read committed

BEGIN TRANSACTION

UPDATE Награды_спортсмен set Размер_выплаты = Размер_выплаты + 100
where Спортсмен_ид = 2
--WAITFOR DELAY '00:00:05';

UPDATE Награды_спортсмен set Размер_выплаты = Размер_выплаты + 200
where Спортсмен_ид = 1

COMMIT 

select * from Награды_спортсмен
select @@TRANCOUNT/*UPDATE Награды_спортсмен SET Размер_выплаты = 1000 
WHERE Спортсмен_ид = 1
UPDATE Награды_спортсмен SET Размер_выплаты = 1000 
WHERE Спортсмен_ид = 2

select * from Награды_спортсмен
*/