use lab_3_2
set dateformat dmy

DROP FUNCTION id_of_sex
DROP FUNCTION id_of_country
DROP FUNCTION id_of_city
DROP FUNCTION id_of_street
DROP FUNCTION id_of_place
DROP FUNCTION id_of_type_stage
DROP FUNCTION id_of_spec
DROP FUNCTION id_of_skill
DROP FUNCTION id_of_prize
DROP FUNCTION id_of_player_status
DROP FUNCTION id_of_result
DROP FUNCTION id_of_ligue
DROP FUNCTION id_of_sportsman
DROP FUNCTION id_of_trainer
DROP FUNCTION id_of_judge
DROP FUNCTION id_of_tournament 
DROP FUNCTION id_of_stage
DROP FUNCTION id_of_team
DROP FUNCTION dbo.id_of_game
DROP FUNCTION dbo.id_of_set

IF OBJECT_ID(N'[Мастерство_спортсмен]', N'U') IS NOT NULL
DROP TABLE [Мастерство_спортсмен]
IF OBJECT_ID(N'[Награды_спортсмен]', N'U') IS NOT NULL
DROP TABLE [Награды_спортсмен]

IF OBJECT_ID(N'[Участники]', N'U') IS NOT NULL
DROP TABLE [Участники]
IF OBJECT_ID(N'[Сет_команда]', N'U') IS NOT NULL
DROP TABLE [Сет_команда]
IF OBJECT_ID(N'[Команда_турнир]', N'U') IS NOT NULL
DROP TABLE [Команда_турнир]
IF OBJECT_ID(N'[Состав_команды]', N'U') IS NOT NULL
DROP TABLE [Состав_команды]
IF OBJECT_ID(N'[Игра_команда]', N'U') IS NOT NULL
DROP TABLE [Игра_команда]
IF OBJECT_ID(N'[Игра_судья]', N'U') IS NOT NULL
DROP TABLE [Игра_судья]

IF OBJECT_ID(N'[Стадия_группа]', N'U') IS NOT NULL
DROP TABLE [Стадия_группа]
IF OBJECT_ID(N'[Награды_команда]', N'U') IS NOT NULL
DROP TABLE [Награды_команда]



IF OBJECT_ID(N'[Сет]', N'U') IS NOT NULL
DROP TABLE [Сет]
IF OBJECT_ID(N'[Игра]', N'U') IS NOT NULL
DROP TABLE [Игра]



IF OBJECT_ID(N'[Штраф]', N'U') IS NOT NULL
DROP TABLE [Штраф]
IF OBJECT_ID(N'[Стадия]', N'U') IS NOT NULL
DROP TABLE [Стадия]
IF OBJECT_ID(N'[Тип_стадии]', N'U') IS NOT NULL
DROP TABLE [Тип_стадии]

IF OBJECT_ID(N'[Причина]', N'U') IS NOT NULL
DROP TABLE [Причина]

IF OBJECT_ID(N'[Судья]', N'U') IS NOT NULL
DROP TABLE [Судья]
IF OBJECT_ID(N'[Тренер]', N'U') IS NOT NULL
DROP TABLE [Тренер]
IF OBJECT_ID(N'[Амплуа]', N'U') IS NOT NULL
DROP TABLE [Амплуа]
IF OBJECT_ID(N'[Награда]', N'U') IS NOT NULL
DROP TABLE [Награда]
IF OBJECT_ID(N'[Турнир]', N'U') IS NOT NULL
DROP TABLE [Турнир]
IF OBJECT_ID(N'[Лига]', N'U') IS NOT NULL
DROP TABLE [Лига]

