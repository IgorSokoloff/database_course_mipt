SET TRANSACTION ISOLATION LEVEL READ COMMITTEDBEGIN TRANSACTION 
UPDATE Награды_спортсмен SET Размер_выплаты = Размер_выплаты + 100 
WHERE Спортсмен_ид = 1COMMITselect Размер_выплаты from Награды_спортсмен WHERE Спортсмен_ид = 1/*UPDATE Награды_спортсмен SET Размер_выплаты = 1500 
WHERE Спортсмен_ид = 1
*/