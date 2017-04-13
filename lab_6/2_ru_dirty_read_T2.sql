SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTEDBEGIN TRANSACTION select Размер_выплаты from Награды_спортсмен WHERE Спортсмен_ид = 1set @Текущий_приз =  ( SELECT Награды_спортсмен.Размер_выплаты FROM Награды_спортсмен WHERE Спортсмен_ид = 1)COMMIT/*UPDATE Награды_спортсмен SET Размер_выплаты = 1500 
WHERE Спортсмен_ид = 1
*/