IF OBJECT_ID(N'[Итог]', N'U') IS NOT NULL
DROP TABLE [Итог]
IF OBJECT_ID(N'[Спортсмен_вес_рост]', N'U') IS NOT NULL
DROP TABLE [Спортсмен_вес_рост]
IF OBJECT_ID(N'[Спортсмен]', N'U') IS NOT NULL
DROP TABLE [Спортсмен]
IF OBJECT_ID(N'[Пол]', N'U') IS NOT NULL
DROP TABLE [Пол]
IF OBJECT_ID(N'[Мастерство]', N'U') IS NOT NULL
DROP TABLE [Мастерство]
IF OBJECT_ID(N'[Площадка]', N'U') IS NOT NULL
DROP TABLE [Площадка]
IF OBJECT_ID(N'[Улица]', N'U') IS NOT NULL
DROP TABLE [Улица]
IF OBJECT_ID(N'[Город]', N'U') IS NOT NULL
DROP TABLE [Город]
IF OBJECT_ID(N'[Страна]', N'U') IS NOT NULL
DROP TABLE [Страна]
IF OBJECT_ID(N'[Статус_игрока]', N'U') IS NOT NULL
DROP TABLE [Статус_игрока]
IF OBJECT_ID(N'[Команда]', N'U') IS NOT NULL
DROP TABLE [Команда]

--##################### [Пол] ##################
CREATE TABLE [Пол] (
	Пол_ид		TINYINT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Название	VARCHAR(10) NOT NULL,
);

GO
CREATE FUNCTION dbo.id_of_sex(@sex VARCHAR(10))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Пол_ид FROM [Пол]
WHERE 	Название LIKE @sex
)END;
GO

--##################### [Страна] ##################
CREATE TABLE [Страна] (
	Страна_ид INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Название VARCHAR(20) NOT NULL UNIQUE,
);

GO
CREATE FUNCTION dbo.id_of_country(@name VARCHAR(20))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Страна_ид FROM [Страна]
WHERE 	Название LIKE @name
)END;
GO

--##################### [Город] ##################
CREATE TABLE [Город] (
	Город_ид	INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Страна_ид	INTEGER NOT NULL,--fk
	Название	VARCHAR(180) NOT NULL,
);

GO
CREATE FUNCTION dbo.id_of_city(@name VARCHAR(180))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Город_ид FROM [Город]
WHERE 	Название LIKE @name
)END;
GO


ALTER TABLE [Город]
	ADD CONSTRAINT [Город_fk0] FOREIGN KEY ([Страна_ид])
	REFERENCES [Страна]([Страна_ид])
	ON UPDATE CASCADE
	ON DELETE NO ACTION

--##################### [Улица] ##################
CREATE TABLE [Улица] (
	Улица_ид INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Город_ид INTEGER NOT NULL,--fk
	Название VARCHAR(150) NOT NULL UNIQUE,
);


GO
CREATE FUNCTION dbo.id_of_street(@name VARCHAR(150))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Улица_ид FROM [Улица]
WHERE 	Название LIKE @name
)END;
GO

ALTER TABLE [Улица]  
	ADD CONSTRAINT [Улица_fk0] FOREIGN KEY ([Город_ид])
		REFERENCES [Город]([Город_ид])
		ON UPDATE CASCADE
		ON DELETE NO ACTION

--##################### [Площадка] ##################
CREATE TABLE [Площадка] (
	Площадка_ид		INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Название		VARCHAR(20) NOT NULL,
	Улица_ид		INTEGER NOT NULL,
	Дом				INTEGER NOT NULL,
	Корпус			VARCHAR(3),
);

GO
CREATE FUNCTION dbo.id_of_place(@name VARCHAR(20))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Площадка_ид FROM [Площадка]
WHERE 	Название LIKE @name
)END;
GO

ALTER TABLE [Площадка]ADD CONSTRAINT [Площадка_fk0] 
FOREIGN KEY ([Улица_ид])
REFERENCES [Улица]([Улица_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

--##################### [Тип_стадии] ##################
CREATE TABLE [Тип_стадии] (
	Тип_стадии_ид	TINYINT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Название		VARCHAR(20) NOT NULL,
);

GO
CREATE FUNCTION dbo.id_of_type_stage(@type_name VARCHAR(20))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Тип_стадии_ид FROM [Тип_стадии]
WHERE 	Название LIKE @type_name
)END;
GO

--##################### [Лига] ##################
CREATE TABLE [Лига] (
	Лига_ид		TINYINT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Название	VARCHAR(20) NOT NULL,
);

GO
CREATE FUNCTION dbo.id_of_ligue(@name VARCHAR(20))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT [Лига_ид] FROM [Лига]
WHERE 	Название LIKE @name
)END;
GO


