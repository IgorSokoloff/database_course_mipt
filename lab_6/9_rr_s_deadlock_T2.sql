SET TRANSACTION ISOLATION LEVEL repeatable READ--SET TRANSACTION ISOLATION LEVEL serializableBEGIN TRANSACTION SELECT Награды_спортсмен.Размер_выплаты FROM Награды_спортсмен WHERE Спортсмен_ид = 1UPDATE Награды_спортсмен SET Размер_выплаты = Размер_выплаты + 200 
WHERE Спортсмен_ид = 2
COMMITSELECT Награды_спортсмен.Размер_выплаты FROM Награды_спортсмен WHERE Спортсмен_ид = 1select @@TRANCOUNT/*select * from Награды_спортсменUPDATE Награды_спортсмен SET Размер_выплаты = 1000 
WHERE Спортсмен_ид = 1
*/