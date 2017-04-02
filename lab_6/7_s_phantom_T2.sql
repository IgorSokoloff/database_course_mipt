SET TRANSACTION ISOLATION LEVEL SERIALIZABLEBEGIN TRANSACTION 
INSERT INTO Награда (Название) values ('Новая_награда')COMMITselect * from Награда/*delete from Награда where Награда_ид>3dbcc checkident(Награда, RESEED ,3)INSERT INTO Награда (Название) VALUES ('1 место в турнире сезона 2016-2017')
INSERT INTO Награда (Название) VALUES ('2 место в турнире сезона 2016-2017')
INSERT INTO Награда (Название) VALUES ('3 место в турнире сезона 2016-2017')*/