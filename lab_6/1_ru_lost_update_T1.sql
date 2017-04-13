SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTEDBEGIN TRANSACTION declare @Текущий_приз moneyset @Текущий_приз =  ( SELECT Награды_спортсмен.Размер_выплаты FROM Награды_спортсмен with(xlock) WHERE Спортсмен_ид = 1) --SELECT @Текущий_призWAITFOR DELAY '00:00:03';UPDATE Награды_спортсмен SET Размер_выплаты = @Текущий_приз + 500 
WHERE Спортсмен_ид = 1
COMMIT--select @@TRANCOUNT--select * from Награды_спортсмен/*

UPDATE Награды_спортсмен SET Размер_выплаты = 1000 
WHERE Спортсмен_ид in ( 1,2)

*/


