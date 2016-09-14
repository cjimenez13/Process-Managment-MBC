execute sp_insert_group 'Recursos Humanos'
execute sp_insert_groupUser 75, 1
execute sp_insert_groupUser 76, 1
select * from Groups
select * from Users
select * from Group_Users
------------------------------- Groups -------------------------------
create procedure sp_get_groups as
begin
	select g.id_group, g.groupName, g.createdDate, g.isEnabled
	from Groups g 
end
go

create procedure sp_get_group
@group_id int as
begin
	select g.id_group, g.groupName, g.createdDate, g.isEnabled
	from Groups g 
	where g.id_group = 1
end
go

create procedure sp_get_groupMembers
@group_id int as
begin
	select g.id_group, u.name, u.id_user, u.fLastName, u.sLastName, u.email, u.[userName], (select photoData from UsersPhotos up where up.[user_id] = u.id_user) as photoData
	from Groups g inner join Group_Users gu on g.id_group = gu.group_id left outer join Users u on u.id_user = gu.[user_id]
	where g.id_group = @group_id
end
go

create procedure sp_insert_group
@groupName nvarchar(50)
as
begin
	insert into Groups(groupName, createdDate, isEnabled)
	values (@groupName, GETDATE(), 1)
end
go

create procedure sp_update_group
@id_group int, @groupName nvarchar(50)
as
begin 
	update Groups set groupName =  @groupName
	where id_group = @id_group
end
go

create procedure sp_delete_group
@id_group int
as
begin 
	delete from Groups where @id_group = id_group
	select @@ROWCOUNT 
end
go

----------------------- Users Groups ----------------------------
create procedure sp_insert_groupUser 
@user_id int, @group_id int as
begin
	insert into Group_Users ([user_id], group_id)
	values (@user_id, @group_id)
end
go

