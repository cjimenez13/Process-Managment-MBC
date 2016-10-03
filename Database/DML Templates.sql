exec usp_insert_template 'solicitud vacaciones', 17, 75
exec usp_insert_template 'Aumeento vacaciones', 17, 75

--drop procedure usp_get_templates
create procedure usp_get_templates as
begin
	select pm.id_ProcessManagment, pm.name, pm.createdBy, pm.createdDate, pm.categorie_id, c.name as categorie_name
	from ProcessManagment pm inner join Categories c on pm.categorie_id = c.id_categorie
	where pm.isProcess = 0 
end
go 

--drop procedure usp_get_template
create procedure usp_get_template 
@id_template bigint as
begin 
	select pm.id_ProcessManagment, pm.name, pm.createdBy, pm.createdDate, pm.categorie_id, c.name as categorie_name
	from ProcessManagment pm inner join Categories c on pm.categorie_id = c.id_categorie
	where pm.id_processManagment = @id_template and pm.isProcess = 0
end 
go
--drop procedure usp_insert_template
create procedure usp_insert_template
@name nvarchar(100), @categorie_id int = null, @userLog int as
begin
begin transaction 
	declare @processManagment_id  int, @event_log_id int, @table int
	insert into ProcessManagment (name, createdBy, createdDate, categorie_id, isProcess)
	values (@name, @userLog, GETDATE(), @categorie_id,0)
	set @processManagment_id = (SCOPE_IDENTITY())
	insert into Template (processManagment_id) values (@processManagment_id)

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Template')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted template', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'categorie_id', @value = @categorie_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_template', @value = @processManagment_id, @EventLog_id = @event_log_id
commit transaction 
end
go
-- drop procedure usp_update_template
create procedure usp_update_template
@id_template bigint, @name nvarchar(100), @userLog int as
begin 
begin transaction
	declare @event_log_id int, @table int
	update ProcessManagment set name = @name where id_processManagment = @id_template

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Template')
	exec @event_log_id = usp_insert_EventLog @description = 'updated template', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_template', @value = @id_template, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
commit transaction
end
go
-- drop procedure usp_delete_template
create procedure usp_delete_template 
@id_template bigint, @userLog int as 
begin 
begin transaction 
	declare @processManagment_id  int, @event_log_id int, @table int
	delete from ProcessManagment where id_processManagment = @id_template
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Template')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted template', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_template', @value = @id_template, @EventLog_id = @event_log_id
commit transaction
end
go

-----------------------------------------------  Participants  ---------------------------------------------------
-- drop procedure usp_get_process_participants
create procedure usp_get_process_participants 
@id_processManagment bigint as 
begin 
	select part.processManagment_id, part.[user_id], u.name, u.sLastName, u.fLastName, u.userName, u.email,
	(select up.photoData from UsersPhotos up where u.id_user = up.[user_id] ) as photoData
	from (select pp.processManagment_id, pp.[user_id] 	from Process_Participants pp where pp.processManagment_id = @id_processManagment) part 
	inner join Users u on part.[user_id] = u.id_user
	where u.isEnabled = 1
end
go 
-- drop procedure usp_insert_process_participant
-- exec usp_insert_process_participant 1, 75, 75
select * from ProcessManagment
create procedure usp_insert_process_participant
@id_processManagment bigint, @user_id int, @userLog int as
begin
begin transaction
	declare @event_log_id int, @table int
	insert into Process_Participants (processManagment_id, [user_id])
	values (@id_processManagment, @user_id)
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Process_Participants')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted participant', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_template', @value = @id_processManagment, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
commit transaction
end
go

create procedure usp_insert_processGroup
@id_processManagment bigint, @group_id int, @userLog int as
begin
begin transaction
	declare @event_log_id int, @table int

	declare cursor_users cursor
	for select gu.[user_id] from Group_Users gu where gu.group_id = @group_id 
	declare @user_id nvarchar(30);
	open cursor_users
	fetch next from cursor_users into @user_id
	while @@FETCH_STATUS = 0 
	begin 
		insert into Process_Participants (processManagment_id, [user_id])
		values (@id_processManagment, @user_id)

		set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Process_Participants')
		exec @event_log_id = usp_insert_EventLog @description = 'inserted participant', 
		@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
		exec usp_insert_Reference @attribute = 'id_template', @value = @id_processManagment, @EventLog_id = @event_log_id
		exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id

		fetch next from cursor_users into @user_id
	end
	close cursor_users
	deallocate cursor_users
commit transaction
end
go

-- drop procedure usp_delete_process_participant
create procedure usp_delete_process_participant
@id_processManagment bigint, @user_id int, @userLog int as 
begin 
begin transaction
	declare @event_log_id int, @table int
	delete from Process_Participants where processManagment_id = @id_processManagment and [user_id] = @user_id
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Process_Participants')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted participant', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_template', @value = @id_processManagment, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
commit transaction
end 
go

----------------------------------------------- Stages ----------------------------------------
-- drop procedure usp_get_process_stages
create procedure usp_get_process_stages
@id_processManagment bigint as
begin 
	select s.id_stage, s.name, s.processManagment_id, s.stagePosition, s.createdBy, s.createdDate 
	from Stage s where  s.processManagment_id = @id_processManagment
	order by s.stagePosition
end
go

create procedure usp_get_process_stage 
@id_stage bigint as
begin 
	select s.id_stage, s.name, s.processManagment_id, s.stagePosition, s.createdBy, s.createdDate 
	from Stage s where  s.id_stage = @id_stage
end
go

--select * from ProcessManagment
--exec usp_insert_stage 'Aceptar formulario', 1, 1, 75
--select * from Stage
delete from Stage
create procedure usp_insert_stage
@name nvarchar(100), @processManagment_id bigint, @stagePosition int, @userLog int as
begin 
begin transaction 
	declare @id_stage int, @event_log_id int, @table int
	insert into Stage (name, processManagment_id, stagePosition, createdBy, createdDate)
	values (@name, @processManagment_id, @stagePosition, @userLog, GETDATE())
	set @id_stage = (SCOPE_IDENTITY())

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Stage')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted stage', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'processManagment_id', @value = @processManagment_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'stagePosition', @value = @stagePosition, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_stage', @value = @id_stage, @EventLog_id = @event_log_id
commit transaction 
end
go

create procedure usp_update_stage 
@id_stage bigint, @name nvarchar(100) = null, @stagePosition int = null, @userLog int as
begin
begin transaction 
	declare @event_log_id int, @table int
	update Stage set name = ISNULL(@name, name),
					stagePosition = ISNULL(@stagePosition, stagePosition)
	where id_stage = @id_stage

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Stage')
	exec @event_log_id = usp_insert_EventLog @description = 'updated stage', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'stagePosition', @value = @stagePosition, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_stage', @value = @id_stage, @EventLog_id = @event_log_id
commit transaction 
end
go

create procedure usp_delete_stage
@id_stage bigint, @userLog int as
begin 
begin transaction 
	declare @event_log_id int, @table int
	delete from Stage where id_stage = @id_stage
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Stage')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted stage', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_stage', @value = @id_stage, @EventLog_id = @event_log_id
commit transaction 
end 
 