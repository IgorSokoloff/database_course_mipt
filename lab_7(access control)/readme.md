## 7. Управление доступом

* В среде Microsoft Enterprise Manager был создан пользователь test/test. Необходимо дать ему доступ к локальной базе данных (назначить ему роль уровня базы данных public).
* В среде Microsoft Query Analyzer выполнить скрипты присвоения новому пользователю прав доступа к таблицам, созданным в лабораторной работе №2. При этом права доступа к различным таблицам должны быть различными, а именно:
  * по крайней мере для одной таблицы новому пользователю присваиваются права SELECT, INSERT, UPDATE в полном объеме
  * по крайней мере для одной таблицы новому пользователю присваиваются права SELECT и UPDATE только избранных столбцов.
  * по крайней мере для одной таблицы новому пользователю присваивается только право SELECT.
* В среде Microsoft Enterprise Manager присвоить новому пользователю право доступа (SELECT) к представлению, созданному в лабораторной работе №4.
* В среде Microsoft Enterprise Manager создать стандартную роль уровня базы данных, присвоить ей право доступа (UPDATE на некоторые столбцы) к представлению, созданному в лабораторной работе №4, назначить новому пользователю созданную роль.
* В среде Microsoft Query Analyzer соединиться с локальной базой данных под именем нового пользователя.
* Выполнить от имени нового пользователя некоторые выборки из таблиц и представления, подготовленные для лабораторных работ №2,4. Убедиться в правильности контроля прав доступа.
* Выполнить от имени нового пользователя операторы изменения таблиц с ограниченными правами доступа. Убедиться в правильности контроля прав доступа. 
