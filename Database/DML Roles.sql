USE RRHH;
go

--------------- Roles -----------------
create procedure sp_insert_role
@name nvarchar(30), @description nvarchar(50) = null as
begin
	insert into Roles(name,[description])
	values (@name, @description);

	insert into Roles_Permissions
	select (SELECT TOP 1 id_role FROM Roles ORDER BY id_role DESC), per.id_permission, 0 from Permissions per 
	-- Copy the avaible elements
	insert into Roles_Permissions_Elements
	select rp.id_role_permission, ele.id_element, 0 as isEnabled 
	from Elements ele inner join Roles_Permissions rp on rp.permission_id = ele.permission_id
	where (SELECT TOP 1 id_role FROM Roles ORDER BY id_role DESC) = rp.role_id
	SELECT TOP 1 id_role FROM Roles ORDER BY id_role DESC
end
go

create procedure sp_delete_role
@id_role int
as
begin 
	delete from Roles where @id_role = id_role
	select @@ROWCOUNT 
end
go

create procedure sp_get_roles
as
begin
	select r.id_role, r.name, r.[description], count(rp.role_id) as [permissions]
	from Roles r left outer join Roles_Permissions rp on r.id_role = rp.role_id
	group by r.id_role, r.name, r.[description]
end
go

create procedure sp_get_role
@id_role int as
begin
	select id_role, name, [description] from Roles  where id_role = @id_role
end
go

create procedure sp_get_rolePermissions_byModule
@role_id int, @id_module int as
begin
	select per.id_permission, per.name, per.module_id, rp.isEnabled, rp.id_role_permission
	from Permissions per inner join Roles_Permissions rp on per.id_permission = rp.permission_id
	where per.module_id = @id_module and rp.role_id = @role_id
end
go

create procedure sp_update_rolePermission
@role_id int, @permission_id int, @isEnabled bit as
begin 
	update Roles_Permissions set isEnabled = @isEnabled
	where @role_id = role_id and @permission_id = permission_id
end 
go
--------------------------------- Permissions -----------------------------------------
create procedure sp_insert_permission
@id_permission int, @name nvarchar(50), @module_id tinyint 
as
begin
	insert into Permissions(id_permission, name, module_id)
	values (@id_permission, @name, @module_id)
end
go
create procedure sp_update_rolePermission
@id_role_permission int, @isEnabled bit as
begin 
	update Roles_Permissions set isEnabled = @isEnabled
	where @id_role_permission = id_role_permission
end 
go

--------------------------------- Modulos ------------------------------
create procedure sp_insert_module
@id_module tinyint, @name nvarchar(50)
as
begin
	insert into Modules(id_module, name)
	values (@id_module, @name)
end
go

create procedure sp_get_modules as
begin
	select id_module, name from Modules order by id_module
end
go 

-------------------------------  Elementos ----------------------------------
create procedure sp_insert_element
@name nvarchar(50), @type_id tinyint, @permission_id int
as
begin
	insert into Elements(name, type_id,permission_id)
	values (@name, @type_id, @permission_id)
end
go

create procedure sp_insert_typesElement
@id_elementType tinyint, @type nvarchar(50)
as
begin
	insert into ElementTypes(id_elementType, type)
	values (@id_elementType, @type)
end
go

create procedure sp_get_Elements
@role_permission_id int
as
begin
	select rpe.role_permission_id, rpe.isEnabled, e.name, rpe.element_id, (select et.[type] from ElementTypes et where et.id_elementType = e.type_id) as [type]
	from Roles_Permissions_Elements rpe inner join Elements e on rpe.element_id = e.id_element
	where rpe.role_permission_id = @role_permission_id

end
go

create procedure sp_update_roleElement
@element_id int, @role_permission_id int, @isEnabled bit as
begin 
	update Roles_Permissions_Elements set isEnabled = @isEnabled
	where @element_id = element_id and @role_permission_id = role_permission_id
end 
go

----------------- Users Roles ----------------------- 
create procedure sp_get_userRoles
@user_id int
as
begin 
	select r.id_role, r.name, r.[description], ur.[user_id] from Roles r inner join Users_Roles ur on r.id_role = ur.role_id 
	where ur.[user_id] = @user_id
end
go

create procedure sp_insert_userRole
@user_id int, @role_id int as
begin
	insert into Users_Roles([user_id],role_id)
	values (@user_id, @role_id)
end
go



create procedure sp_get_userPermissions
@user_id int as
begin 
	select ur.role_id, ur.[user_id], rp.id_role_permission
	from Users_Roles ur left outer join Roles_Permissions rp on rp.role_id = ur.role_id
	where ur.[user_id] = 59
end
go

create procedure sp_get_userElements
@user_id int, @isEnabled int as
begin 
	select distinct rpe.element_id, e.name, (select type from ElementTypes et where et.id_elementType = e.[type_id]) as [type]
	from Users_Roles ur inner join Roles_Permissions rp on rp.role_id = ur.role_id
	inner join Roles_Permissions_Elements rpe on rp.id_role_permission= rpe.role_permission_id
	left outer join Elements e on e.id_element = rpe.element_id
	where ur.[user_id] = 59 and rpe.isEnabled = 0
end
go

select * from Users
execute sp_insert_userRole 59, 127
select * from Roles