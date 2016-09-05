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
insert into Provinces (id_province, name) values (1,'San Jos�')
insert into Provinces (id_province, name) values (2,'Alajuela')
insert into Provinces (id_province, name) values (3,'Cartago')
insert into Provinces (id_province, name) values (4,'Heredia')
insert into Provinces (id_province, name) values (5,'Guanacaste')
insert into Provinces (id_province, name) values (6,'Puntarenas')
insert into Provinces (id_province, name) values (7,'Limon')

-- Cantones
--DBCC CHECKIDENT (Cantones, RESEED, 0)
insert into Cantones(name, province_id) values ('San Jos�',1);
insert into Cantones(name, province_id) values ('Escaz�',1);
insert into Cantones(name, province_id) values ('Desamparados',1);
insert into Cantones(name, province_id) values ('Puriscal',1);
insert into Cantones(name, province_id) values ('Tarraz�',1);
insert into Cantones(name, province_id) values ('Aserri',1);
insert into Cantones(name, province_id) values ('Mora',1);
insert into Cantones(name, province_id) values ('Goicoechea',1);
insert into Cantones(name, province_id) values ('Santa Ana',1);
insert into Cantones(name, province_id) values ('Alajuelita',1);
insert into Cantones(name, province_id) values ('V�zques de Coronado',1);
insert into Cantones(name, province_id) values ('Acosta',1);
insert into Cantones(name, province_id) values ('Tibas',1);
insert into Cantones(name, province_id) values ('Moravia',1);
insert into Cantones(name, province_id) values ('Montes de Oca',1);
insert into Cantones(name, province_id) values ('Turrubares',1);
insert into Cantones(name, province_id) values ('Dota',1);
insert into Cantones(name, province_id) values ('Curridabat',1);
insert into Cantones(name, province_id) values ('P�rez Zeled�n',1);
insert into Cantones(name, province_id) values ('Alajuela',2);
insert into Cantones(name, province_id) values ('San Ram�n',2);
insert into Cantones(name, province_id) values ('Grecia',2);
insert into Cantones(name, province_id) values ('San Mateo',2);
insert into Cantones(name, province_id) values ('Atenas',2);
insert into Cantones(name, province_id) values ('Naranjo',2);
insert into Cantones(name, province_id) values ('Palmares',2);
insert into Cantones(name, province_id) values ('Po�s',2);
insert into Cantones(name, province_id) values ('Orotina',2);
insert into Cantones(name, province_id) values ('San Carlos',2);
insert into Cantones(name, province_id) values ('Zarcero',2);
insert into Cantones(name, province_id) values ('Valverde Vega',2);
insert into Cantones(name, province_id) values ('Upala',2);
insert into Cantones(name, province_id) values ('Los Chiles',2);
insert into Cantones(name, province_id) values ('Guatuso',2);
insert into Cantones(name, province_id) values ('Cartago',3);
insert into Cantones(name, province_id) values ('Para�so',3);
insert into Cantones(name, province_id) values ('La Uni�n',3);
insert into Cantones(name, province_id) values ('Jim�nez',3);
insert into Cantones(name, province_id) values ('Turrialba',3);
insert into Cantones(name, province_id) values ('Alvarado',3);
insert into Cantones(name, province_id) values ('Oreamuno',3);
insert into Cantones(name, province_id) values ('El guarco',3);
insert into Cantones(name, province_id) values ('Heredia',4);
insert into Cantones(name, province_id) values ('Barva',4);
insert into Cantones(name, province_id) values ('Santo Domingo',4);
insert into Cantones(name, province_id) values ('Santa B�rvara',4);
insert into Cantones(name, province_id) values ('San Rafael',4);
insert into Cantones(name, province_id) values ('San Isidro',4);
insert into Cantones(name, province_id) values ('Belen',4);
insert into Cantones(name, province_id) values ('Flores',4);
insert into Cantones(name, province_id) values ('San Pablo',4);
insert into Cantones(name, province_id) values ('Sarapiqu�',4);
insert into Cantones(name, province_id) values ('Liberia',5);
insert into Cantones(name, province_id) values ('Nicoya',5);
insert into Cantones(name, province_id) values ('Santa Cruz',5);
insert into Cantones(name, province_id) values ('Bagaces',5);
insert into Cantones(name, province_id) values ('Carrillo',5);
insert into Cantones(name, province_id) values ('Ca�as',5);
insert into Cantones(name, province_id) values ('Abangares',5);
insert into Cantones(name, province_id) values ('Tilar�n',5);
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
insert into Cantones(name, province_id) values ('Lim�n',7);
insert into Cantones(name, province_id) values ('Pococ�',7);
insert into Cantones(name, province_id) values ('Siquirres',7);
insert into Cantones(name, province_id) values ('Talamanca',7);
insert into Cantones(name, province_id) values ('Matina',7);
insert into Cantones(name, province_id) values ('Gu�cimo',7);