--##################### [Турнир] ##################
CREATE TABLE [Турнир] (
	Турнир_ид	INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Название	VARCHAR(20) NOT NULL,
	Лига_ид		TINYINT,
);

GO
CREATE FUNCTION dbo.id_of_tournament(@ligue TINYINT,@name VARCHAR(20))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Турнир_ид FROM [Турнир]
WHERE 	(Название LIKE @name AND
		 Лига_ид = @ligue
		)
)END;
GO

ALTER TABLE [Турнир] 
ADD CONSTRAINT [Турнир_fk0] FOREIGN KEY ([Лига_ид])
REFERENCES [Лига]([Лига_ид])
ON UPDATE CASCADE
ON DELETE SET NULL

--##################### [Стадия] ##################
CREATE TABLE [Стадия] (
	Стадия_ид		INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Турнир_ид		INTEGER NOT NULL,
	Уровень_стадии	INTEGER NOT NULL,
	Дата_начала		DATE NOT NULL,
	Дата_окончания	DATE NOT NULL,
	Тип_стадии		TINYINT NOT NULL,
	Название		VARCHAR(20),
);

GO
CREATE FUNCTION dbo.id_of_stage(@tournament VARCHAR(20), @level INTEGER,@name VARCHAR(20))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Стадия_ид FROM [Стадия]
WHERE 	(Название LIKE @name AND
		 Уровень_стадии = @level AND
		 Турнир_ид = @tournament
		)
)END;
GO

