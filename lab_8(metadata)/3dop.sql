--таблица fn_dblog понять как в табдлице выташить инофрмацию о пользователе 

SELECT [Transaction SID], [Transaction name], logins.name 
FROM sys.fn_dblog(NULL,NULL) dblog join sys.syslogins logins on dblog.[Transaction SID] = logins.sid
