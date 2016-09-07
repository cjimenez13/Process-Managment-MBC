USE RRHH;
go

--------------- Roles list -----------------
--drop procedure sp_insert_role
create procedure sp_insert_role
@name nvarchar(30), @description nvarchar(50) = null as
begin
	insert into Roles(name,[description])
	values (@name, @description);
	SELECT SCOPE_IDENTITY() as id_role;
end
go

drop procedure sp_delete_role
create procedure sp_delete_role
@id_role int
as
begin 
	delete from Roles where @id_role = id_role
	select @@ROWCOUNT 
end
go


--drop procedure sp_get_roles
create procedure sp_get_roles
as
begin
	select r.id_role, r.name, r.[description], count(rp.role_id) as [permissions]
	from Roles r left outer join Roles_Permissions rp on r.id_role = rp.role_id
	group by r.id_role, r.name, r.[description]
end
go

------------------ Permissions ------------------------------
create procedure sp_get_rolePermissions
@role_id int as
begin
	select per.id_permission, per.[description], rp.isEnabled 
	from [Permissions] per right outer join Roles_Permissions rp on rp.permission_id = per.id_permission
	where rp.role_id = role_id
end
go

create procedure sp_update_rolePermission
@role_id int, @permission_id int, @isEnabled bit as
begin 
	update Roles_Permissions set isEnabled = @isEnabled
	where @role_id = role_id and @permission_id = permission_id
end 
go


----------------- Users Roles ----------------------- 
create procedure sp_get_userRoles
@user_id int
as
begin 
	select r.id_role, r.name, r.[description] from Roles r inner join Users_Roles ur on r.id_role = ur.role_id 
	where ur.role_id = @user_id
end
go

create procedure sp_insert_userRole
@user_id int, @role_id int as
begin
	insert into Users_Roles([user_id],role_id)
	values (@user_id, @role_id)
end
go

create procedure sp_delete_userRole
@user_id int, @role_id int as
begin 
	delete from Users_Roles where [user_id] = @user_id and role_id = @role_id
end
go

