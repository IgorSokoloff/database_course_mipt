﻿Set transaction isolation level read uncommitted
--Set transaction isolation level read committed


BEGIN TRANSACTION

UPDATE Награды_спортсмен set Размер_выплаты = Размер_выплаты + 200
where Спортсмен_ид in (1, 2)

COMMIT 
WHERE Спортсмен_ид in (1,2)
*/