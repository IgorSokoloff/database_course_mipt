SET TRANSACTION ISOLATION LEVEL REPEATABLE READBEGIN TRANSACTION select Размер_выплаты from Награды_спортсмен WHERE Спортсмен_ид = 1WAITFOR DELAY '00:00:08';select Размер_выплаты from Награды_спортсмен WHERE Спортсмен_ид = 1COMMIT/*UPDATE Награды_спортсмен SET Размер_выплаты = 1500 
WHERE Спортсмен_ид = 1
*/