ALTER TABLE [Стадия]
ADD CONSTRAINT [Стадия_fk0] FOREIGN KEY ([Турнир_ид])
REFERENCES [Турнир]([Турнир_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Стадия]
ADD CONSTRAINT [Стадия_fk1] FOREIGN KEY ([Тип_стадии])
REFERENCES [Тип_стадии]([Тип_стадии_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Стадия]
ADD CONSTRAINT check_date
CHECK ([Дата_начала] BETWEEN '01-01-2004' AND [Дата_окончания])

--##################### [Игра] ##################
CREATE TABLE [Игра] (
	Игра_ид			 INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Дата_проведения	 DATETIME NOT NULL,
	Место_проведения INTEGER NOT NULL,
	Стадия_ид		 INTEGER NOT NULL,
	Номер_тура		 SMALLINT NOT NULL,
	Название		 VARCHAR (20),
);

GO
CREATE FUNCTION dbo.id_of_game(@name VARCHAR(20),@tour INTEGER, @stage INTEGER)
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Игра_ид FROM [Игра]
WHERE 	(Название LIKE @name AND
		Номер_тура =  @tour AND
		Стадия_ид = @stage
		)
)END;
GO

ALTER TABLE [Игра] 
ADD CONSTRAINT [Игра_fk0] FOREIGN KEY ([Место_проведения])
REFERENCES [Площадка]([Площадка_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Игра]  
ADD CONSTRAINT [Игра_fk1] FOREIGN KEY ([Стадия_ид])
REFERENCES [Стадия]([Стадия_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Игра] 
ADD CONSTRAINT [check_game]
CHECK ([Дата_проведения]>'01-01-2004' AND
	   [Номер_тура]>0
	  );

--##################### Спортсмен ##################
CREATE TABLE [Спортсмен] (
	Спортсмен_ид			INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Имя						VARCHAR(20) NOT NULL,
	Фамилия					VARCHAR(20) NOT NULL,
	Отчество				VARCHAR(20) NOT NULL,
	Дата_рождения			DATE NOT NULL,
	Пол_ид					TINYINT,--fk
	Пасспорт_серия_номер	VARCHAR(10),
	Телефон_дом				VARCHAR(12),
	Телефон_моб				VARCHAR(12),
	Эл_почта				VARCHAR(256),
	Улица_ид				INTEGER,--fk
	Дом						VARCHAR(10),
	Корпус					VARCHAR(3) default 1,
	Свидетельство_о_рождении VARCHAR(10),
);

GO
CREATE FUNCTION dbo.id_of_sportsman(@surname VARCHAR(20),@name VARCHAR(20), @fathername VARCHAR(20), @birth_date DATE)
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Спортсмен_ид FROM [Спортсмен]
WHERE 	(Имя LIKE @name AND
		Фамилия LIKE @surname AND
		Отчество LIKE @fathername AND
		Дата_рождения = @birth_date
		)
)END;
GO

ALTER TABLE [Спортсмен]
	ADD CONSTRAINT [Спортсмен_fk0] FOREIGN KEY ([Пол_ид]) 
		REFERENCES [Пол]([Пол_ид])
		ON UPDATE CASCADE
		ON DELETE NO ACTION

ALTER TABLE [Спортсмен] 
	ADD CONSTRAINT [Спортсмен_fk1] FOREIGN KEY ([Улица_ид])
		REFERENCES [Улица]([Улица_ид])
		ON UPDATE CASCADE
		ON DELETE NO ACTION

ALTER TABLE [Спортсмен]
	ADD CONSTRAINT age_sportsmen
	CHECK ([Дата_Рождения]>'01-01-1870');

--##################### [Тренер] ##################
CREATE TABLE [Тренер] (
	Тренер_ид				INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Имя						VARCHAR(20) NOT NULL,
	Фамилия					VARCHAR(20) NOT NULL,
	Отчество				VARCHAR(20) NOT NULL,
	Пол_ид					TINYINT NOT NULL,--fk
	Дата_рождения			DATE NOT NULL,
	Пасспорт_серия_номер 	VARCHAR(10),
	Телефон_дом				VARCHAR(12),
	Телефон_моб				VARCHAR(12),
	Эл_почта				VARCHAR(256),
	Улица_ид				INTEGER,--fk
	Дом						VARCHAR(10),
	Корпус					VARCHAR(3),
);

GO
CREATE FUNCTION dbo.id_of_trainer(@name VARCHAR(20), @surname VARCHAR(20), @fathername VARCHAR(20), @birth_date DATE)
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Тренер_ид FROM [Тренер]
WHERE 	(Имя LIKE @name AND
		Фамилия LIKE @surname AND
		Отчество LIKE @fathername AND
		Дата_рождения = @birth_date
		)
)END;
GO


ALTER TABLE [Тренер]
	ADD CONSTRAINT [Тренер_fk0]
		FOREIGN KEY ([Пол_ид])REFERENCES [Пол]([Пол_ид])
		ON UPDATE CASCADE
		ON DELETE NO ACTION

ALTER TABLE [Тренер]
	ADD CONSTRAINT [Тренер_fk1] 
		FOREIGN KEY ([Улица_ид])REFERENCES [Улица]([Улица_ид])
		ON UPDATE CASCADE
		ON DELETE NO ACTION

ALTER TABLE [Тренер]
	ADD CONSTRAINT age_trainer
	CHECK ([Дата_Рождения]>'01-01-1870');



--##################### [Амплуа] ##################
CREATE TABLE [Амплуа] (
	Амплуа_ид TINYINT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Название  VARCHAR(25) NOT NULL,
);

GO
CREATE FUNCTION dbo.id_of_spec(@name VARCHAR(25))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Амплуа_ид FROM [Амплуа]
WHERE 	Название LIKE @name
)END;
GO

--##################### [Команда] ##################
CREATE TABLE [Команда] (
	Команда_ид INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Название VARCHAR(30) NOT NULL,

);

GO
CREATE FUNCTION dbo.id_of_team(@name VARCHAR(30))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Команда_ид FROM [Команда]
WHERE 	Название LIKE @name
)END;
GO

--##################### [Мастерство] ##################
CREATE TABLE [Мастерство] (
	Мастерство_ид TINYINT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Название VARCHAR(20) NOT NULL,
);

