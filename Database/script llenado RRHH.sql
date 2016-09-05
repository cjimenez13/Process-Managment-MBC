USE RRHH;
go 
--DBCC CHECKIDENT (ObjectLog, RESEED, 0)

-- ObjectLog
-- delete from ObjectLog
declare cursor_insertObjectLog cursor
for select TABLE_NAME from RRHH.INFORMATION_SCHEMA.TABLES where TABLE_TYPE = 'BASE TABLE';
declare @table_name nvarchar(30);
open cursor_insertObjectLog
fetch next from cursor_insertObjectLog into @table_name
while @@FETCH_STATUS = 0 
begin 
	execute sp_insert_ObjectLog @table_name
	fetch next from cursor_insertObjectLog into @table_name
end
close cursor_insertObjectLog
deallocate cursor_insertObjectLog

-- EventSourceLog
-- delete from EventSourceLog
execute sp_insert_EventSourceLog 'insert';
execute sp_insert_EventSourceLog 'update';
execute sp_insert_EventSourceLog 'delete';

--EventTypeLog
execute sp_insert_EventTypeLog 'success';
execute sp_insert_EventTypeLog 'error';
execute sp_insert_EventTypeLog 'warning';


--Provincias
insert into Provinces (id_province, name) values (1,'San José')
insert into Provinces (id_province, name) values (2,'Alajuela')
insert into Provinces (id_province, name) values (3,'Cartago')
insert into Provinces (id_province, name) values (4,'Heredia')
insert into Provinces (id_province, name) values (5,'Guanacaste')
insert into Provinces (id_province, name) values (6,'Puntarenas')
insert into Provinces (id_province, name) values (7,'Limon')

