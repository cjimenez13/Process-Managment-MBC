declare @count int, @group_id int, @temporalName nvarchar(100)
set @count = 0
while @count <= 50 
begin 
	set @temporalName = 'Grupo '+ Convert(varchar(50), @count)
	insert into Groups(groupName, createdDate, isEnabled)
	values (@temporalName, GETDATE(), 1)
	set @group_id = (select SCOPE_IDENTITY())
	set @count = @count + 1
	exec usp_insert_groupUser @user_id = 75, @group_id = @group_id
	exec usp_insert_groupUser @user_id = 76, @group_id = @group_id
	exec usp_insert_groupUser @user_id = 77, @group_id = @group_id
	exec usp_insert_groupUser @user_id = 80, @group_id = @group_id
end

select * from Groups
select * from Group_Users
delete from Group_Users
delete from Groups