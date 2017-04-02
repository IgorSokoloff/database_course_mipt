SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTEDBEGIN TRANSACTION declare @Текущий_приз moneyset @Текущий_приз =  ( SELECT Награды_спортсмен.Размер_выплаты FROM Награды_спортсмен WHERE Спортсмен_ид = 1)WAITFOR DELAY '00:00:10';UPDATE Награды_спортсмен SET Размер_выплаты = @Текущий_приз + 500 
WHERE Спортсмен_ид = 1
COMMITselect * from Награды_спортсмен/*UPDATE Награды_спортсмен SET Размер_выплаты = 1500 
WHERE Спортсмен_ид = 1
*/