GO
CREATE FUNCTION dbo.id_of_skill(@name VARCHAR(20))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Мастерство_ид FROM [Мастерство]
WHERE 	Название LIKE @name
)END;
GO

--##################### [Мастерство_спортсмен] ##################
CREATE TABLE [Мастерство_спортсмен] (
	Спортсмен_ид INTEGER NOT NULL,--fk
	Дата_присвоения DATE NOT NULL,
	Мастерство_ид TINYINT ,--fk
	PRIMARY KEY (Спортсмен_ид, Дата_присвоения)
);

ALTER TABLE [Мастерство_спортсмен]
ADD CONSTRAINT [Мастерство_спортсмен_fk0] FOREIGN KEY ([Спортсмен_ид]) 
REFERENCES [Спортсмен]([Спортсмен_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Мастерство_спортсмен]  
ADD CONSTRAINT [Мастерство_спортсмен_fk2] FOREIGN KEY ([Мастерство_ид])
REFERENCES [Мастерство]([Мастерство_ид])
ON UPDATE CASCADE
ON DELETE SET NULL

ALTER TABLE [Мастерство_спортсмен]
ADD CONSTRAINT [date_check]
CHECK ([Дата_присвоения]>'01-01-1870')


--##################### [Награда] ##################
CREATE TABLE [Награда] (
	Награда_ид	INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Название	VARCHAR(100) NOT NULL,
);

GO
CREATE FUNCTION dbo.id_of_prize(@name VARCHAR(50))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Награда_ид FROM [Награда]
WHERE 	Название LIKE @name
)END;
GO

--##################### [Награды_спортсмен] ##################
CREATE TABLE [Награды_спортсмен] (
	Спортсмен_ид	INTEGER NOT NULL,
	Награда_ид		INTEGER NOT NULL,
	Дата_привоения	DATE    NOT NULL,
	Турнир_ид		INTEGER NOT NULL,
	Размер_выплаты	MONEY NOT NULL default (0),
  PRIMARY KEY(Спортсмен_ид, Награда_ид, Дата_привоения)

);

ALTER TABLE [Награды_спортсмен]  
ADD CONSTRAINT [Награды_спортсмен_fk0] FOREIGN KEY ([Спортсмен_ид]) 
REFERENCES [Спортсмен]([Спортсмен_ид])
ON UPDATE CASCADE
ON DELETE CASCADE

ALTER TABLE [Награды_спортсмен] 
ADD CONSTRAINT [Награды_спортсмен_fk1] FOREIGN KEY ([Награда_ид])
REFERENCES [Награда]([Награда_ид])
ON UPDATE CASCADE
ON DELETE CASCADE

