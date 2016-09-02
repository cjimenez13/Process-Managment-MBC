USE RRHH;
go

--  Insert ObjectLog
create procedure sp_insert_ObjectLog
@table_name nvarchar(30) as 
begin
	insert into ObjectLog(name, postTime, computer, userName, CHKsum)
	values (@table_name, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end
go

--  Insert EventSourceLog
create procedure sp_insert_EventSourceLog
@name nvarchar(30) as 
begin
	insert into EventSourceLog(sourceName, postTime, computer, userName, CHKsum)
	values (@name, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end
go


--  Insert EventTypeLog
create procedure sp_insert_EventTypeLog
@name nvarchar(30) as 
begin
	insert into EventTypeLog(name, postTime, computer, userName, CHKsum)
	values (@name, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end
go

-- Insert EventLog
create procedure sp_insert_EventLog
@description nvarchar(50), @objectLog_id bigint, @eventTypeLog_id bigint, @eventSource_id int as 
begin
	insert into EventLog(description, objectLog_id, eventTypeLog_id, eventSourceLog_id, postTime, computer, userName, CHKsum)
	values (@description, @objectLog_id, @eventTypeLog_id, @eventSource_id, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end
go

create procedure sp_insert_Reference
@attribute nvarchar(50), @value nvarchar(50), @EventLog_id bigint as
begin
	insert into Reference(attribute, value, postTime, computer, userName, CHKsum)
	values (@attribute, @value, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
	insert into Reference_by_EventLog (Reference_id, eventLog_id, postTime, computer, userName, CHKsum)
	values (IDENT_CURRENT('Reference_by_EventLog'), @EventLog_id, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end
go



--------------------------- Users ------------------------------------

--Select users
--drop procedure sp_get_Users
create procedure sp_get_Users as
begin
	select u.userName, u.name, u.fLastName, u.sLastName, u.email, u.phoneNumber, u.canton_id, createdDate, u.id, 
	u.direction, u.birthdate, u.[password],
	(select c.name  from Cantones c where c.id_canton = u.canton_id) as canton_name,
	(select p.name  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_name,
	(select p.id_province  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_id
	from Users u 
	where u.isEnabled = 1;
end
go

-- Get specific user
-- execute sp_get_User 'cjimenez13'
-- drop procedure sp_get_user
create procedure sp_get_user 
@user nvarchar(50) as
begin
	if CHARINDEX('@',@user) > 0
	begin
		select u.userName, u.name, u.fLastName, u.sLastName, u.email, u.phoneNumber, u.canton_id, createdDate, u.id, 
		u.direction, convert(nvarchar, u.birthdate, 103) as birthdate, u.[password],
		(select c.name  from Cantones c where c.id_canton = u.canton_id) as canton_name,
		(select p.name  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_name,
		(select p.id_province  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_id
		from Users u 
		where u.isEnabled = 1 and u.email = @user;
	end
	else
	begin 
		select u.userName, u.name, u.fLastName, u.sLastName, u.email, u.phoneNumber, u.canton_id, createdDate, u.id, 
		u.direction, convert(nvarchar, u.birthdate, 103) as birthdate, u.[password],
		(select c.name  from Cantones c where c.id_canton = u.canton_id) as canton_name,
		(select p.name  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_name,
		(select p.id_province  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_id
		from Users u 
		where u.isEnabled = 1 and u.userName = @user;
	end
	
end
go


--Insert users
--drop procedure sp_insert_User
create procedure sp_insert_user
@userName nvarchar(50) = null, @name nvarchar(50), @fLastName nvarchar(50), @sLastName nvarchar(50) = null,
@email nvarchar(50), @phoneNumber nvarchar(50) = null, @canton_id tinyint = 1, @password nvarchar(50) = 'tmp1234',
@id numeric(9,0) = null, @birthdate nvarchar(20) = null, @direction nvarchar(50) = null
 as
begin
	insert into Users(userName, name, fLastName, sLastName, email, phoneNumber, canton_id, [password], createdDate, isEnabled, id,birthdate, direction)
	values (@userName, @name, @fLastName, @sLastName, @email, @phoneNumber, @canton_id, @password, GETDATE(), 1, @id, CONVERT(DATE, @birthdate, 103), @direction );
end
go

--Get Provinces
create procedure sp_get_provinces as
begin
	select id_province, name from Provinces;
end
go

--Get Cantones

create procedure sp_get_cantones 
@province_id tinyint as
begin
	select c.id_canton, c.name, c.province_id, p.name as province_name from Cantones c inner join Provinces p on c.province_id = p.id_province
	where c.province_id = @province_id;
end
go

create procedure sp_insert_userImage
@user_id int, @image_data varbinary(max)
as
begin
	insert into UsersPhotos([user_id], photoData)
	values (@user_id, @image_data);
end
go

--Insert users
--drop procedure sp_update_User
create procedure sp_update_user
@user nvarchar(50), @userName nvarchar(50) = null, @name nvarchar(50), @fLastName nvarchar(50), @sLastName nvarchar(50) = null,
@email nvarchar(50), @phoneNumber nvarchar(50) = null, @canton_id tinyint = 1, @password nvarchar(50) = 'tmp1234',
@id numeric(9,0) = null, @birthdate nvarchar(20) = null, @direction nvarchar(50) = null, @photo varbinary(MAX)
 as
begin
	if CHARINDEX('@',@user) > 0
	begin
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
		where email = @email
		update UsersPhotos set photoData = ISNULL(@photo, photoData)
		where [user_id] = @id_user 

		
	end
	else
	begin
		declare @id_user_ int = (select id_user from Users where userName = @userName)
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
			where userName = @userName
		update UsersPhotos set photoData = ISNULL(@photo, photoData)
		where [user_id] = @id_user_ 
	end
end
go