-- Tipos de Notificaciones
insert into Notifications_Types(id_Notification, id_type) values (1,'Telegram')
insert into Notifications_Types(id_Notification, id_type) values (1,'Correo')
insert into Notifications_Types(id_Notification, id_type) values (1,'Notificaci�n interna')

--Usuarios
--delete from Users;
execute sp_insert_User @name='Christian', @fLastName='Jimenez', @email='cjimenez13@outlook.com', @password='Password12', @birthdate='13/06/1995', 
@phoneNumber='83369277', @direction= 'De la eentrada de las azaleas 500 al este', @id = 116080577, @sLastName = 'C�spedes', @username = 'cjimenez13';
execute sp_insert_User @name='Yorley', @fLastName='Aguilar', @email='yorley_maria96@gmail.com', @password='Password12';

delete from Users
select * from Users;
execute sp_update_userPhoto @user = 'cjimenez13', @photoData = 0xFFD8FFE000104A46494600010100000100010000FFDB0084000906070F0E0F0F0F0E0F0F0F0F0F0F0F0D0F0F0F0F0F100F0F0F1511161615111515181D2820181A251B151521312125292B2E2E2E171F3338332C37282D2E2B010A0A0A0D0D0D0F0D0D0F2B191F192B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2BFFC000110800E000E003012200021101031101FFC4001B00010100030101010000000000000000000001020405030607FFC400301001000200020804060105000000000000000102031104051221314151C13261719122427281A1E1D113526292F0FFC4001501010100000000000000000000000000000001FFC40014110100000000000000000000000000000000FFDA000C03010002110311003F00FD700540000000000000000000000000000000000000000000000000000000000141054000000000000000000000000000000001E3A4E935C38CEDC794739907ADAD1119CCC4447199E0D1C7D6958DD48DAF39DD0E6E93A4DB1273B4EEE558E10F106DE26B0C5B7CDB3F4C64F09C7BCF1BDFFDA5E628F48C7BC70BDFFDA5EF87AC316BF36D7D519B500763035A56775E367CE37C37AB6898CE26262784C707CCBDB46D26D8739D67773ACF0941F423C745D26B8919D78F38E712F60000000000000000000000000618F8D14ACDA7847E67A3E7F1F1A6F69B5B8CFB447486D6B5D236AFB31C29BBD6DCFF0086880028000000000F4C0C69A5A2D5E31ED31D25F41818D17AC5A384FE27A3E6DBDAAB1F66FB33C2FBBD2DC90764000000000000000000001863E26C56D6E9133F7E4CDA7ADAD96165D6D11DFB038B3280A0000000000000B13D1007D260626DD6B6EB113F7E6CDA7AA6D9E17A5A63BF76E200000000000000000003435CF82BF5F696FB4F5B573C29F2B44F6EE0E200A0000080A2280000003B1A9BC16FAFB437DA7AA6B961479DA67B766E2000000000000000000030C6C3DAADABD6261980F9998CB74F18DD28DFD6BA3ECDB6E385B8F959A0A00008202AB1505000588CF74719DD08DFD55A3ED5B6E7853879DBFEEC0EAE0E1ECD6B5E9110CC10000000000000000000000618D8517ACD6DC27F1E6E06918138769ADBED3CA63ABE89E5A4E05712B95BED3CE27C81F3A8D8D2B44B61CEFDF5E568E1FA6BA82000A802AA36345D12D893BB7579DA787EC18E8F813896D9AFDE79447577F070A2958AD7847E7CD8E8D815C3AE55FBCF399F37AA0000000000000000000000000225AD1119CCC447599CA1A38FAD291BAB1369EBC201BD319F1E6D1C7D5B4B6FACEC4FBD7D9A76D6789339C6CC47488DCD8C2D6B59F1D663CE37C035B1356E247088B7A4FF002F09D17123E4B7B4BB74D2F0EDC2F5FBCE53F97A45A39483811A2E24FC96F697BE1EADC49E3115F598ECEC6D473979DF4AC3AF1BD7ED39CFE01E181AB695DF69DB9F6AFB37A232DD1BA21CDC5D6B58F05667CE77435EBACF122739D998E931BBED903B6AE7E06B4A4EEB44D27AF186F56D1319C4C4C758DF00C8000000000000000000001A9A669D5C3DD1F15FA728F561AC74DD8F82BE2E73FDB1FCB8B320F4C7C7B624E769CFCB947A43C814115004001514054501EB818F6C39CEB3979729F5879283BBA1E9D5C4DD3F0DBA729F46DBE6225D9D5DA6EDFC16F14709FEE8FE506F00000000000000035F4DD27FA74CFE69DD58F3EAD870758E3EDE24E5C2BF0C77906B5A666739DF33BE67ACA08A008002008002A00C84505114156B6989898DD31BE27CD8A83E8342D27FA94CFE68DD68F3EAD87075763EC5E3A5BE19ED2EF20000000000000F0D3317630ED6E79651EB3BA1F3CEBEB9BE55AD7ACCCFB47EDC8040450040025004101558A8321160140050015F43A1E2EDE1D6DCF2CA7D6374BE79D7D4B7CEB6AF4989F78FD20E88000000002080E4EBA9F8A91FE333F9FD39CE86B9F1D7E9EF2E780812A202008480892B28042A2C02AA400C958A82AA400AE8EA59F8AF1FE313F9FDB9CE86A6F1DBE8EF083B0B0C5414200115004101C8D73E3AFD3DE5CF7435CF8EBF4F7973C040511255004910041015618A8328562A0AA8A0AA802BA1A9BC76FA7BC39EE86A6F1DBE9EF00EC2B154155007FFD9;
execute sp_insert_userPhoto @user = 'yorley_maria96@gmail.com', @photoData = 0xFFD8FFE000104A46494600010100000100010000FFDB0084000906070F0E0F0F0F0E0F0F0F0F0F0F0F0D0F0F0F0F0F100F0F0F1511161615111515181D2820181A251B151521312125292B2E2E2E171F3338332C37282D2E2B010A0A0A0D0D0D0F0D0D0F2B191F192B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2BFFC000110800E000E003012200021101031101FFC4001B00010100030101010000000000000000000001020405030607FFC400301001000200020804060105000000000000000102031104051221314151C13261719122427281A1E1D113526292F0FFC4001501010100000000000000000000000000000001FFC40014110100000000000000000000000000000000FFDA000C03010002110311003F00FD700540000000000000000000000000000000000000000000000000000000000141054000000000000000000000000000000001E3A4E935C38CEDC794739907ADAD1119CCC4447199E0D1C7D6958DD48DAF39DD0E6E93A4DB1273B4EEE558E10F106DE26B0C5B7CDB3F4C64F09C7BCF1BDFFDA5E628F48C7BC70BDFFDA5EF87AC316BF36D7D519B500763035A56775E367CE37C37AB6898CE26262784C707CCBDB46D26D8739D67773ACF0941F423C745D26B8919D78F38E712F60000000000000000000000000618F8D14ACDA7847E67A3E7F1F1A6F69B5B8CFB447486D6B5D236AFB31C29BBD6DCFF0086880028000000000F4C0C69A5A2D5E31ED31D25F41818D17AC5A384FE27A3E6DBDAAB1F66FB33C2FBBD2DC90764000000000000000000001863E26C56D6E9133F7E4CDA7ADAD96165D6D11DFB038B3280A0000000000000B13D1007D260626DD6B6EB113F7E6CDA7AA6D9E17A5A63BF76E200000000000000000003435CF82BF5F696FB4F5B573C29F2B44F6EE0E200A0000080A2280000003B1A9BC16FAFB437DA7AA6B961479DA67B766E2000000000000000000030C6C3DAADABD6261980F9998CB74F18DD28DFD6BA3ECDB6E385B8F959A0A00008202AB1505000588CF74719DD08DFD55A3ED5B6E7853879DBFEEC0EAE0E1ECD6B5E9110CC10000000000000000000000618D8517ACD6DC27F1E6E06918138769ADBED3CA63ABE89E5A4E05712B95BED3CE27C81F3A8D8D2B44B61CEFDF5E568E1FA6BA82000A802AA36345D12D893BB7579DA787EC18E8F813896D9AFDE79447577F070A2958AD7847E7CD8E8D815C3AE55FBCF399F37AA0000000000000000000000000225AD1119CCC447599CA1A38FAD291BAB1369EBC201BD319F1E6D1C7D5B4B6FACEC4FBD7D9A76D6789339C6CC47488DCD8C2D6B59F1D663CE37C035B1356E247088B7A4FF002F09D17123E4B7B4BB74D2F0EDC2F5FBCE53F97A45A39483811A2E24FC96F697BE1EADC49E3115F598ECEC6D473979DF4AC3AF1BD7ED39CFE01E181AB695DF69DB9F6AFB37A232DD1BA21CDC5D6B58F05667CE77435EBACF122739D998E931BBED903B6AE7E06B4A4EEB44D27AF186F56D1319C4C4C758DF00C8000000000000000000001A9A669D5C3DD1F15FA728F561AC74DD8F82BE2E73FDB1FCB8B320F4C7C7B624E769CFCB947A43C814115004001514054501EB818F6C39CEB3979729F5879283BBA1E9D5C4DD3F0DBA729F46DBE6225D9D5DA6EDFC16F14709FEE8FE506F00000000000000035F4DD27FA74CFE69DD58F3EAD870758E3EDE24E5C2BF0C77906B5A666739DF33BE67ACA08A008002008002A00C84505114156B6989898DD31BE27CD8A83E8342D27FA94CFE68DD68F3EAD87075763EC5E3A5BE19ED2EF20000000000000F0D3317630ED6E79651EB3BA1F3CEBEB9BE55AD7ACCCFB47EDC8040450040025004101558A8321160140050015F43A1E2EDE1D6DCF2CA7D6374BE79D7D4B7CEB6AF4989F78FD20E88000000002080E4EBA9F8A91FE333F9FD39CE86B9F1D7E9EF2E780812A202008480892B28042A2C02AA400C958A82AA400AE8EA59F8AF1FE313F9FDB9CE86A6F1DBE8EF083B0B0C5414200115004101C8D73E3AFD3DE5CF7435CF8EBF4F7973C040511255004910041015618A8328562A0AA8A0AA802BA1A9BC76FA7BC39EE86A6F1DBE9EF00EC2B154155007FFD9;
select * from UsersPhotos
delete from UsersPhotos