ALTER TABLE [Награды_спортсмен]
ADD CONSTRAINT [Награды_спортсмен_fk2] FOREIGN KEY ([Турнир_ид])
REFERENCES [Турнир]([Турнир_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE[Награды_спортсмен]
ADD CONSTRAINT check_prize
CHECK (Размер_выплаты>=0 AND
	   [Дата_привоения]>'01-01-2004'
	  )


--##################### [Статус_игрока] ##################
CREATE TABLE [Статус_игрока] (
	Статус_ид	TINYINT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Название	VARCHAR(20) NOT NULL,
);

GO
CREATE FUNCTION dbo.id_of_player_status(@name VARCHAR(20))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Статус_ид FROM [Статус_игрока]
WHERE 	Название LIKE @name
)END;
GO


--##################### [Участники] ##################
CREATE TABLE [Участники] (
	Спортсмен_ид	INTEGER NOT NULL,
	Турнир_ид		INTEGER NOT NULL,
	Команда_ид		INTEGER NOT NULL,
	Номер			TINYINT NOT NULL,
   PRIMARY KEY (Спортсмен_ид, Турнир_ид)
);


ALTER TABLE [Участники] 
ADD CONSTRAINT [Участники_fk0] FOREIGN KEY ([Спортсмен_ид])
REFERENCES [Спортсмен]([Спортсмен_ид])
ON UPDATE CASCADE
ON DELETE CASCADE

ALTER TABLE [Участники] 
ADD CONSTRAINT [Участники_fk1] FOREIGN KEY ([Турнир_ид]) 
REFERENCES [Турнир]([Турнир_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Участники] 
ADD CONSTRAINT [Участники_fk2] FOREIGN KEY ([Команда_ид])
REFERENCES [Команда]([Команда_ид])
ON UPDATE CASCADE
ON DELETE CASCADE



--##################### [Итог] ##################
CREATE TABLE [Итог] (
	Итог_ид		TINYINT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Название	VARCHAR(20) NOT NULL,
);


GO
CREATE FUNCTION dbo.id_of_result(@name VARCHAR(20))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Итог_ид FROM [Итог]
WHERE 	Название LIKE @name
)END;
GO


--##################### [Сет] ##################
CREATE TABLE [Сет] (
	Сет_ид		 INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Номер		 TINYINT NOT NULL,
	Игра_ид		 INTEGER NOT NULL,
	Длительность TIME NOT NULL,
);

GO
CREATE FUNCTION dbo.id_of_set(@game INTEGER, @number TINYINT)
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Сет_ид FROM [Сет]
WHERE 	(Игра_ид LIKE @game AND
		 Номер = @number 
		)
)END;
GO