-- Cantones
--DBCC CHECKIDENT (Cantones, RESEED, 0)
insert into Cantones(name, province_id) values ('San José',1);
insert into Cantones(name, province_id) values ('Escazú',1);
insert into Cantones(name, province_id) values ('Desamparados',1);
insert into Cantones(name, province_id) values ('Puriscal',1);
insert into Cantones(name, province_id) values ('Tarrazú',1);
insert into Cantones(name, province_id) values ('Aserri',1);
insert into Cantones(name, province_id) values ('Mora',1);
insert into Cantones(name, province_id) values ('Goicoechea',1);
insert into Cantones(name, province_id) values ('Santa Ana',1);
insert into Cantones(name, province_id) values ('Alajuelita',1);
insert into Cantones(name, province_id) values ('Vázques de Coronado',1);
insert into Cantones(name, province_id) values ('Acosta',1);
insert into Cantones(name, province_id) values ('Tibas',1);
insert into Cantones(name, province_id) values ('Moravia',1);
insert into Cantones(name, province_id) values ('Montes de Oca',1);
insert into Cantones(name, province_id) values ('Turrubares',1);
insert into Cantones(name, province_id) values ('Dota',1);
insert into Cantones(name, province_id) values ('Curridabat',1);
insert into Cantones(name, province_id) values ('Pérez Zeledón',1);
insert into Cantones(name, province_id) values ('Alajuela',2);
insert into Cantones(name, province_id) values ('San Ramón',2);
insert into Cantones(name, province_id) values ('Grecia',2);
insert into Cantones(name, province_id) values ('San Mateo',2);
insert into Cantones(name, province_id) values ('Atenas',2);
insert into Cantones(name, province_id) values ('Naranjo',2);
insert into Cantones(name, province_id) values ('Palmares',2);
insert into Cantones(name, province_id) values ('Poás',2);
insert into Cantones(name, province_id) values ('Orotina',2);
insert into Cantones(name, province_id) values ('San Carlos',2);
insert into Cantones(name, province_id) values ('Zarcero',2);
insert into Cantones(name, province_id) values ('Valverde Vega',2);
insert into Cantones(name, province_id) values ('Upala',2);
insert into Cantones(name, province_id) values ('Los Chiles',2);
insert into Cantones(name, province_id) values ('Guatuso',2);
insert into Cantones(name, province_id) values ('Cartago',3);
insert into Cantones(name, province_id) values ('Paraíso',3);
insert into Cantones(name, province_id) values ('La Unión',3);
insert into Cantones(name, province_id) values ('Jiménez',3);
insert into Cantones(name, province_id) values ('Turrialba',3);
insert into Cantones(name, province_id) values ('Alvarado',3);
insert into Cantones(name, province_id) values ('Oreamuno',3);
insert into Cantones(name, province_id) values ('El guarco',3);
insert into Cantones(name, province_id) values ('Heredia',4);
insert into Cantones(name, province_id) values ('Barva',4);
insert into Cantones(name, province_id) values ('Santo Domingo',4);
insert into Cantones(name, province_id) values ('Santa Bárvara',4);
insert into Cantones(name, province_id) values ('San Rafael',4);
insert into Cantones(name, province_id) values ('San Isidro',4);
insert into Cantones(name, province_id) values ('Belen',4);
insert into Cantones(name, province_id) values ('Flores',4);
insert into Cantones(name, province_id) values ('San Pablo',4);
insert into Cantones(name, province_id) values ('Sarapiquí',4);
insert into Cantones(name, province_id) values ('Liberia',5);
insert into Cantones(name, province_id) values ('Nicoya',5);
insert into Cantones(name, province_id) values ('Santa Cruz',5);
insert into Cantones(name, province_id) values ('Bagaces',5);
insert into Cantones(name, province_id) values ('Carrillo',5);
insert into Cantones(name, province_id) values ('Cañas',5);
insert into Cantones(name, province_id) values ('Abangares',5);
insert into Cantones(name, province_id) values ('Tilarán',5);
insert into Cantones(name, province_id) values ('Nandayure',5);
insert into Cantones(name, province_id) values ('La Cruz',5);
insert into Cantones(name, province_id) values ('Hojancha',5);
insert into Cantones(name, province_id) values ('Puntarenas',6);
insert into Cantones(name, province_id) values ('Esparza',6);
insert into Cantones(name, province_id) values ('Buenos Aires',6);
insert into Cantones(name, province_id) values ('Montes de Oro',6);
insert into Cantones(name, province_id) values ('Osa',6);
insert into Cantones(name, province_id) values ('Quepos',6);
insert into Cantones(name, province_id) values ('Golfito',6);
insert into Cantones(name, province_id) values ('Coto Brus',6);
insert into Cantones(name, province_id) values ('Parrita',6);
insert into Cantones(name, province_id) values ('Corredores',6);
insert into Cantones(name, province_id) values ('Garabito',6);
insert into Cantones(name, province_id) values ('Limón',7);
insert into Cantones(name, province_id) values ('Pococí',7);
insert into Cantones(name, province_id) values ('Siquirres',7);
insert into Cantones(name, province_id) values ('Talamanca',7);
insert into Cantones(name, province_id) values ('Matina',7);
insert into Cantones(name, province_id) values ('Guácimo',7);





-- Tipos de Notificaciones
insert into Notifications_Types(id_Notification, id_type) values (1,'Telegram')
insert into Notifications_Types(id_Notification, id_type) values (1,'Correo')
insert into Notifications_Types(id_Notification, id_type) values (1,'Notificación interna')

--Usuarios
--delete from Users;
execute sp_insert_User @name='Christian', @fLastName='Jimenez', @email='cjimenez13@outlook.com', @password='Password12', @birthdate='13/06/1995', 
@phoneNumber='83369277', @direction= 'De la eentrada de las azaleas 500 al este', @id = 116080577, @sLastName = 'Céspedes', @username = 'cjimenez13';
execute sp_insert_User @name='Yorley', @fLastName='Aguilar', @email='yorley_maria96@gmail.com', @password='Password12';

delete from Users
select * from Users;










