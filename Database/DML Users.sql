USE RRHH;
go

--------------------------- Users ------------------------------------
--drop procedure usp_get_Users
create procedure usp_get_Users as
begin
	select u.userName, u.name, u.fLastName, u.sLastName, u.email, u.phoneNumber, u.canton_id, createdDate, u.id, 
	u.direction, u.birthdate, u.[password], u.id_user , 
	(select c.name  from Cantones c where c.id_canton = u.canton_id) as canton_name,
	(select p.name  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_name,
	(select p.id_province  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_id,
	(select up.photoData from UsersPhotos up where u.id_user = up.[user_id] ) as photoData
	from Users u 
	where u.isEnabled = 1;
end
go
-- execute sp_get_User 'cjimenez13'
-- drop procedure usp_get_user
--execute sp_get_user 'cjimenez13@outlook.com'
create procedure usp_get_user 
@user nvarchar(50) as
begin
	begin 
		select u.id_user, u.userName, u.name, u.fLastName, u.sLastName, u.email, u.phoneNumber, u.canton_id, createdDate, u.id, 
		u.direction, convert(nvarchar, u.birthdate, 103) as birthdate, u.[password],
		(select c.name  from Cantones c where c.id_canton = u.canton_id) as canton_name,
		(select p.name  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_name,
		(select p.id_province  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_id,
		(select up.photoData from UsersPhotos up where up.[user_id] = u.id_user) as photoData
		from Users u 
		where u.isEnabled = 1 and (u.userName = @user or u.email = @user) ;
	end
end
go
create procedure usp_get_user_byID 
@user_id nvarchar(50) as
begin
	begin 
		select u.id_user, u.userName, u.name, u.fLastName, u.sLastName, u.email, u.phoneNumber, u.canton_id, createdDate, u.id, 
		u.direction, convert(nvarchar, u.birthdate, 103) as birthdate, u.[password],
		(select c.name  from Cantones c where c.id_canton = u.canton_id) as canton_name,
		(select p.name  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_name,
		(select p.id_province  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_id,
		(select up.photoData from UsersPhotos up where up.[user_id] = u.id_user) as photoData
		from Users u 
		where u.isEnabled = 1 and (u.id_user = @user_id) ;
	end
end
go

select * from users
delete from users where id_user = 78
--drop procedure usp_insert_user
create procedure usp_insert_user
@userName nvarchar(50) = null, @name nvarchar(50), @fLastName nvarchar(50), @sLastName nvarchar(50) = null,
@email nvarchar(50), @phoneNumber nvarchar(50) = null, @canton_id tinyint = 1, @password nvarchar(50) = 'tmp1234',
@id numeric(9,0) = null, @birthdate nvarchar(20) = null, @direction nvarchar(50) = null
 as
begin
begin transaction
	declare @user_id int;
	insert into Users(userName, name, fLastName, sLastName, email, phoneNumber, canton_id, [password], createdDate, isEnabled, id,birthdate, direction)
	values (@userName, @name, @fLastName, @sLastName, @email, @phoneNumber, @canton_id, @password, GETDATE(), 1, @id, CONVERT(DATE, @birthdate, 103), @direction );
	set @user_id = (SCOPE_IDENTITY())
	execute usp_insert_userPhoto @user = @email, @photoData = 0xFFD8FFE000104A46494600010100000100010000FFDB0084000906070F0E0F0F0F0E0F0F0F0F0F0F0F0D0F0F0F0F0F100F0F0F1511161615111515181D2820181A251B151521312125292B2E2E2E171F3338332C37282D2E2B010A0A0A0D0D0D0F0D0D0F2B191F192B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2BFFC000110800E000E003012200021101031101FFC4001B00010100030101010000000000000000000001020405030607FFC400301001000200020804060105000000000000000102031104051221314151C13261719122427281A1E1D113526292F0FFC4001501010100000000000000000000000000000001FFC40014110100000000000000000000000000000000FFDA000C03010002110311003F00FD700540000000000000000000000000000000000000000000000000000000000141054000000000000000000000000000000001E3A4E935C38CEDC794739907ADAD1119CCC4447199E0D1C7D6958DD48DAF39DD0E6E93A4DB1273B4EEE558E10F106DE26B0C5B7CDB3F4C64F09C7BCF1BDFFDA5E628F48C7BC70BDFFDA5EF87AC316BF36D7D519B500763035A56775E367CE37C37AB6898CE26262784C707CCBDB46D26D8739D67773ACF0941F423C745D26B8919D78F38E712F60000000000000000000000000618F8D14ACDA7847E67A3E7F1F1A6F69B5B8CFB447486D6B5D236AFB31C29BBD6DCFF0086880028000000000F4C0C69A5A2D5E31ED31D25F41818D17AC5A384FE27A3E6DBDAAB1F66FB33C2FBBD2DC90764000000000000000000001863E26C56D6E9133F7E4CDA7ADAD96165D6D11DFB038B3280A0000000000000B13D1007D260626DD6B6EB113F7E6CDA7AA6D9E17A5A63BF76E200000000000000000003435CF82BF5F696FB4F5B573C29F2B44F6EE0E200A0000080A2280000003B1A9BC16FAFB437DA7AA6B961479DA67B766E2000000000000000000030C6C3DAADABD6261980F9998CB74F18DD28DFD6BA3ECDB6E385B8F959A0A00008202AB1505000588CF74719DD08DFD55A3ED5B6E7853879DBFEEC0EAE0E1ECD6B5E9110CC10000000000000000000000618D8517ACD6DC27F1E6E06918138769ADBED3CA63ABE89E5A4E05712B95BED3CE27C81F3A8D8D2B44B61CEFDF5E568E1FA6BA82000A802AA36345D12D893BB7579DA787EC18E8F813896D9AFDE79447577F070A2958AD7847E7CD8E8D815C3AE55FBCF399F37AA0000000000000000000000000225AD1119CCC447599CA1A38FAD291BAB1369EBC201BD319F1E6D1C7D5B4B6FACEC4FBD7D9A76D6789339C6CC47488DCD8C2D6B59F1D663CE37C035B1356E247088B7A4FF002F09D17123E4B7B4BB74D2F0EDC2F5FBCE53F97A45A39483811A2E24FC96F697BE1EADC49E3115F598ECEC6D473979DF4AC3AF1BD7ED39CFE01E181AB695DF69DB9F6AFB37A232DD1BA21CDC5D6B58F05667CE77435EBACF122739D998E931BBED903B6AE7E06B4A4EEB44D27AF186F56D1319C4C4C758DF00C8000000000000000000001A9A669D5C3DD1F15FA728F561AC74DD8F82BE2E73FDB1FCB8B320F4C7C7B624E769CFCB947A43C814115004001514054501EB818F6C39CEB3979729F5879283BBA1E9D5C4DD3F0DBA729F46DBE6225D9D5DA6EDFC16F14709FEE8FE506F00000000000000035F4DD27FA74CFE69DD58F3EAD870758E3EDE24E5C2BF0C77906B5A666739DF33BE67ACA08A008002008002A00C84505114156B6989898DD31BE27CD8A83E8342D27FA94CFE68DD68F3EAD87075763EC5E3A5BE19ED2EF20000000000000F0D3317630ED6E79651EB3BA1F3CEBEB9BE55AD7ACCCFB47EDC8040450040025004101558A8321160140050015F43A1E2EDE1D6DCF2CA7D6374BE79D7D4B7CEB6AF4989F78FD20E88000000002080E4EBA9F8A91FE333F9FD39CE86B9F1D7E9EF2E780812A202008480892B28042A2C02AA400C958A82AA400AE8EA59F8AF1FE313F9FDB9CE86A6F1DBE8EF083B0B0C5414200115004101C8D73E3AFD3DE5CF7435CF8EBF4F7973C040511255004910041015618A8328562A0AA8A0AA802BA1A9BC76FA7BC39EE86A6F1DBE9EF00EC2B154155007FFD9;

	insert into PersonalAttributes (attribute_id, value, [user_id]) 
	select ca.id_attribute, ca.value, @user_id from CategorieAttributes ca where ca.isGeneral = 0
commit transaction
end
go

--drop procedure sp_get_provinces
create procedure usp_get_provinces as
begin
	select id_province, name from Provinces;
end
go

--drop procedure usp_get_cantones
create procedure usp_get_cantones 
@province_id tinyint as
begin
	select c.id_canton, c.name, c.province_id, p.name as province_name from Cantones c inner join Provinces p on c.province_id = p.id_province
	where c.province_id = @province_id;
end
go

-- drop procedure usp_insert_userImage
create procedure usp_insert_userImage
@user_id int, @image_data varbinary(max)
as
begin
	insert into UsersPhotos([user_id], photoData)
	values (@user_id, @image_data);
end
go

--drop procedure usp_update_user
create procedure usp_update_user
@user nvarchar(50), @userName nvarchar(50) = null, @name nvarchar(50), @fLastName nvarchar(50), @sLastName nvarchar(50) = null,
@email nvarchar(50), @phoneNumber nvarchar(50) = null, @canton_id tinyint = 1, @password nvarchar(50) = 'tmp1234',
@id numeric(9,0) = null, @birthdate nvarchar(20) = null, @direction nvarchar(50) = null, @photo varbinary(MAX) = null
 as
begin
begin transaction 
		declare @id_user int = (select id_user from Users where email = @email)
		update Users set userName = isnull(@userName,userName),
				     name = ISNULL(@name, name),
					 fLastName = ISNULL(@fLastName, fLastName),
					 sLastName = ISNULL(@sLastName, sLastName),
					 email = ISNULL (@email, email),
					 phoneNumber = ISNULL(@phoneNumber, phoneNumber),
					 canton_id = ISNULL(@canton_id,canton_id),
					 [password] = ISNULL(@password,[password]),
					 id = ISNULL(@id, id),
					 birthdate = ISNULL(try_convert(DATE,@birthdate,103), birthdate),
					 direction = ISNULL(@direction, direction)
		where email = @email or userName = @userName
		update UsersPhotos set photoData = ISNULL(@photo, photoData)
		where [user_id] = @id_user;
commit transaction
end
go


--drop procedure usp_update_userPhoto
create procedure usp_update_userPhoto
@user nvarchar(50), @photoData varbinary(MAX)
 as
begin
	declare @id int;
	set @id = (select [id_user] from Users where email = @user or userName = @user);
	update UsersPhotos set photoData = @photoData where [user_id] = @id;
end
go
select * from UsersPhotos
--drop procedure usp_insert_userPhoto
create procedure usp_insert_userPhoto
@user nvarchar(50), @photoData varbinary(MAX)
 as
begin
	declare @id int;
	set @id = (select [id_user] from Users where email = @user or userName = @user);
	insert into UsersPhotos([user_id],photoData) 
	values (@id, @photoData);
end
go
-- drop procedure usp_insert_userFile
create procedure usp_insert_userFile
@user_id nvarchar(50), @fileData varbinary(MAX), @name nvarchar(30), @description nvarchar(50) = null, @fileType nvarchar(100), @fileName nvarchar(200)
as
begin
	insert into UsersFiles([user_id],fileData, name, [description], createdDate, fileType, [fileName]) 
	values (@user_id, @fileData, @name, @description,GETDATE(), @fileType, @fileName);
end
go
-- drop procedure usp_get_userFiles
create procedure usp_get_userFiles
@user nvarchar(50)
as
begin
	declare @id int;
	set @id = (select [id_user] from Users where email = @user or userName = @user);
	select uf.name,uf.createdDate,uf.[description],uf.id_file,uf.fileType, uf.[fileName], CONVERT(varbinary(max),uf.fileData) as fileData from UsersFiles uf where uf.[user_id] = @id
end
go

-- drop procedure sp_delete_userFile
create procedure usp_delete_userFile
@id_file nvarchar(50)
as
begin
	delete from UsersFiles where id_file = @id_file;
	select @@ROWCOUNT 
end