ALTER TABLE [Сет]
ADD CONSTRAINT [Сет_fk0] FOREIGN KEY ([Игра_ид])
REFERENCES [Игра]([Игра_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION



--##################### [Сет_команда] ##################
CREATE TABLE [Сет_команда] (
	Команда_ид	INTEGER NOT NULL,
	Сет_ид		INTEGER NOT NULL,
	Счет		TINYINT NOT NULL,
	Итог		TINYINT NOT NULL,
    PRIMARY KEY (Команда_ид, Сет_ид)
);

ALTER TABLE [Сет_команда] 
ADD CONSTRAINT [Сет_команда_fk0] FOREIGN KEY ([Команда_ид]) 
REFERENCES [Команда]([Команда_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Сет_команда] 
ADD CONSTRAINT [Сет_команда_fk1] FOREIGN KEY ([Сет_ид])
REFERENCES [Сет]([Сет_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Сет_команда]  
ADD CONSTRAINT [Сет_команда_fk2] FOREIGN KEY ([Итог])
REFERENCES [Итог]([Итог_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION


--##################### [Награды_команда] ##################
CREATE TABLE [Награды_команда] (
	Команда_ид		INTEGER NOT NULL,
	Награда_ид		INTEGER NOT NULL,
	Дата_привоения	DATE NOT NULL,
	Турнир_ид		INTEGER NOT NULL,
	PRIMARY KEY (Команда_ид, Награда_ид, Дата_привоения)
);

ALTER TABLE [Награды_команда] 
ADD CONSTRAINT [Награды_команда_fk0] FOREIGN KEY ([Команда_ид])
REFERENCES [Команда]([Команда_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Награды_команда]  
ADD CONSTRAINT [Награды_команда_fk1] FOREIGN KEY ([Награда_ид])
REFERENCES [Награда]([Награда_ид])
ON UPDATE CASCADE
ON DELETE CASCADE

ALTER TABLE [Награды_команда] 
ADD CONSTRAINT [Награды_команда_fk2] FOREIGN KEY ([Турнир_ид]) 
REFERENCES [Турнир]([Турнир_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION


--##################### [Спортсмен_вес_рост] ##################
CREATE TABLE [Спортсмен_вес_рост] (
	Спортсмен_ид	INTEGER NOT NULL,
	Дата			DATE NOT NULL,
	Рост			SMALLINT NOT NULL,
	Вес				TINYINT NOT NULL,
	PRIMARY KEY(Спортсмен_ид, Дата)
);


ALTER TABLE [Спортсмен_вес_рост] 
ADD CONSTRAINT [Спортсмен_вес_рост_fk0] FOREIGN KEY ([Спортсмен_ид])
REFERENCES [Спортсмен]([Спортсмен_ид])
ON UPDATE CASCADE
ON DELETE CASCADE

ALTER TABLE [Спортсмен_вес_рост]
ADD CONSTRAINT check_hight
CHECK (Рост<=300)


--##################### [Команда_турнир] ##################
CREATE TABLE [Команда_турнир] (
	Турнир_ид	INTEGER NOT NULL,
	Команда_ид	INTEGER NOT NULL,
	Капитан_ид	INTEGER NOT NULL,
	Тренер_ид	INTEGER,
	Место		TINYINT NOT NULL,
	PRIMARY KEY (Турнир_ид, Команда_ид)
);

ALTER TABLE [Команда_турнир] 
ADD CONSTRAINT [Команда_турнир_fk0] FOREIGN KEY ([Турнир_ид])
REFERENCES [Турнир]([Турнир_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION


ALTER TABLE [Команда_турнир] 
ADD CONSTRAINT [Команда_турнир_fk1] FOREIGN KEY ([Команда_ид])
REFERENCES [Команда]([Команда_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Команда_турнир]
ADD CONSTRAINT [Команда_турнир_fk2] FOREIGN KEY ([Капитан_ид])
REFERENCES [Спортсмен]([Спортсмен_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Команда_турнир]
ADD CONSTRAINT [Команда_турнир_fk3] FOREIGN KEY ([Тренер_ид])
REFERENCES [Тренер]([Тренер_ид])
ON UPDATE NO ACTION
ON DELETE NO ACTION


--##################### [Состав_команды] ##################
CREATE TABLE [Состав_команды] (
	Игра_ид		 INTEGER NOT NULL,
	Спортсмен_ид INTEGER NOT NULL,
	Амплуа		 TINYINT NOT NULL,
	Статус_ид	 TINYINT NOT NULL,
	PRIMARY KEY(Игра_ид, Спортсмен_ид)
);
ALTER TABLE [Состав_команды] 
ADD CONSTRAINT [Состав_команды_fk0] FOREIGN KEY ([Игра_ид]) 
REFERENCES [Игра]([Игра_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Состав_команды] 
ADD CONSTRAINT [Состав_команды_fk1] FOREIGN KEY ([Спортсмен_ид])
REFERENCES [Спортсмен]([Спортсмен_ид])
ON UPDATE NO ACTION
ON DELETE NO ACTION

ALTER TABLE [Состав_команды] 
ADD CONSTRAINT [Состав_команды_fk2] FOREIGN KEY ([Амплуа])
REFERENCES [Амплуа]([Амплуа_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Состав_команды] 
ADD CONSTRAINT [Состав_команды_fk3] FOREIGN KEY ([Статус_ид])
REFERENCES [Статус_игрока]([Статус_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION


--##################### [Игра_команда] ##################
CREATE TABLE [Игра_команда] (
	Команда_ид	INTEGER NOT NULL,
	Игра_ид		INTEGER NOT NULL,
	Итог		TINYINT NOT NULL,
	Очки		TINYINT NOT NULL,
	PRIMARY KEY (Команда_ид, Игра_ид)
	);

ALTER TABLE [Игра_команда]
ADD CONSTRAINT [Игра_команда_fk0] FOREIGN KEY ([Команда_ид])
REFERENCES [Команда]([Команда_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Игра_команда]
ADD CONSTRAINT [Игра_команда_fk1] FOREIGN KEY ([Игра_ид])
REFERENCES [Игра]([Игра_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Игра_команда]
ADD CONSTRAINT [Игра_команда_fk2] FOREIGN KEY ([Итог])
REFERENCES [Итог]([Итог_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

--##################### [Причина] ##################
CREATE TABLE [Причина] (
	Причина_ид TINYINT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Формулировка VARCHAR(50) NOT NULL,
);

--##################### [Штраф] ##################
CREATE TABLE [Штраф] (
	Штраф_ид	INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Стадия_ид	INTEGER NOT NULL,
	Команда_ид	INTEGER NOT NULL,
	Размер		INTEGER NOT NULL,
	Причина_ид	TINYINT NOT NULL,
);


ALTER TABLE [Штраф] 
ADD CONSTRAINT [Штраф_fk0] FOREIGN KEY ([Стадия_ид])
REFERENCES [Стадия]([Стадия_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Штраф]
ADD CONSTRAINT [Штраф_fk1] FOREIGN KEY ([Команда_ид])
REFERENCES [Команда]([Команда_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Штраф] 
ADD CONSTRAINT [Штраф_fk2] FOREIGN KEY ([Причина_ид])
REFERENCES [Причина]([Причина_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION


--##################### [Судья] ##################
CREATE TABLE [Судья] (
	Судья_ид			 INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Имя					 VARCHAR(20) NOT NULL,
	Фамилия				 VARCHAR(20) NOT NULL,
	Отчество			 VARCHAR(20) NOT NULL,
	Пол_ид				 TINYINT NOT NULL,
	Дата_рождения		 DATE,
	Пасспорт_серия_номер VARCHAR(10),
	Улица_ид			 INTEGER,
	Дом					 VARCHAR(10),
	Корпус				 VARCHAR(3),
	Телефон_дом			 VARCHAR(12),
	Телефон_моб			 VARCHAR(12),
	Эл_почта			 VARCHAR(256),
);
GO
CREATE FUNCTION dbo.id_of_judge(@surname VARCHAR(20),@name VARCHAR(20), @fathername VARCHAR(20))
RETURNS INTEGER
AS
BEGIN
RETURN 
(SELECT Судья_ид FROM [Судья]
WHERE 	(Имя LIKE @name AND
		Фамилия LIKE @surname AND
		Отчество LIKE @fathername
		)
)END;
GO

ALTER TABLE [Судья]
ADD CONSTRAINT [Судья_fk0] FOREIGN KEY ([Пол_ид])
REFERENCES [Пол]([Пол_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Судья] 
ADD CONSTRAINT [Судья_fk1] FOREIGN KEY ([Улица_ид])
REFERENCES [Улица]([Улица_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION


--##################### [Игра_судья] ##################
CREATE TABLE [Игра_судья] (
	Капитан_ид	INTEGER NOT NULL,
	Судья_ид	INTEGER NOT NULL,
	Игра_ид		INTEGER NOT NULL,
	Оценка		TINYINT NOT NULL,
    PRIMARY KEY (Капитан_ид, Судья_ид, Игра_ид )

);

ALTER TABLE [Игра_судья] 
ADD CONSTRAINT [Игра_судья_fk0] FOREIGN KEY ([Капитан_ид])
REFERENCES [Спортсмен]([Спортсмен_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Игра_судья] 
ADD CONSTRAINT [Игра_судья_fk1] FOREIGN KEY ([Судья_ид])
REFERENCES [Судья]([Судья_ид])
ON UPDATE NO ACTION
ON DELETE NO ACTION

ALTER TABLE [Игра_судья]  
ADD CONSTRAINT [Игра_судья_fk2] FOREIGN KEY ([Игра_ид]) 
REFERENCES [Игра]([Игра_ид])
ON UPDATE NO ACTION
ON DELETE NO ACTION


--##################### [Стадия_группа] ##################
CREATE TABLE [Стадия_группа] (
	Команда_ид	INTEGER NOT NULL,
	Стадия_ид	INTEGER NOT NULL,
	Место		TINYINT NOT NULL,
	PRIMARY KEY (Команда_ид, Стадия_ид)
);

ALTER TABLE [Стадия_группа] 
ADD CONSTRAINT [Стадия_группа_fk0] FOREIGN KEY ([Команда_ид]) 
REFERENCES [Команда]([Команда_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION

ALTER TABLE [Стадия_группа] 
ADD CONSTRAINT [Стадия_группа_fk1] FOREIGN KEY ([Стадия_ид]) 
REFERENCES [Стадия]([Стадия_ид])
ON UPDATE CASCADE
ON DELETE NO ACTION