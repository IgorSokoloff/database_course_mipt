SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTEDBEGIN TRANSACTION declare @Текущий_приз moneyset @Текущий_приз =  ( SELECT Награды_спортсмен.Размер_выплаты FROM Награды_спортсмен with(repeatableread) WHERE Спортсмен_ид = 1)--SELECT @Текущий_призUPDATE Награды_спортсмен SET Размер_выплаты = @Текущий_приз + 200 
WHERE Спортсмен_ид = 1
COMMITselect * from Награды_спортсмен/*UPDATE Награды_спортсмен SET Размер_выплаты = 1500 
WHERE Спортсмен_ид = 1
*/