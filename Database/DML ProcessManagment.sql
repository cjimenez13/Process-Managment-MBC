
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
go

-------------------------------------------- Tasks --------------------------------------------------
-- drop procedure usp_get_process_tasks
create procedure usp_get_process_tasks
@id_stage bigint as
begin 
	select t.id_task, t.stage_id, t.name, t.[description], t.[type_id], t.taskState_id, t.completedDate, t.createdBy, t.finishDate, t.taskPosition, t.createdDate, t.beginDate
	from Task t where t.stage_id = @id_stage
	order by t.taskPosition
end
go
-- drop procedure usp_get_process_task
create procedure usp_get_process_task
@id_task bigint as
begin 
	select t.id_task, t.stage_id, t.name, t.[description], t.[type_id], t.taskState_id, t.completedDate, t.createdBy, t.finishDate, t.taskPosition, t.createdDate, t.beginDate
	from Task t where t.id_task = @id_task
	order by t.taskPosition
end
go

declare @finishDate date
set @finishDate = GETDATE();
exec usp_insert_task @stage_id = 8, @name = 'Completar solicitud ', @description = 'Formulario de vacaciones', @type_id = 0, @userLog = 75, @finishDate = @finishDate, @taskPosition = 0 
select * from Task
select * from stage
select * from Users

-- drop procedure usp_insert_task
create procedure usp_insert_task
@stage_id int, @name nvarchar(50), @description nvarchar(100), @type_id int, @userLog int, @finishDate date, @taskPosition int as 
begin 
begin transaction 
	declare @id_task int, @event_log_id int, @table int
	insert into Task (stage_id, name, [description], [type_id], taskState_id, completedDate, createdBy, finishDate, taskPosition, createdDate, beginDate)
	values (@stage_id, @name, @description, @type_id, 0, null, @userLog, @finishDate, @taskPosition, GETDATE(), null)
	set @id_task = (SCOPE_IDENTITY())

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Task')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted task', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_task', @value = @id_task, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'stage_id', @value = @stage_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'description', @value = @description, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'finishDate', @value = @finishDate, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'taskPosition', @value = @taskPosition, @EventLog_id = @event_log_id
commit transaction 
end
go

-- drop procedure usp_update_task
create procedure usp_update_task
@id_task int, @name nvarchar(50)=null, @description nvarchar(150)=null, @type_id int=null, @userLog int, @taskState_id int=null, 
@completedDate date = null, @finishDate datetime=null, @taskPosition int=null, @beginDate datetime=null as
begin
begin transaction 
	declare @event_log_id int, @table int
	update Task set name = ISNULL(@name, name),
					[description] = ISNULL(@description, [description]),
					[type_id] = ISNULL(@type_id, [type_id]),
					taskState_id = ISNULL(@taskState_id, taskState_id),
					completedDate = ISNULL(@completedDate, completedDate),
					finishDate = ISNULL(@finishDate, finishDate),
					taskPosition = ISNULL(@taskPosition, taskPosition),
					beginDate = ISNULL(@beginDate, beginDate)
	where id_task = @id_task

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Task')
	exec @event_log_id = usp_insert_EventLog @description = 'updated task', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'description', @value = @description, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'taskState_id', @value = @taskState_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'completedDate', @value = @completedDate, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'finishDate', @value = @finishDate, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'taskPosition', @value = @taskPosition, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'beginDate', @value = @beginDate, @EventLog_id = @event_log_id
commit transaction 
end
go

create procedure usp_delete_task
@id_task bigint, @userLog int as
begin 
begin transaction 
	declare @event_log_id int, @table int
	delete from Task where id_task = @id_task
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Task')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted task', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_task', @value = @id_task, @EventLog_id = @event_log_id
commit transaction 
end 
go

--------------------------- Task types --------------------------------

create procedure usp_get_taskTypes as
begin 
	select tt.id_taskType, tt.taskName, tt.needConfirm, tt.formNeeded
	from TaskType tt 
end
go 

create procedure usp_get_taskStates as 
begin 
	select ts.id_taskState, state_name, state_color
	from taskState ts
end
go

create procedure usp_get_taskState 
@id_taskState int as 
begin 
	select ts.id_taskState, state_name, state_color
	from taskState ts
	where ts.id_taskState = @id_taskState
end

