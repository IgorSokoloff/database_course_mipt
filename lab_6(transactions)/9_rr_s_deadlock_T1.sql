SET TRANSACTION ISOLATION LEVEL repeatable READ--SET TRANSACTION ISOLATION LEVEL serializableBEGIN TRANSACTION SELECT Награды_спортсмен.Размер_выплаты FROM Награды_спортсмен WHERE Спортсмен_ид = 2WAITFOR DELAY '00:00:05';UPDATE Награды_спортсмен SET Размер_выплаты = Размер_выплаты + 500 
WHERE Спортсмен_ид = 1
COMMITSELECT Награды_спортсмен.Размер_выплаты FROM Награды_спортсмен WHERE Спортсмен_ид = 1select @@TRANCOUNT--select * from Награды_спортсмен/*UPDATE Награды_спортсмен SET Размер_выплаты = 1500 
WHERE Спортсмен_ид = 1
*/
